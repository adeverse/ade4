"bgcoia" <- function (dudiX, dudiY, fac, scannf = TRUE) {
####
#### bgCOIA
#### between group coinertia analysis (Franquet et al. 94, 95)
#### Jean Thioulouse, 06 Nov 2009
#### This function takes 2 dudi and one factor. It does a between analysis on each
#### dudi, and does a coinertia analysis on the two between analyses.
####
    normalise.w <- function(X, w) {
        # Correction d'un bug siganlé par Sandrine Pavoine le 21/10/2006
        f2 <- function(v) sqrt(sum(v * v * w))
        norm <- apply(X, 2, f2)
        X <- sweep(X, 2, norm, "/")
        return(X)
    }
    if (!inherits(dudiX, "dudi")) 
        stop("dudiX must be a dudi")
    if (!inherits(dudiY, "dudi")) 
        stop("dudiY must be a dudi")
    if (!is.factor(fac)) 
        stop("fac must be a factor")
#### between X
	cat("between analysis of dudiX - ")
	betX <- between(dudiX, fac, scannf = scannf)
#### between Y
	cat("between analysis of dudiY - ")
	betY <- between(dudiY, fac, scannf = scannf)
#### coinbet
	cat("between class coinertia analysis\n")
	res <- coinertia(betX, betY, scannf = scannf)
	
#### projection of the rows of the two original dudi tables
	U <- as.matrix(res$c1) * unlist(res$cw)
	U <- data.frame(as.matrix(dudiX$tab) %*% U)
	U <- normalise.w(U, dudiX$lw)
	res$supIX <- U
	
	U <- as.matrix(res$l1) * unlist(res$lw)
	U <- data.frame(as.matrix(dudiY$tab) %*% U)
	U <- normalise.w(U, dudiY$lw)
	res$supIY <- U
	
	return(res)
}
