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

"reconst.coa" <- function (dudi, nf = 1, ...) {
    if (!inherits(dudi, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (nf > dudi$nf) 
        stop(paste(nf, "factors need >", dudi$nf, "factors available\n"))
    if (!inherits(dudi, "coa")) 
        stop("Object of class 'dudi' expected")
    pl <- dudi$lw
    pc <- dudi$cw
    n <- dudi$N
    res0 <- outer(pl,pc)*n
    res <- data.frame(res0)
    names(res) <- names(dudi$tab)
    row.names(res) <- row.names(dudi$tab)
    if (nf ==0) return(res)
    for (i in 1:nf) {
        xli <- dudi$li[, i]
        yc1 <- dudi$c1[, i]
        res <- res + outer(xli,yc1)*res0
    }
    return(res)
}
