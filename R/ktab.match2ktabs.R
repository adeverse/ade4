"ktab.match2ktabs" <- function (KTX, KTY) {
    if (!inherits(KTX, "ktab")) stop("The first argument must be a 'ktab'")
    if (!inherits(KTY, "ktab")) stop("The second argument must be a 'ktab'")
#### crossed ktab
    res <- list()
#### Parameters of first ktab
    lwX <- KTX$lw
    nligX <- length(lwX)
    cwX <- KTX$cw
    ncolX <- length(cwX)
    bloX <- KTX$blo
    ntabX <- length(KTX$blo)
#### Parameters of second ktab
    lwY <- KTY$lw
    nligY <- length(lwY)
    cwY <- KTY$cw
    ncolY <- length(cwY)
    bloY <- KTY$blo
    ntabY <- length(KTY$blo)
#### Tests of coherence of the two ktabs
    if (ncolX != ncolY) stop("The two ktabs must have the same column numbers")
    if (any(cwX != cwY)) stop("The two ktabs must have the same column weights")
    if (ntabX != ntabY) stop("The two ktabs must have the same number of tables")
    if (!all(bloX == bloY)) stop("The two tables of one pair must have the same number of columns")
    ntab <- ntabX
    indica <- as.factor(rep(1:ntab, KTX$blo))
    lw <- split(cwX, indica)
 #### Compute crossed ktab
    for (i in 1:ntab) {
        tx <- as.matrix(KTX[[i]])
        ty <- as.matrix(KTY[[i]])
        res[[i]] <- as.data.frame(tx %*% (t(ty) * lw[[i]]))
     }
#### Complete crossed ktab structure
    res$lw <- rep(1, nligX)/nligX
    res$cw <- rep(rep(1, nligY)/nligY,ntab)
    blo <- rep(nligY,ntab)
    res$blo <- blo
    ktab.util.addfactor(res) <- list(blo, length(res$lw))
    res$call <- match.call()
    class(res) <- c("ktab", "kcoinertia")
    col.names(res) <- rep(row.names(KTY),ntab)
    row.names(res) <- row.names(KTX)
    tab.names(res) <- tab.names(KTX)
    return(res)
}
