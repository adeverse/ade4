"kdist2ktab" <- function (kd, scale = TRUE, tol=1e-07) {
    if (!inherits(kd,"kdist")) stop ("objet 'kdist' expected")
    if (!all(attr(kd,"euclid"))) stop ("Euclidean distances expected")
    ndist <- length(kd)
    nind <- attributes(kd)$size
    distnames <- attributes(kd)$names
    if(is.null(distnames)) distnames <- paste("D", 1:ndist, sep = "")
    rnames <-attributes(kd)$label
    if(is.null(rnames)) rnames <- as.character(1:nind)
    
    "representationeuclidienne" <- function (x) {
        # x est un vecteur demi-matrice du kdist
        d <- matrix(0,nind,nind)
        d[col(d)<row(d)] <- x
        d <- d+t(d)
        d <- (-0.5)*bicenter.wt(d*d)
        # d est une matrice de produits scalaires
        eig <- eigen(d, symmetric = TRUE)
        ncomp <- sum(eig$values > (eig$values[1] * tol))
        d <- eig$vectors[, 1:ncomp]
        variances <- eig$values[1:ncomp]
        d <- t(apply(d, 1, "*", sqrt(variances)))
        # d est une représentation euclidienne
        if (scale) {
            inertot <- sum(variances)
            d <- d/sqrt(inertot)
            d = d*sqrt(nrow(d))
        }
        d <- data.frame(d)
        row.names(d) <- rnames
        names(d) <- paste("C", 1:ncomp, sep = "")
        return(d)
    }
    res <- lapply(kd, representationeuclidienne)
    names (res) <- distnames
    for (k in 1:ndist) {
        cha <- distnames[k]
        ncomp <- ncol(res[[k]])
        names(res[[k]]) <- paste(substring (cha,1,4), 1:ncomp,sep="")
    }
    w.row <- rep(1,nind)/nind
    w.col <- lapply(res, function(x) rep(1, ncol(x)))
    res <- ktab.list.df (res, w.row=w.row,w.col=w.col )
    return(res)

}

