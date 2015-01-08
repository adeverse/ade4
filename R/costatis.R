"costatis" <- function (KTX, KTY, scannf = TRUE) {
####
#### COSTATIS analysis
#### coinertia analysis of the compromises of two ktabs
#### Jean Thioulouse, 06 Nov 2009
#### This function takes 2 ktabs. It does a partial triadic analysis on each ktab,
#### and does a coinertia analysis on the compromises of the PTAs.
####
    normalise.w <- function(X, w) {
        # Correction d'un bug signale par Sandrine Pavoine le 21/10/2006
        f2 <- function(v) sqrt(sum(v * v * w))
        norm <- apply(X, 2, f2)
        X <- sweep(X, 2, norm, "/")
        return(X)
    }
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
#### pta on KTX
	if (scannf) cat("PTA of first KTab\n")
	ptaX <- pta(KTX, scannf = scannf)
#### pta on KTY
	if (scannf) cat("PTA of second KTab\n")
	ptaY <- pta(KTY, scannf = scannf)
#### coinertia analysis of compromises
	acpX=dudi.pca(t(ptaX$tab), center=FALSE, scannf=FALSE, nf=ptaX$nf)
	acpY=dudi.pca(t(ptaY$tab), center=FALSE, scannf=FALSE, nf=ptaY$nf)
	if (scannf) cat("Coinertia analysis of the two compromises\n")
	res <- coinertia(acpX, acpY, scannf = scannf)
#### projection of the rows of the two original ktables
	U <- as.matrix(res$c1) * unlist(res$cw)
	supIX <- normalise.w(t(as.matrix(KTX[[1]])) %*% U, acpX$lw)
	for (i in 2:ntabX) {
		supIX <- rbind(supIX, normalise.w(as.matrix(t(KTX[[i]])) %*% U, acpX$lw))
	}
	row.names(supIX) <- paste(KTX$TC[,1],KTX$TC[,2], sep="")	
	res$supIX <- as.data.frame(supIX)
    names(res$supIX) <- paste("XNorS", (1:res$nf), sep = "")
	
	U <- as.matrix(res$l1) * unlist(res$lw)
	supIY <- normalise.w(t(as.matrix(KTY[[1]])) %*% U, acpY$lw)
	for (i in 2:ntabY) {
		supIY <- rbind(supIY, normalise.w(as.matrix(t(KTY[[i]])) %*% U, acpY$lw))
	}
	row.names(supIY) <- paste(KTY$TC[,1],KTY$TC[,2], sep="")	
	res$supIY <- as.data.frame(supIY)
    names(res$supIY) <- paste("YNorS", (1:res$nf), sep = "")

#	class(res) <- c("costatis", class(res))
	return(res)
}

"costatis.randtest" <- function (KTX, KTY, nrepet = 999) {
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
#### pta on KTX
	ptaX <- pta(KTX, scannf = FALSE)
#### pta on KTY
	ptaY <- pta(KTY, scannf = FALSE)
#### coinertia analysis of compromises
	acpX=dudi.pca(t(ptaX$tab), center=FALSE, scannf=FALSE, nf=ptaX$nf)
	acpY=dudi.pca(t(ptaY$tab), center=FALSE, scannf=FALSE, nf=ptaY$nf)
	res <- coinertia(acpX, acpY, scannf = FALSE)
	rtest1 <- randtest(res, nrepet = nrepet)
	return(rtest1)
}
