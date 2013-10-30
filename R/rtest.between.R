"rtest.between" <- function (xtest, nrepet = 99, ...) {
    if (!inherits(xtest, "dudi")) 
        stop("Object of class dudi expected")
    if (!inherits(xtest, "between")) 
        stop("Type 'between' expected")
    appel <- as.list(xtest$call)
    dudi1 <- eval.parent(appel[[2]]) ## could work with bca (appel$x) or between (appel$dudi)
    fac <- eval.parent(appel$fac)
    X <- dudi1$tab
    X.lw <- dudi1$lw
    X.lw <- X.lw/sum(X.lw)
    if ((!(identical(all.equal(X.lw,rep(1/nrow(X), nrow(X))),TRUE)))) {
      if(as.list(dudi1$call)[[1]] == "dudi.acm" )
    	stop ("Not implemented for non-uniform weights in the case of dudi.acm")
      else if(as.list(dudi1$call)[[1]] == "dudi.hillsmith" )
        stop ("Not implemented for non-uniform weights in the case of dudi.hillsmith")
      else if(as.list(dudi1$call)[[1]] == "dudi.mix" )
        stop ("Not implemented for non-uniform weights in the case of dudi.mix")
    }
    
    X.cw <- sqrt(dudi1$cw)
    X <- t(t(X) * X.cw)
    inertot <- sum(dudi1$eig)
    inerinter <- function(perm = TRUE) {
        if (perm) 
            sel <- sample(nrow(X))
        else sel <- 1:nrow(X)
        Y <- X[sel, ]
        Y.lw <- X.lw[sel]
        cla.w <- tapply(Y.lw, fac, sum)
        Y <- apply(Y * Y.lw, 2, function(x) tapply(x, fac, sum)/cla.w)
        inerb <- sum(apply(Y, 2, function(x) sum(x * x * cla.w)))
        return(inerb/inertot)
    }
    obs <- inerinter(FALSE)
    sim <- unlist(lapply(1:nrepet, inerinter))
    return(as.rtest(sim, obs))
}
