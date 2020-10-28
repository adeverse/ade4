"loocv" <- function(x, ...) {
    UseMethod("loocv")
}

loocv.between <- function(x, progress = FALSE, ...)
    ## Leave-one-out cross-validation for bca
    ## x = the bca to be cross-validated
    ## progress = logical to display a progress bar
    ## Returns a list with the cross-validated row coordinates (XValCoord),
    ## the predicted residual error sum of squares (PRESS) for each individual,
    ## the total PRESS for each axis, (PRESSTot),
    ## the root-mean-square error (RMSE), and
    ## RMSEIQR, the interquartile range normalized RMSE.
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
    fac <- eval.parent(bcaCall[[3]])
    lig1 <- nrow(dudiCall$tab)
    if (length(fac) != lig1) 
        stop("Non convenient dimension")
    xcoo1 <- as.data.frame(matrix(0, lig1, nf1))
    mean.w <- function(x, w, fac, cla.w) {
        z <- x * w
        z <- tapply(z, fac, sum)/cla.w
        return(z)
    }
    if (progress) pb <- progress_bar$new(total = lig1,
        format = "  Computing [:bar] :percent eta: :eta")
    for (ind1 in 1:lig1) {
        if (progress) pb$tick()
        ## Remove each row of the data table, one at a time,
        ## then do the analysis and the bca on the new table
        ## and estimate the coordinates of the missing row
        #
        ## The original analysis can be any dudi, so wee need to start from dudiCall$call:
        jcall1 <- dudiCall$call
        ## Change the df argument to discard row #ind1:
        jcall1[[2]] <- eval.parent(jcall1[[2]])[-ind1, ]
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
        jfac1 <- fac[-ind1]
        cla.w1 <- tapply(jdudi1$lw, jfac1, sum)
        tabmoy <- apply(jdudi1$tab, 2, mean.w, w = jdudi1$lw, fac = jfac1, cla.w = cla.w1)
        tabmoy <- data.frame(tabmoy)
        jres <- as.dudi(tabmoy, jdudi1$cw, as.vector(cla.w1), scannf = FALSE, 
            nf = nf1, call = match.call(), type = "bet")
        ## Check that jackknifed axes are in the same direction as  original bca axes;
        ## if not, change the sign
        for (j in 1:nf1)
            if (cor(jres$c1[,j], x$c1[,j]) < 0) jres$c1[,j] <- -jres$c1[,j]
        U <- as.matrix(jres$c1) * unlist(jres$cw)
        ## Compute #ind1 row coordinates in this BGA and store it in xcoo1:
        xcoo1[ind1,] <- as.matrix(dudiCall$tab[ind1,]) %*% U
    }
    PRESS1 <- as.data.frame(matrix(0, lig1, nf1))
    for (j in 1:nf1) PRESS1[,j] <- (xcoo1[,j] - x$ls[,j])^2
    PRESSTot <- colSums(PRESS1)
    RMSE <- sqrt(PRESSTot/lig1)
    RMSEIQR <- sqrt(PRESSTot/lig1)
    for (j in 1:nf1) RMSEIQR[j] <- RMSEIQR[j]/IQR(x$ls[,j])
    names(xcoo1) <- names(PRESS1) <- names(PRESSTot) <- names(RMSE) <- names(RMSEIQR) <- names(x$ls)
    res1 <- list(xcoo1, PRESS1, PRESSTot, RMSE, RMSEIQR)
    names(res1) <- c("XValCoord", "PRESS", "PRESSTot", "RMSE", "RMSEIQR")
    return(res1)
}

loocv.discrimin <- function(x, progress = FALSE, ...)
    ## Leave-one-out cross-validation for discriminant analysis (aka CVA)
    ## x = the discrimin analysis to be cross-validated
    ## progress = logical to display a progress bar
    ## Returns a list with the cross-validated row coordinates (XValCoord),
    ## the predicted residual error sum of squares (PRESS) for each individual,
    ## the total PRESS for each axis, (PRESSTot),
    ## the root-mean-square error (RMSE), and
    ## RMSEIQR, the interquartile range normalized RMSE.
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
    fac <- eval.parent(discCall[[3]])
    lig1 <- nrow(dudiOrig$tab)
    if (length(fac) != lig1) 
        stop("Non convenient dimension")
    xcoo1 <- as.data.frame(matrix(0, lig1, nf1))
    mean.w <- function(x, w, fac, cla.w) {
        z <- x * w
        z <- tapply(z, fac, sum)/cla.w
        return(z)
    }
    if (progress) pb <- progress_bar$new(total = lig1,
        format = "  Computing [:bar] :percent eta: :eta")
    for (ind1 in 1:lig1) {
        if (progress) pb$tick()
        ## Remove each row of the data table, one at a time,
        ## then do the original analysis and the discriminant analysis
        ## on the new table and estimate the coordinates of the missing row
        #
        ## The original analysis can be any dudi, so wee need to start from dudiOrig$call:
        origCall <- dudiOrig$call
        ## Change the df argument to discard row #ind1:
        origCall[[2]] <- eval.parent(origCall[[2]])[-ind1, ]
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
        jfac1 <- fac[-ind1]
        disc2 <- discrimin(dudi1, jfac1, scannf = FALSE)
        ## Check that jackknifed axes are in the same direction as  original discrimin axes;
        ## if not, change the sign
        for (j in 1:nf1)
            if (cor(disc2$fa[,j], x$fa[,j]) < 0) disc2$fa[,j] <- -disc2$fa[,j]
        ## Compute #ind1 row coordinates in this discriminant analysis and store it in xcoo1:
        xcoo1[ind1,] <- as.matrix(dudiOrig$tab[ind1,]) %*% as.matrix(disc2$fa)
    }
    PRESS1 <- as.data.frame(matrix(0, lig1, nf1))
    for (j in 1:nf1) PRESS1[,j] <- (xcoo1[,j] - x$li[,j])^2
    PRESSTot <- colSums(PRESS1)
    RMSE <- sqrt(PRESSTot/lig1)
    RMSEIQR <- sqrt(PRESSTot/lig1)
    for (j in 1:nf1) RMSEIQR[j] <- RMSEIQR[j]/IQR(x$li[,j])
    names(xcoo1) <- names(PRESS1) <- names(PRESSTot) <- names(RMSE) <- names(RMSEIQR) <- names(x$li[1:nf1])
    res1 <- list(xcoo1, PRESS1, PRESSTot, RMSE, RMSEIQR)
    names(res1) <- c("XValCoord", "PRESS", "PRESSTot", "RMSE", "RMSEIQR")
    return(res1)
}

loocv.dudi <- function(x, progress = FALSE, ...) 
    ## Leave-one-out cross-validation for a dudi analysis
    ## x = the dudi to be cross-validated
    ## progress = logical to display a progress bar
    ## Returns a list with the cross-validated row coordinates (XValCoord),
    ## the predicted residual error sum of squares (PRESS) for each individual,
    ## the total PRESS for each axis, (PRESSTot),
    ## the root-mean-square error (RMSE), and
    ## RMSEIQR, the interquartile range normalized RMSE.
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
    if (progress) pb <- progress_bar$new(total = lig1,
        format = "  Computing [:bar] :percent eta: :eta")
    for (ind1 in 1:lig1) {
        if (progress) pb$tick()
        ## Remove each row of the data table, one at a time,
        ## then do the analysis on the new table and estimate the coordinates
        ## of all the rows except the one that was removed
        #
        tab2 <- tab1[-ind1, ]
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
            if (cor(jdudi$c1[, j], x$c1[, j]) < 0) jdudi$c1[,j] <- -jdudi$c1[,j]
        
        ## Compute #ind1 row coordinates in the analysis and store it in xcoo1:
        xcoo1[ind1, ] <- as.matrix(x$tab[ind1, , drop = FALSE]) %*% (as.matrix(jdudi$c1) * jdudi$cw)
        
    }
    
    
    PRESS1 <- as.data.frame(matrix(0, lig1, nf1))
    for (j in 1:nf1) PRESS1[,j] <- (xcoo1[,j] - x$li[,j])^2
    PRESSTot <- colSums(PRESS1)
    RMSE <- sqrt(PRESSTot/lig1)
    RMSEIQR <- sqrt(PRESSTot/lig1)
    for (j in 1:nf1) RMSEIQR[j] <- RMSEIQR[j]/IQR(x$li[,j])
    names(xcoo1) <- names(PRESS1) <- names(PRESSTot) <- names(RMSE) <- names(RMSEIQR) <- names(x$li[1:nf1])
    res1 <- list(xcoo1, PRESS1, PRESSTot, RMSE, RMSEIQR)
    names(res1) <- c("XValCoord", "PRESS", "PRESSTot", "RMSE", "RMSEIQR")
    return(res1)
}