dpcoa <- function(df, dis = NULL, scannf = TRUE, nf = 2, full = FALSE, tol = 1e-07)
{
    if (!inherits(df, "data.frame")) stop("df is not a data.frame")
    if (any(df < 0)) stop("Negative value in df")
    nesp <- nrow(df) ; nrel<-ncol(df)
    if (!is.null(dis)) {
        if (!inherits(dis, "dist")) stop("dis is not an object 'dist'")
        n1 <- attr(dis, "Size")
        if (nesp != n1) stop("Non convenient dimensions nrow(df)!= attr(dis, 'Size')")
        if (!is.euclid(dis)) stop("an Euclidean matrix is needed")
    }
    if (is.null(dis)) {
        dis <- (matrix(1, nrow(df), nrow(df)) - diag(rep(1, nrow(df)))) * sqrt(2)
        rownames(dis) <- colnames(dis) <- rownames(df)
        dis <- as.dist(dis)
    }
    #####################
    # Use 1/2 dij^2 #
    #####################
    d <- as.matrix(dis)
    d <- d * d / 2
    result <- list()
    w.rel <- apply(df, 2, sum)
    w.rel <- w.rel / sum(w.rel)
    names.rel <- names(df)
    w.esp <- apply(df, 1, sum)
    w.esp <- w.esp / sum(w.esp)
    if (is.null(attr(dis, "Labels"))) attr(dis, "Labels") <- 1:nesp
    names.esp <- attr(dis, "Labels")
    z <- apply(df, 2, sum)
    z[z == 0] <- 1
    z <- t(t(df) / z) # column pattern in table df    
    # Rao's RaoDivC
    fun <- function(x) sum(t(d * x) * x)
    df2 <- sweep(df, 2, apply(df, 2, sum), "/")
    w <- unlist(apply(df2, 2, fun))
    names(w) <- names.rel
    result$RaoDiv <- w
    # Rao's DiSC
    fun1 <- function(x) {
        p <- z[, x[1]] - z[, x[2]]
        w <- -sum(t(d * p) * p)
        return(sqrt(w))
    }
    dnew <- matrix(0, nrel, nrel)
    index <- cbind(col(dnew)[col(dnew) < row(dnew)], row(dnew)[col(dnew) < row(dnew)])
    dnew <- unlist(apply(index, 1, fun1))
    # Rao's DISC computation
    # That provides exactly the previous results
    # with Euclidean matrix
    # fun2 <- function(x) {
    #     p <- w[x[1], ] - w[x[2], ]
    #     w <- sum(p^2)
    #     return(sqrt(w))
    # }
    # dnew <- matrix(0, nrel, nrel)
    # index <- cbind(col(dnew)[col(dnew) < row(dnew)], row(dnew)[col(dnew) < row(dnew)])
    # w <- as.matrix(dudi.pco(dis, w.esp, full=T)$li)
    # w <- t(z) %*% w
    # dnew <- unlist(apply(index, 1, fun2))
    attr(dnew, "Size") <- nrel
    attr(dnew, "Labels") <- names.rel
    attr(dnew, "Diag") <- TRUE
    attr(dnew, "Upper") <- FALSE
    attr(dnew, "method") <- "dis"
    attr(dnew, "call") <- match.call()
    class(dnew) <- "dist"
    result$RaoDis <- dnew
    Bdiv <- t(apply(df, 2, sum) / sum(df)) %*% (as.matrix(dnew)^2 / 2) %*% (apply(df, 2, sum) / sum(df))
    Tdiv <- t(apply(df, 1, sum) / sum(df)) %*% d %*% (apply(df, 1, sum) / sum(df))
    Wdiv <- Tdiv - Bdiv
    divdec <- data.frame(c(Bdiv, Wdiv, Tdiv))
    names(divdec) <- "Diversity"
    rownames(divdec) <- c("Between-samples diversity",
        "Within-samples diversity", "Total diversity")
    result$RaoDecodiv <- divdec
    # two-level PCO
    pco1 <- dudi.pco(dis, w.esp, full = TRUE)
    wesp <- as.matrix(pco1$li)
    wrel <- t(z) %*% wesp
    wrel <- data.frame(wrel)
    row.names(wrel) <- names.rel
    # check on the centring of the two scatters of weighted points
    # print(apply(wrel * w.rel, 2, sum))
    # print(apply(wesp * w.esp, 2, sum))
    dudi1 <- as.dudi (wrel, rep(1, ncol(wrel)), w.rel, scannf = scannf,
        nf = nf, call = match.call(), type = "dpcoa", tol = tol, full = full)
    result$w1 <- w.esp
    result$w2 <- w.rel
    result$eig <- dudi1$eig
    result$rank <- dudi1$rank
    result$nf <- dudi1$nf
    result$l2 <- dudi1$li
    w <- wesp %*% as.matrix(dudi1$c1)
    w <- data.frame(w)
    row.names(w) <- names.esp
    result$l1 <- w
    result$c1 <- dudi1$c1
    result$call <- match.call()
    class(result) <- "dpcoa"
    return(result)
}

plot.dpcoa <- function(x, xax = 1, yax = 2, option = 1:4, csize = 2, ...) {
	if (!inherits(x, "dpcoa")) stop("Object of type 'dpcoa' expected")
	nf <- x$nf
	if (xax > nf) stop("Non convenient xax")
	if (yax > nf) stop("Non convenient yax")
	opar <- par(mar = par("mar"),  mfrow = par("mfrow"), xpd = par("xpd"))
	on.exit (par(opar))
	mfrow <- n2mfrow(length(option))
	par(mfrow = mfrow)
	for (j in option) {
		if (j == 1) { #
			s.corcircle(x$c1[, c(xax, yax)], cgrid = 0, 
				sub = "Base", csub = 1.5, possub = "topleft", fullcircle = TRUE)
			l0 <- length(x$eig)
			add.scatter.eig(x$eig, l0, xax, yax, posi = "bottomleft", ratio = 1/4)
		}
		if (j == 2) { #
			X <- as.list(x$call)[[2]]
			X <- eval.parent(X)
			s.label(x$l1[, c(xax, yax)], clabel = 0, cpoint = 2)
			s.distri(x$l1[, c(xax, yax)], X, add.plot = TRUE, cellipse = 1, cstar = 0, 
				axesell = 0, label = names(X), cpoint = 0, clabel = 1)
			#add.scatter.eig(x$eig, l0, xax, yax, posi = "bottom", ratio = 1 / 5)
		}
		if (j == 3) { #
			s.label(x$l2[, c(xax, yax)], clabel = 1, cpoint = 0)
		}
		if (j == 4) { #
			s.value(x$l2[, c(xax, yax)], x$RaoDiv, csize = csize, 
				sub = "Rao Divcs", possub = "topright", csub = 1.5)
		}
	}		
}

print.dpcoa <- function (x, ...)
{
    cat("double principal coordinate analysis\n")
    cat("class: ")
    cat(class(x))
    cat("\n$call: ")
    print(x$call)
    cat("\n$nf:", x$nf, "axis-components saved")
    cat("\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    sumry <- array("", c(4, 4), list(1:4, c("vector", "length", 
        "mode", "content")))
    sumry[1, ] <- c("$w1", length(x$w1), mode(x$w1), "weights of species")
    sumry[2, ] <- c("$w2", length(x$w2), mode(x$w2), "weights of communities")
    sumry[3, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    sumry[4, ] <- c("$RaoDiv", length(x$RaoDiv), mode(x$RaoDiv),
        "diversity coefficients within communities")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(1, 3), list(1:1, c("dist", "Size", 
        "content")))
    sumry[1, ] <- c("$RaoDis", attributes(x$RaoDis)$Size,
        "dissimilarities among communities")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(4, 4), list(1:4, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$RaoDecodiv", 3, 1, "decomposition of diversity")
    sumry[2, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "coordinates of the species")
    sumry[3, ] <- c("$l2", nrow(x$l2), ncol(x$l2), "coordinates of the species")
    sumry[4, ] <- c("$c1", nrow(x$c1), ncol(x$c1),
        "scores of the principal axes of the species")
    
    print(sumry, quote = FALSE)
}
