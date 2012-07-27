 "rtest.discrimin" <- function (xtest, nrepet = 99, ...) {
    if (!inherits(xtest, "discrimin")) 
        stop("'discrimin' object expected")
    appel <- as.list(xtest$call)
    dudi <- eval.parent(appel$dudi)
    fac <- eval.parent(appel$fac)
    lig <- nrow(dudi$tab)
    if (length(fac) != lig) 
        stop("Non convenient dimension")
    rank <- dudi$rank
    dudi <- redo.dudi(dudi, rank)
    dudi.lw <- dudi$lw  

    dudi <- dudi$l1
    if ((!(identical(all.equal(dudi.lw,rep(1/nrow(dudi), nrow(dudi))),TRUE)))) {
      if(as.list(eval.parent(appel$dudi)$call)[[1]] == "dudi.acm" )
    	stop ("Not implemented for non-uniform weights in the case of dudi.acm")
      else if(as.list(eval.parent(appel$dudi)$call)[[1]] == "dudi.hillsmith" )
        stop ("Not implemented for non-uniform weights in the case of dudi.hillsmith")
      else if(as.list(eval.parent(appel$dudi)$call)[[1]] == "dudi.mix" )
        stop ("Not implemented for non-uniform weights in the case of dudi.mix")
    }
    
    between.var <- function(x, w, group, group.w) {
        z <- x * w
        z <- tapply(z, group, sum)/group.w
        return(sum(z * z * group.w))
    }
    inertia.ratio <- function(perm = TRUE) {
        if (perm) {
            sigma <- sample(lig)
            Y <- dudi[sigma, ]
            Y.w <- dudi.lw[sigma]
        }
        else {
            Y <- dudi
            Y.w <- dudi.lw
        }
        cla.w <- tapply(Y.w, fac, sum)
        ww <- apply(Y, 2, between.var, w = Y.w, group = fac, 
            group.w = cla.w)
        return(sum(ww)/rank)
    }
    obs <- inertia.ratio(perm = FALSE)
    sim <- unlist(lapply(1:nrepet, inertia.ratio))
    return(as.rtest(sim, obs))
}
