"ktab.match2ktabs" <- function (KTX, KTY) {
    if (!inherits(KTX, "ktab")) stop("The first argument must be a 'ktab'")
    if (!inherits(KTY, "ktab")) stop("The second argument must be a 'ktab'")
#### crossed ktab
    res <- list()
#### Parameters of first ktab
    lwX <- KTX$lw
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
    res$lw <- lwX
    res$cw <- rep(lwY,ntab)
    blo <- rep(nligY,ntab)
    res$blo <- blo
    
#### Enregistrement des tableaux de départ
    res$supX <- KTX[[1]]
    res$supY <- KTY[[1]]
    for (i in 2:ntab) {
        res$supX <- cbind(res$supX, KTX[[i]])
        res$supY <- cbind(res$supY, KTY[[i]])
    }
    res$supX=t(res$supX)
    res$supY=t(res$supY)
    res$supblo <- KTX$blo
    res$suplw <- cwX
    res$call <- match.call()
    class(res) <- c("ktab", "kcoinertia")
    col.names(res) <- rep(row.names(KTY),ntab)
    row.names(res) <- row.names(KTX)
    tab.names(res) <- tab.names(KTX)
    res <- ktab.util.addfactor(res)
    
    return(res)
}
