"dudi.pco" <- function (d, row.w = "uniform", scannf = TRUE, nf = 2, full = FALSE,
    tol = 1e-07) 
{
    if (!inherits(d, "dist")) 
        stop("Distance matrix expected")
    if (full) 
        scannf <- FALSE
    distmat <- dist2mat(d)
    n <- ncol(distmat)
    rownames <- attr(d, "Labels")
    if (any(is.na(d))) 
        stop("missing value in d")
    if (is.null(rownames)) 
        rownames <- as.character(1:n)
    if (any(row.w == "uniform")) {
        row.w <- rep(1, n)
    }
    else {
        if (length(row.w) != n) 
            stop("Non convenient length(row.w)")
        if (any(row.w < 0)) 
            stop("Non convenient row.w (p<0)")
        if (any(row.w == 0)) 
            stop("Non convenient row.w (p=0)")
    }
    row.w <- row.w/sum(row.w)
    delta <- -0.5 * bicenter.wt(distmat * distmat, row.wt = row.w, 
        col.wt = row.w)
    wsqrt <- sqrt(row.w)
    delta <- delta * wsqrt
    delta <- t(t(delta) * wsqrt)
    eig <- eigen(delta, symmetric = TRUE)
    lambda <- eig$values
    w0 <- lambda[n]/lambda[1]
    if (w0 < -tol) 
        warning("Non euclidean distance")
    r <- sum(lambda > (lambda[1] * tol))
    if (scannf) {
        barplot(lambda)
        cat("Select the number of axes: ")
        nf <- as.integer(readLines(n = 1))
    }
    if (nf <= 0) 
        nf <- 2
    if (nf > r) 
        nf <- r
    if (full) 
        nf <- r
    res <- list()
    res$eig <- lambda[1:r]
    res$rank <- r
    res$nf <- nf
    res$cw <- rep(1, r)
    w <- t(t(eig$vectors[, 1:r]) * sqrt(lambda[1:r]))/wsqrt
    w <- data.frame(w)
    names(w) <- paste("A", 1:r, sep = "")
    row.names(w) <- rownames
    res$tab <- w
    res$li <- w[, 1:nf]
    w <- t(t(eig$vectors[, 1:nf])/wsqrt)
    w <- data.frame(w)
    names(w) <- paste("RS", 1:nf, sep = "")
    row.names(w) <- rownames
    res$l1 <- w
    w <- data.frame(diag(1, r))
    names(w) <- paste("CS", (1:r), sep = "")
    row.names(w) <- names(res$tab)
    res$c1 <- w[, 1:nf]
    w <- data.frame(matrix(0, r, nf))
    w[1:nf, 1:nf] <- diag(sqrt(lambda[1:nf]))
    names(w) <- paste("Comp", (1:nf), sep = "")
    row.names(w) <- names(res$tab)
    res$co <- w
    res$lw <- row.w
    res$call <- match.call()
    class(res) <- c("pco", "dudi")
    return(res)
}

"scatter.pco" <- function (x, xax = 1, yax = 2, clab.row = 1, posieig = "top",
    sub = NULL, csub = 2, ...) 
{
    if (!inherits(x, "pco")) 
        stop("Object of class 'pco' expected")
    opar <- par(mar = par("mar"))
    on.exit(par(opar))
    coolig <- x$li[, c(xax, yax)]
    s.label(coolig, clab = clab.row)
    add.scatter.eig(x$eig, x$nf, xax, yax, posi = posieig, ratio = 1/4)
}
