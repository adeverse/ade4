"loocv" <- function(x, ...) {
    UseMethod("loocv")
}

loocv.between <- function(x, nax = 0, progress = FALSE, parallel = FALSE, ...)
    ## Leave-one-out cross-validation for bca
    ## x = the bca to be cross-validated
    ## nax = list of axes for mean overlap index computation (0 = all axes)
    ## progress = logical, TRUE = display a progress bar
    ## parallel = logical, TRUE = process cross-validation in parallel computing
    ## Note that parallel computing should be used only for large tables to avoid overhead
    ## Returns a list with the cross-validated row coordinates (XValCoord),
    ## the predicted residual error sum of squares for each individual (PRESS),
    ## the sum of PRESS for each axis (PRESSTot)
    ## and the mean overlap index for BGA (Oij_bga) and for cross-validation (Oij_XVal).
    #
{
    if (!inherits(x, "dudi")) 
        stop("Object of class dudi expected")
    if (!inherits(x, "between")) 
        stop("Object of class between expected")
    bcaCall <- x$call
    nf1 <- x$nf
    ## Get the parameters of the original analysis:
    ## dudi, factor, and number of rows
    dudiCall <- eval.parent(bcaCall[[2]])
    fac1 <- eval.parent(bcaCall[[3]])
    ng1 <- nlevels(fac1)
	lev1 <- levels(fac1)
    nifac1 <- table(fac1)
    lnax1 <- length(nax)
    if (lnax1 == 1) if (nax == 0) nax <- 1:nf1
    lig1 <- nrow(dudiCall$tab)
    lw1 <- dudiCall$lw
    if (length(fac1) != lig1) 
        stop("Non convenient dimension")
    xcoo1 <- as.data.frame(matrix(0, lig1, nf1))
    mean.w <- function(x, w, fac, cla.w) {
        z <- x * w
        z <- tapply(z, fac, sum)/cla.w
        return(z)
    }
    if (progress) pb <- progress::progress_bar$new(total = lig1,
        format = "  bgPCA cross-validation [:bar] :percent eta: :eta")
	if (parallel) {
		if (!(requireNamespace("doParallel", quietly = TRUE))) stop("You shoul install the doParallel package in order to use the `parallel = TRUE' option")
		doParallel::registerDoParallel(parallel::detectCores(all.tests=TRUE))
	}
	trt1 <- function(dudiCall, fac1, nf1, x, ind1) {
		# This is the function executed in parallel mode
        ## Remove each row of the data table, one at a time,
        ## then do the analysis and the bca on the new table
        ## and estimate the coordinates of the missing row
        #
        ## The original analysis can be any dudi, so wee need to start from dudiCall$call:
        jcall1 <- dudiCall$call
        ## Change the df argument to discard row #ind1:
        jcall1[[2]] <- data.frame(eval.parent(jcall1[[2]], n = 2))[-ind1, , drop = FALSE]
        ## Check that the scannf argument is set to FALSE:
        if (any(names(jcall1) == "scannf")) jcall1[[which(names(jcall1) == "scannf")]] <- FALSE
        else {
            ## If scannf is not in the args list, add it and is set to FALSE:
            jcall1[[length(jcall1) + 1]] <- quote(FALSE)
            names(jcall1)[length(jcall1)] <- "scannf"
        }
        ## Run the analysis without row #ind1:
        if (inherits(dudiCall, "fca") || inherits(dudiCall, "fpca")) {
            colblo1 <- attr(jcall1[[2]],  "col.blocks")
            jcall1[[2]] <- prep.fuzzy.var(jcall1[[2]], colblo1)
        }
        jdudi1 <- eval.parent(jcall1)
        ## Check that axes are in the same direction as orignal analysis axes;
        ## if not, change the sign
        ##        for (j in 1:nf1)
        #	        if (cor(jdudi1$li[,j], dudiCall$li[-ind1,j]) < 0) jdudi1$li[,j] <- -jdudi1$li[,j]
        ## then do the BGA on this analysis:
        jfac1 <- fac1[-ind1]
        cla.w1 <- tapply(jdudi1$lw, jfac1, sum)
        tabmoy <- apply(jdudi1$tab, 2, mean.w, w = jdudi1$lw, fac = jfac1, cla.w = cla.w1)
        tabmoy <- data.frame(tabmoy)
        jres <- as.dudi(tabmoy, jdudi1$cw, as.vector(cla.w1), scannf = FALSE, 
            nf = nf1, call = match.call(), type = "bet")
        ## Check that jackknifed axes are in the same direction as  original bca axes;
        ## if not, change the sign
        if (nf1 > 1) for (j in 1:nf1)
            if (stats::cor(jres$c1[,j], x$c1[,j]) < 0) jres$c1[,j] <- -jres$c1[,j]
        U <- as.matrix(jres$c1) * unlist(jres$cw)
        ## Compute #ind1 row coordinates in this BGA and store it in xcoo1:
        return(as.matrix(dudiCall$tab[ind1,]) %*% U)     
    }
	# Compute mean overlap index (oijb1m) for bca
	# Compute all distances between each individual and the mean of his group
	oij1 <- matrix(0, nrow = lig1, ncol = ng1)
	for (ind1 in 1:lig1) {
		for (gr1 in 1:ng1) {
			oij1[ind1, gr1] <- sqrt(sum((x$ls[ind1, nax] - x$li[gr1, nax])^2))
		}
	}
	# Compute the number of individuals nearer to another group mean
	oijb1 <- matrix(0, nrow = ng1, ncol = ng1)
	for (gr1 in 1:ng1) {
		for (gr2 in 1:ng1) {
			oijb1[gr1, gr2] <- sum(oij1[fac1==lev1[gr1], gr2] < oij1[fac1==lev1[gr1], gr1])/nifac1[gr1]
		}
	}
	# Mean overlap index
	oijb1m <- mean(oijb1)
	# LOOCV loop on individuals
	if (parallel) {
		# Note: Use function syntax of %dopar% operator, since foreach is not imported (thanks Aurelie)
		xcoo1 <- foreach::"%dopar%"(foreach::foreach(j = 1:lig1, .combine = rbind, .export=ls(.GlobalEnv)) , {trt1(dudiCall, fac1, nf1, x, j)})
	} else {
		for (ind1 in 1:lig1) {
			if (progress) pb$tick()
			## Remove each row of the data table, one at a time,
			## then do the analysis and the bca on the new table
			## and estimate the coordinates of the missing row
			#
			## The original analysis can be any dudi, so wee need to start from dudiCall$call:
			jcall1 <- dudiCall$call
			## Change the df argument to discard row #ind1:
			jcall1[[2]] <- data.frame(eval.parent(jcall1[[2]]))[-ind1, , drop = FALSE]
			## Check that the scannf argument is set to FALSE:
			if (any(names(jcall1) == "scannf")) jcall1[[which(names(jcall1) == "scannf")]] <- FALSE
			else {
				## If scannf is not in the args list, add it and is set to FALSE:
				jcall1[[length(jcall1) + 1]] <- quote(FALSE)
				names(jcall1)[length(jcall1)] <- "scannf"
			}
			## Run the analysis without row #ind1:
			if (inherits(dudiCall, "fca") || inherits(dudiCall, "fpca")) {
				colblo1 <- attr(jcall1[[2]],  "col.blocks")
				jcall1[[2]] <- prep.fuzzy.var(jcall1[[2]], colblo1)
			}
			jdudi1 <- eval.parent(jcall1)
			## Check that axes are in the same direction as orignal analysis axes;
			## if not, change the sign
			##        for (j in 1:nf1)
			#	        if (cor(jdudi1$li[,j], dudiCall$li[-ind1,j]) < 0) jdudi1$li[,j] <- -jdudi1$li[,j]
			## then do the BGA on this analysis:
			jfac1 <- fac1[-ind1]
			cla.w1 <- tapply(jdudi1$lw, jfac1, sum)
			tabmoy <- apply(jdudi1$tab, 2, mean.w, w = jdudi1$lw, fac = jfac1, cla.w = cla.w1)
			tabmoy <- data.frame(tabmoy)
			jres <- as.dudi(tabmoy, jdudi1$cw, as.vector(cla.w1), scannf = FALSE, 
				nf = nf1, call = match.call(), type = "bet")
			## Check that jackknifed axes are in the same direction as  original bca axes;
			## if not, change the sign
			if (nf1 > 1) for (j in 1:nf1)
				if (stats::cor(jres$c1[,j], x$c1[,j]) < 0) jres$c1[,j] <- -jres$c1[,j]
			U <- as.matrix(jres$c1) * unlist(jres$cw)
			## Compute #ind1 row coordinates in this BGA and store it in xcoo1:
			xcoo1[ind1,] <- as.matrix(dudiCall$tab[ind1,]) %*% U
		}	
	}	
	# Compute mean overlap index oijb2m for bca cross validation
	oij2 <- matrix(0, nrow = lig1, ncol = ng1)
	# compute means by group of cross-validation coordinates 
	cla.w <- tapply(lw1, fac1, sum)
	xmeans <- apply(xcoo1, 2, mean.w, w = lw1, fac = fac1, cla.w = cla.w)
	# Compute all distances between each individual and the mean of his group
	for (ind1 in 1:lig1) {
		for (gr1 in 1:ng1) {
			oij2[ind1, gr1] <- sqrt(sum((xcoo1[ind1, nax] - xmeans[gr1, nax])^2))
		}
	}
	# Compute the number of individuals nearer to another group mean
	oijb2 <- matrix(0, nrow = ng1, ncol = ng1)
	for (gr1 in 1:ng1) {
		for (gr2 in 1:ng1) {
			oijb2[gr1, gr2] <- sum(oij2[fac1==lev1[gr1], gr2] < oij2[fac1==lev1[gr1], gr1])/nifac1[gr1]
		}
	}
	oijb2m <- mean(oijb2)
    PRESS1 <- as.data.frame(matrix(0, lig1, nf1))
    for (j in 1:nf1) PRESS1[,j] <- (xcoo1[,j] - x$ls[,j])^2
    PRESSTot <- colSums(PRESS1)
    names(xcoo1) <- names(PRESS1) <- names(PRESSTot) <- names(x$ls)
    res1 <- list(xcoo1, PRESS1, PRESSTot, oijb1m, oijb2m, (oijb2m-oijb1m)*200)
    names(res1) <- c("XValCoord", "PRESS", "PRESSTot", "Oij_bca", "Oij_XVal", "DeltaOij")
    class(res1) <- "bcaloocv"
    res1$call <- match.call()
    return(res1)
}

"print.bcaloocv" <- function (x, ...) 
{
    if (!inherits(x, "bcaloocv")) 
        stop("to be used with 'bcaloocv' object")
    cat("bca loocv object\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$Oij_bca:", x$Oij_bca)
    cat("\n$Oij_XVal:", x$Oij_XVal)
    cat("\n$DeltaOij:", x$DeltaOij, "%")
	cat("\n\n")
    sumry <- array("", c(4, 4), list(1:4, c("vector", "length", 
        "mode", "content")))
    sumry[1, ] <- c("$PRESSTot", length(x$PRESSTot), mode(x$PRESSTot), "Sum of PRESS for each bca axis")
    sumry[2, ] <- c("$Oij_bca", length(x$Oij_bca), mode(x$Oij_bca), "mean overlap index for BGA")
    sumry[3, ] <- c("$Oij_XVal", length(x$Oij_XVal), mode(x$Oij_XVal), "mean overlap index for cross-validation")
    sumry[4, ] <- c("$DeltaOij", length(x$DeltaOij), mode(x$DeltaOij), "spuriousness index")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(2, 4), list(1:2, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$XValCoord", nrow(x$XValCoord), ncol(x$XValCoord), "Cross-validates row coordinates")
    sumry[2, ] <- c("$PRESS", nrow(x$PRESS), ncol(x$PRESS), "Predicted Residual Error Sum of Squares for each row")
   
    print(sumry, quote = FALSE)
    cat("\n")
}

"plot.bcaloocv" <- function (x, xax = 1, yax = 2, ...) {
    if (!inherits(x, "bcaloocv")) 
        stop("Use only with 'bcaloocv' objects")
    bca1 <- eval(x$call[[2]])
    fac1 <- eval(bca1$call[[3]])
    if (bca1$nf == 1) {
        warnings("One axis only : not yet implemented")
        return(invisible())
    }
	# Permutation test
	rt1 <- randtest(bca1)
	# Compute cross-validated coordinates
	Oijbga <- x$Oij_bca
	Oijxval <- x$Oij_XVal
	dOij <- x$DeltaOij
	graphics::par(mfrow=c(2,2))	
	# Character string: graph title, permutation test p-value and variance ratio
	pst1 <- paste0("Permutation test p = ", rt1$pvalue, ", Expl.Var = ", round(bca1$ratio, 2), ", Oij = ", round(Oijbga,2))
	# Draw BGA factor map
	s.class(bca1$ls[,c(xax, yax)], fac1, cstar = 1, cellipse = 0)
	s.chull(bca1$ls[,c(xax, yax)], fac1, sub = pst1, optchull = 1, add.plot = TRUE)
	# Compute cross-validated coordinates
	# Character string for graph title
	pst2 <- paste0("Cross-validation Oij = ", round(Oijxval,2), ", dOij = ", round(dOij), "%")
	# Cross-validated factor map
	s.class(x$XValCoord[,c(xax, yax)], fac1, cstar = 1, cellipse = 0)
	s.chull(x$XValCoord[,c(xax, yax)], fac1, sub = pst2, optchull = 1, add.plot = TRUE)
	# Display both factor maps side by side
}

loocv.discrimin <- function(x, nax = 0, progress = FALSE, ...)
    ## Leave-one-out cross-validation for discriminant analysis (aka CVA)
    ## x = the discrimin analysis to be cross-validated
    ## nax = list of axes for mean overlap index computation (0 = all axes)
    ## progress = logical to display a progress bar
    ## Returns a list with the cross-validated row coordinates (XValCoord),
    ## the predicted residual error sum of squares (PRESS) for each individual,
    ## the total PRESS for each axis, (PRESSTot)
    #
{
    if (!inherits(x, "discrimin")) 
        stop("Object of class discrimin expected")
    discCall <- x$call
    ## Get the parameters of the original analysis:
    ## dudi, factor, and number of rows
    nf1 <- x$nf
    dudiOrig <- eval.parent(discCall[[2]])
    rank <- dudiOrig$rank
    dudiOrig <- redo.dudi(dudiOrig, rank)
    fac1 <- eval.parent(discCall[[3]])
    ng1 <- nlevels(fac1)
	lev1 <- levels(fac1)
    nifac1 <- table(fac1)
    lnax1 <- length(nax)
    if (lnax1 == 1) if (nax == 0) nax <- 1:nf1
    lig1 <- nrow(dudiOrig$tab)
    lw1 <- dudiOrig$lw
    if (length(fac1) != lig1) 
        stop("Non convenient dimension")
    xcoo1 <- as.data.frame(matrix(0, lig1, nf1))
    mean.w <- function(x, w, fac, cla.w) {
        z <- x * w
        z <- tapply(z, fac, sum)/cla.w
        return(z)
    }
    if (progress) pb <- progress::progress_bar$new(total = lig1,
        format = "  Computing [:bar] :percent eta: :eta")
	# Compute mean overlap index (oijb1m) for bca
	# Compute all distances between each individual and the mean of his group
	oij1 <- matrix(0, nrow = lig1, ncol = ng1)
	for (ind1 in 1:lig1) {
		for (gr1 in 1:ng1) {
			oij1[ind1, gr1] <- sqrt(sum((x$li[ind1, nax] - x$gc[gr1, nax])^2))
		}
	}
	# Compute the number of individuals nearer to another group mean
	oijb1 <- matrix(0, nrow = ng1, ncol = ng1)
	for (gr1 in 1:ng1) {
		for (gr2 in 1:ng1) {
			oijb1[gr1, gr2] <- sum(oij1[fac1==lev1[gr1], gr2] < oij1[fac1==lev1[gr1], gr1])/nifac1[gr1]
		}
	}
	# Mean overlap index
	oijb1m <- mean(oijb1)
    for (ind1 in 1:lig1) {
        if (progress) pb$tick()
        ## Remove each row of the data table, one at a time,
        ## then do the original analysis and the discriminant analysis
        ## on the new table and estimate the coordinates of the missing row
        #
        ## The original analysis can be any dudi, so wee need to start from dudiOrig$call:
        origCall <- dudiOrig$call
        ## Change the df argument to discard row #ind1:
        origCall[[2]] <- data.frame(eval.parent(origCall[[2]]))[-ind1, , drop = FALSE]
        ## Check that the scannf argument is set to FALSE:
        if (any(names(origCall) == "scannf")) origCall[[which(names(origCall) == "scannf")]] <- FALSE
        else {
            ## If scannf is not in the args list, add it and is set to FALSE:
            origCall[[length(origCall) + 1]] <- quote(FALSE)
            names(origCall)[length(origCall)] <- "scannf"
        }
        if (inherits(dudiOrig, "fca") || inherits(dudiOrig, "fpca")) {
            colblo1 <- attr(origCall[[2]],  "col.blocks")
            origCall[[2]] <- prep.fuzzy.var(origCall[[2]], colblo1)
        }
        ## Run the analysis without row #ind1:
        dudi1 <- eval.parent(origCall)
        rank1 <- dudi1$rank
        dudi1 <- redo.dudi(dudi1, rank1)
        ## Check that axes are in the same direction as orignal analysis axes;
        ## if not, change the sign
        ##        for (j in 1:nf1)
        #	        if (cor(dudi1$li[,j], dudiOrig$li[-ind1,j]) < 0) dudi1$li[,j] <- -dudi1$li[,j]
        ## then do the discriminant analysis:
        jfac1 <- fac1[-ind1]
        disc2 <- discrimin(dudi1, jfac1, scannf = FALSE, nf = nf1)
        ## Check that jackknifed axes are in the same direction as  original discrimin axes;
        ## if not, change the sign
        for (j in 1:nf1)
            if (stats::cor(disc2$fa[,j], x$fa[,j]) < 0) disc2$fa[,j] <- -disc2$fa[,j]
        ## Compute #ind1 row coordinates in this discriminant analysis and store it in xcoo1:
        xcoo1[ind1,] <- as.matrix(dudiOrig$tab[ind1,]) %*% as.matrix(disc2$fa)
    }
	# Compute mean overlap index oijb2m for bca cross validation
	oij2 <- matrix(0, nrow = lig1, ncol = ng1)
	# compute means by group of cross-validation coordinates 
	cla.w <- tapply(lw1, fac1, sum)
	xmeans <- apply(xcoo1, 2, mean.w, w = lw1, fac = fac1, cla.w = cla.w)
	# Compute all distances between each individual and the mean of his group
	for (ind1 in 1:lig1) {
		for (gr1 in 1:ng1) {
			oij2[ind1, gr1] <- sqrt(sum((xcoo1[ind1, nax] - xmeans[gr1, nax])^2))
		}
	}
	# Compute the number of individuals nearer to another group mean
	oijb2 <- matrix(0, nrow = ng1, ncol = ng1)
	for (gr1 in 1:ng1) {
		for (gr2 in 1:ng1) {
			oijb2[gr1, gr2] <- sum(oij2[fac1==lev1[gr1], gr2] < oij2[fac1==lev1[gr1], gr1])/nifac1[gr1]
		}
	}
	oijb2m <- mean(oijb2)
    PRESS1 <- as.data.frame(matrix(0, lig1, nf1))
    for (j in 1:nf1) PRESS1[,j] <- (xcoo1[,j] - x$li[,j])^2
    PRESSTot <- colSums(PRESS1)
	names(xcoo1) <- names(PRESS1) <- names(PRESSTot) <- names(x$li[1:nf1])
    res1 <- list(xcoo1, PRESS1, PRESSTot, oijb1m, oijb2m, (oijb2m-oijb1m)*200)
    names(res1) <- c("XValCoord", "PRESS", "PRESSTot", "Oij_disc", "Oij_XVal", "DeltaOij")
    class(res1) <- "discloocv"
    res1$call <- match.call()
    return(res1)
}

"print.discloocv" <- function (x, ...) 
{
    if (!inherits(x, "discloocv")) 
        stop("to be used with 'discloocv' object")
    cat("Discrimin loocv object\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$Oij_disc:", x$Oij_disc)
    cat("\n$Oij_XVal:", x$Oij_XVal)
    cat("\n$DeltaOij:", x$DeltaOij, "%")
	cat("\n\n")
    sumry <- array("", c(4, 4), list(1:4, c("vector", "length", 
        "mode", "content")))
    sumry[1, ] <- c("$PRESSTot", length(x$PRESSTot), mode(x$PRESSTot), "Sum of PRESS for each bca axis")
    sumry[2, ] <- c("$Oij_disc", length(x$Oij_disc), mode(x$Oij_disc), "mean overlap index for BGA")
    sumry[3, ] <- c("$Oij_XVal", length(x$Oij_XVal), mode(x$Oij_XVal), "mean overlap index for cross-validation")
    sumry[4, ] <- c("$DeltaOij", length(x$DeltaOij), mode(x$DeltaOij), "spuriousness index")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(2, 4), list(1:2, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$XValCoord", nrow(x$XValCoord), ncol(x$XValCoord), "Cross-validates row coordinates")
    sumry[2, ] <- c("$PRESS", nrow(x$PRESS), ncol(x$PRESS), "Predicted Residual Error Sum of Squares for each row")
   
    print(sumry, quote = FALSE)
    cat("\n")
}

"plot.discloocv" <- function (x, xax = 1, yax = 2, ...) {
    if (!inherits(x, "discloocv")) 
        stop("Use only with 'discloocv' objects")
    disc1 <- eval(x$call[[2]])
    fac1 <- eval(disc1$call[[3]])
    if (disc1$nf == 1) {
        warnings("One axis only : not yet implemented")
        return(invisible())
    }
	# Permutation test
	rt1 <- randtest(disc1)
	# Compute cross-validated coordinates
	Oijdisc <- x$Oij_disc
	Oijxval <- x$Oij_XVal
	dOij <- x$DeltaOij
	graphics::par(mfrow=c(2,2))	
	# Character string: graph title, permutation test p-value and variance ratio
	pst1 <- paste0("Permutation test p = ", rt1$pvalue, ", Oij = ", round(Oijdisc,2))
	# Draw Discrimin factor map
	s.class(disc1$li[,c(xax, yax)], fac1, cstar = 1, cellipse = 0)
	s.chull(disc1$li[,c(xax, yax)], fac1, sub = pst1, optchull = 1, add.plot = TRUE)
	# Compute cross-validated coordinates
	# Character string for graph title
	pst2 <- paste0("Cross-validation Oij = ", round(Oijxval,2), ", dOij = ", round(dOij), "%")
	# Cross-validated factor map
	s.class(x$XValCoord[,c(xax, yax)], fac1, cstar = 1, cellipse = 0)
	s.chull(x$XValCoord[,c(xax, yax)], fac1, sub = pst2, optchull = 1, add.plot = TRUE)
	# Display both factor maps side by side
}

loocv.dudi <- function(x, progress = FALSE, ...) 
    ## Leave-one-out cross-validation for a dudi analysis
    ## x = the dudi to be cross-validated
    ## progress = logical to display a progress bar
    ## Returns a list with the cross-validated row coordinates (XValCoord),
    ## the predicted residual error sum of squares (PRESS) for each individual,
    ## the total PRESS for each axis, (PRESSTot)
    #
{
    if (!inherits(x, "dudi")) 
        stop("Object of class dudi expected")
    if (!(inherits(x, "pca") | inherits(x, "coa") | inherits(x, "acm")))
        stop("Leave-one-out cross-validation not available for this type of analysis")
    dudiCall <- x$call
    nf1 <- x$nf
    tab1 <- eval.parent(dudiCall[[2]])
    lig1 <- nrow(tab1)
    xcoo1 <- as.data.frame(matrix(0, lig1, nf1))
    if (progress) pb <- progress::progress_bar$new(total = lig1,
        format = "  Computing [:bar] :percent eta: :eta")
    for (ind1 in 1:lig1) {
        if (progress) pb$tick()
        ## Remove each row of the data table, one at a time,
        ## then do the analysis on the new table and estimate the coordinates
        ## of all the rows except the one that was removed
        #
        tab2 <- tab1[-ind1, , drop = FALSE]
        ## Check that the scannf argument is set to FALSE:
        if (any(names(dudiCall) == "scannf")) dudiCall[[which(names(dudiCall) == "scannf")]] <- FALSE
        else {
            ## If scannf is not in the args list, add it and is set to FALSE:
            dudiCall[[length(dudiCall) + 1]] <- quote(FALSE)
            names(dudiCall)[length(dudiCall)] <- "scannf"
        }
        ## Set the nf argument to the value of the nf of the analysis:
        if (any(names(dudiCall) == "nf")) dudiCall[[which(names(dudiCall) == "nf")]] <- nf1
        ## If nf is not in the args list, add it and is set to nf1:
        else {
            dudiCall[[length(dudiCall) + 1]] <- nf1
            names(dudiCall)[length(dudiCall)] <- "nf"
        }
        ## Run the analysis without row #ind1:
        dudiCall[[2]] <- tab2
        jdudi <- eval.parent(dudiCall)
        ## Check that axes are in the same direction as orignal analysis axes; if not, change the sign
        for (j in 1:nf1)
            if (stats::cor(jdudi$c1[, j], x$c1[, j]) < 0) jdudi$c1[,j] <- -jdudi$c1[,j]
        
        ## Compute #ind1 row coordinates in the analysis and store it in xcoo1:
        xcoo1[ind1, ] <- as.matrix(x$tab[ind1, , drop = FALSE]) %*% (as.matrix(jdudi$c1) * jdudi$cw)
        
    }
    
    
    PRESS1 <- as.data.frame(matrix(0, lig1, nf1))
    for (j in 1:nf1) PRESS1[,j] <- (xcoo1[,j] - x$li[,j])^2
    PRESSTot <- colSums(PRESS1)
    names(xcoo1) <- names(PRESS1) <- names(PRESSTot) <- names(x$li[1:nf1])
    res1 <- list(xcoo1, PRESS1, PRESSTot)
    names(res1) <- c("XValCoord", "PRESS", "PRESSTot")
    return(res1)
}
