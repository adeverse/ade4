"randtest.discrimin" <- function(xtest, nrepet=999, ...) {
    nrepet <- nrepet +1
    if (!inherits(xtest, "discrimin"))
        stop("'discrimin' object expected")
    appel<-as.list(xtest$call)
    dudi<-eval(appel$dudi,sys.frame(0))
    fac<-eval(appel$fac,sys.frame(0))
    lig<-nrow(dudi$tab)
    if (length(fac)!=lig) stop ("Non convenient dimension")
    rank<-dudi$rank
    dudi<-redo.dudi(dudi,rank)
    # dudi.lw<-dudi$lw
    # dudi<-dudi$l1
    X<-dudi$l1
    X.lw<-dudi$lw
    # dudi et dudi.lw sont soumis a la permutation
    # fac reste fixe
     if (!(identical(all.equal(X.lw,rep(1/nrow(X), nrow(X))),TRUE))) {
    	stop ("Not implemented for non-uniform weights")
    }
    isim<-testdiscrimin(nrepet, rank, X.lw, length(unique(fac)), fac, X, nrow(X), ncol(X))
    obs<-isim[1]
    return(as.randtest(isim[-1],obs,call=match.call()))
}
