"reconst" <- function (dudi, ...) {
    UseMethod("reconst")
}

 "reconst.pca" <- function (dudi, nf = 1, ...) {
    if (!inherits(dudi, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (nf > dudi$nf) 
        stop(paste(nf, "factors need >", dudi$nf, "factors available\n"))
    if (!inherits(dudi, "pca")) 
        stop("Object of class 'dudi' expected")
    cent <- dudi$cent
    norm <- dudi$norm
    n <- nrow(dudi$tab)
    p <- ncol(dudi$tab)
    res <- matrix(0, n, p)
    for (i in 1:nf) {
        xli <- dudi$li[, i]
        yc1 <- dudi$c1[, i]
        res <- res + matrix(xli, n, 1) %*% matrix(yc1, 1, p)
    }
    res <- t(apply(res, 1, function(x) x * norm))
    res <- t(apply(res, 1, function(x) x + cent))
    res <- data.frame(res)
    names(res) <- names(dudi$tab)
    row.names(res) <- row.names(dudi$tab)
    return(res)
}
