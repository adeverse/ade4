"statico" <- function (KTX, KTY, scannf = TRUE) {
####
#### STATICO analysis
#### k-table analysis of the cross-tables at each date of two ktabs
#### Jean Thioulouse, 06 Nov 2009
#### This function takes 2 ktabs. It crosses each pair of tables of these ktabs
#### and does a partial triadic analysis on this new ktab.
####
    if (!inherits(KTX, "ktab")) stop("The first argument must be a 'ktab'")
    if (!inherits(KTY, "ktab")) stop("The second argument must be a 'ktab'")
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
#### compute the crossed ktab 
	kcoi <- ktab.match2ktabs(KTX, KTY)
#### pta on the ktab
	res <- pta(kcoi, scannf = scannf)
	return(res)
}

"statico.krandtest" <- function (KTX, KTY, nrepet = 999) {
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
    ksim <- matrix(0, nrow=nrepet, ncol=ntab, dimnames=list(NULL, tab.names(KTX)))
    kobs <- vector("numeric", ntab)
#### Compute coinertias and randtests
    for (i in 1:ntab) {
        tx <- t(as.matrix(KTX[[i]]))
        ty <- t(as.matrix(KTY[[i]]))
        pcax <- dudi.pca(tx, row.w=lw[[i]], col.w=lwX, scannf=FALSE)
        pcay <- dudi.pca(ty, row.w=lw[[i]], col.w=lwY, scannf=FALSE)
        coin1 <- coinertia(pcax, pcay, scannf=FALSE)
        res[[i]] <- randtest(coin1, nrepet=nrepet)
        ksim[,i] <- res[[i]]$sim
        kobs[i] <- res[[i]]$obs
     }
#### Return a krandtest
     as.krandtest(ksim, kobs)
}
