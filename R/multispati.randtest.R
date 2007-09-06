"multispati.randtest" <- function (dudi, listw, nrepet = 999) {
    if(!inherits(dudi,"dudi")) stop ("object of class 'dudi' expected") 
    if(!inherits(listw,"listw")) stop ("object of class 'listw' expected") 
    if(listw$style!="W") stop ("object of class 'listw' with style 'W' expected") 
    
    "testmultispati"<- function(nrepet, nr, nc, tab, mat, lw, cw) {
        .C("testmultispati", 
            as.integer(nrepet),
            as.integer(nr),
            as.integer(nc),
            as.double(as.matrix(tab)),
            as.double(mat),
            as.double(lw),
            as.double(cw),
            inersim=double(nrepet+1),
            PACKAGE="ade4")$inersim
    }
 
    tab<- dudi$tab
    nr<-nrow(tab)
    nc<-ncol(tab)
    mat<-spdep::listw2mat(listw)
    lw<- dudi$lw
    cw<- dudi$cw
    if (!(identical(all.equal(lw,rep(1/nrow(tab), nrow(tab))),TRUE))) {
    	stop ("Not implemented for non-uniform weights")
    }
    inersim<- testmultispati(nrepet, nr, nc, tab, mat, lw, cw)
    inertot<- sum(dudi$eig)
    inersim<- inersim/inertot
    obs <- inersim[1]
    w<-as.rtest(inersim[-1], obs, call = match.call())
    return(w)
}

