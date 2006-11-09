"pcoscaled" <- function (distmat, tol = 1e-07) {
    if (!inherits(distmat, "dist")) 
        stop("Object of class 'dist' expected")
    if (!is.euclid(distmat)) 
        stop("Euclidean distance expected")
    lab <- attr(distmat, "Labels")
    distmat <- as.matrix(distmat)
    n <- ncol(distmat)
    if (is.null(lab)) 
        lab <- as.character(1:n)
    delta <- -0.5 * bicenter.wt(distmat * distmat)
    eig <- eigen(delta, symmetric = TRUE)
    w0 <- eig$values[n]/eig$values[1]
    if ((w0 < -tol)) 
        stop("Euclidean distance matrix expected")
    ncomp <- sum(eig$values > (eig$values[1] * tol))
    x <- as.matrix(eig$vectors[, 1:ncomp])
    variances <- eig$values[1:ncomp]
    x <- sweep(x,2,sqrt(variances),"*")
    inertot <- sum(variances)
    x <- x/sqrt(inertot)
    x <- x*sqrt(n)
    x <- data.frame(x)
    names(x) <- paste("C", 1:ncomp, sep = "")
    row.names(x) <- lab
    return(x)
}
