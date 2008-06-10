"optimEH" <- function(phyl, nbofsp, tol = 1e-8, give.list = TRUE)
{
    if (!inherits(phyl, "phylog")) stop("unconvenient phyl")
    if(is.null(phyl$Wdist)) phyl <- newick2phylog.addtools(phyl)
    phy.h <- hclust(phyl$Wdist^2 / 2)
    nbesp <- length(phy.h$labels)
    if (length(nbofsp) != 1) stop("unconvenient nbofsp")
    if (nbofsp == 0) return(0)
    if (!((0 < nbofsp) & (nbofsp <= nbesp))) stop("unconvenient nbofsp")
    nbofsp <- round(nbofsp)
    sp.names <- phy.h$labels
    if (nbofsp == nbesp) {
        res1 <- EH(phyl)
        sauv.names <- sp.names
    }
    else {
        phyl.D <- as.matrix(phyl$Wdist^2 / 2)
        Orig <- (solve(phyl.D)%*%rep(1, nbesp) / sum(solve(phyl.D)))
        Orig <- as.data.frame(Orig)
        car1 <- split(Orig, cutree(phy.h, nbofsp))
        name1 <- lapply(car1,function(x) rownames(x)[abs(x - max(x)) < tol])
        sauv.names <- lapply(name1, paste, collapse = " OR ")
        comp <- as.character(as.vector(lapply(name1, function(x) x[1])))
        nb1 <- as.vector(sapply(comp, function(x) (1:nbesp)[sp.names == x]))
        if (nbofsp == 2)
            res1 <- max(phyl$Wdist^2 / 2) * 2
        else {
            if (nbofsp == 1)
                res1 <- max(phyl$Wdist^2 / 2)
            else {
                res1 <- EH(phyl, select = nb1)
            }
        }
    }
    if (give.list == TRUE)
        return(list(value = res1, selected.sp = cbind.data.frame(names = unlist(sauv.names))))
    else
        return(res1)
}
