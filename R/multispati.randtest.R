multispati.randtest <- function (dudi, listw, nrepet = 99) {
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
            inersim=double(nrepet+1))$inersim
    }
 
    tab<- dudi$tab
    nr<-nrow(tab)
    nc<-ncol(tab)
    mat<-listw2mat(listw)
    lw<- dudi$lw
    cw<- dudi$cw
    inersim<- testmultispati(nrepet, nr, nc, tab, mat, lw, cw)
    inertot<- sum(dudi$eig)
    inersim<- inersim/inertot
    obs <- inersim[1]
    w<-as.rtest(inersim[-1], obs, call = match.call())
    return(w)
}

