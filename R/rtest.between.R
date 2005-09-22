"rtest.between" <- function (xtest, nrepet = 99, ...) {
    if (!inherits(xtest, "dudi")) 
        stop("Object of class dudi expected")
    if (!inherits(xtest, "between")) 
        stop("Type 'between' expected")
    appel <- as.list(xtest$call)
    dudi1 <- eval(appel$dudi, sys.frame(0))
    fac <- eval(appel$fac, sys.frame(0))
    X <- dudi1$tab
    X.lw <- dudi1$lw
    X.lw <- X.lw/sum(X.lw)
    if (!(identical(all.equal(X.lw,rep(1/nrow(X), nrow(X))),TRUE))) {
    	stop ("Not implemented for non-uniform weights")
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
        Y1 <- Y * Y.lw
        Y <- apply(Y * Y.lw, 2, function(x) tapply(x, fac, sum)/cla.w)
        inerb <- sum(apply(Y, 2, function(x) sum(x * x * cla.w)))
        return(inerb/inertot)
    }
    obs <- inerinter(FALSE)
    sim <- unlist(lapply(1:nrepet, inerinter))
    return(as.rtest(sim, obs))
}
