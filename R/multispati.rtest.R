"multispati.rtest" <- function (dudi, listw, nrepet = 99) {
    if(!inherits(listw,"listw")) stop ("object of class 'listw' expected") 
    if(listw$style!="W") stop ("object of class 'listw' with style 'W' expected") 
    if (!(identical(all.equal(dudi$lw,rep(1/nrow(dudi$tab), nrow(dudi$tab))),TRUE))) {
    	stop ("Not implemented for non-uniform weights")
    }
    n <- length(listw$weights)
    fun.lag <- function (x) spdep::lag.listw(listw,x,TRUE)
    fun <- function (permuter = TRUE) {
        if (permuter) {
            permutation <- sample(n)
            y <- dudi$tab[permutation,]
            yw <- dudi$lw[permutation]
        } else {
            y <-dudi$tab
            yw <- dudi$lw
        }
        y <- as.matrix(y)
        ymoy <- apply(y, 2, fun.lag)
        ymoy <- ymoy*yw
        y <- y*ymoy
        indexmoran <- sum(apply(y,2,sum)*dudi$cw)
        return(indexmoran)
    }
    inertot <- sum(dudi$eig)
    obs <- fun (permuter = FALSE)/inertot
    if (nrepet == 0) return(obs)
    perm <- unlist(lapply(1:nrepet, fun))/inertot
    w <- as.rtest(obs = obs, sim = perm, call = match.call())
    return(w)
}


