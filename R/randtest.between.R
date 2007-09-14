"randtest.between" <- function(xtest, nrepet=999, ...) {
    nrepet<-nrepet+1
    if (!inherits(xtest,"dudi"))
        stop("Object of class dudi expected")
    if (!inherits(xtest,"between"))
        stop ("Type 'between' expected")
    appel<-as.list(xtest$call)
    dudi1<-eval.parent(appel$dudi)
    fac<-eval.parent(appel$fac)
    X<-dudi1$tab
    X.lw<-dudi1$lw
    if ((!(identical(all.equal(X.lw,rep(1/nrow(X), nrow(X))),TRUE)))) {
      if(as.list(dudi1$call)[[1]] == "dudi.acm" )
    	stop ("Not implemented for non-uniform weights in the case of dudi.acm")
      else if(as.list(dudi1$call)[[1]] == "dudi.hillsmith" )
        stop ("Not implemented for non-uniform weights in the case of dudi.hillsmith")
      else if(as.list(dudi1$call)[[1]] == "dudi.mix" )
        stop ("Not implemented for non-uniform weights in the case of dudi.mix")
    }
    X.lw<-X.lw/sum(X.lw)
    X.cw<-sqrt(dudi1$cw)
    X<-t(t(X)*X.cw)
    inertot<-sum(dudi1$eig)
#   isim<-testinter(nrepet, X.lw, X.cw, length(unique(fac)), fac, X, nrow(X), ncol(X))/inertot
    isim<-testinter(nrepet, dudi1$lw, dudi1$cw, length(unique(fac)), fac, dudi1$tab, nrow(X), ncol(X))/inertot
    obs<-isim[1]
    return(as.randtest(isim[-1],obs,call=match.call()))
}
