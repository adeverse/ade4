"randtest.discrimin" <- function(xtest, nrepet=999, ...) {
  if (!inherits(xtest, "discrimin"))
        stop("'discrimin' object expected")
    appel <- as.list(xtest$call)
    dudi <- eval.parent(appel$dudi)
    fac <- eval.parent(appel$fac)
    lig <- nrow(dudi$tab)
    if (length(fac) != lig) stop ("Non convenient dimension")
    rank <- dudi$rank
    dudi <- redo.dudi(dudi,rank)
    X <- dudi$l1
    X.lw <- dudi$lw
    # dudi et dudi.lw sont soumis a la permutation
    # fac reste fixe
    if ((!(identical(all.equal(X.lw,rep(1/nrow(X), nrow(X))),TRUE)))) {
      if(as.list(dudi$call)[[1]] == "dudi.acm" )
    	stop ("Not implemented for non-uniform weights in the case of dudi.acm")
      else if(as.list(dudi$call)[[1]] == "dudi.hillsmith" )
        stop ("Not implemented for non-uniform weights in the case of dudi.hillsmith")
      else if(as.list(dudi$call)[[1]] == "dudi.mix" )
        stop ("Not implemented for non-uniform weights in the case of dudi.mix")
    }
    isim <- testdiscriminCpp(nrepet, rank, X.lw, fac, as.matrix(X))
    obs <- isim[1]
    return(as.randtest(isim[-1], obs, call = match.call(), ...))
}
