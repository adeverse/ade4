"randEH" <- function(phyl, nbofsp, nbrep = 10)
{
    if (!inherits(phyl, "phylog")) stop("unconvenient phyl")
    if(is.null(phyl$Wdist)) phyl <- newick2phylog.addtools(phyl)
    if (length(nbofsp)!= 1) stop("unconvenient nbofsp")
    nbesp <- length(phyl$leaves)
    if (!((0 <= nbofsp) & (nbofsp <= nbesp))) stop("unconvenient nbofsp")
    nbofsp <- round(nbofsp)
    if (nbofsp == 0) return(rep(0, nbrep))
    if (nbofsp == nbesp) {
        return(rep(EH(phyl), nbrep))
    }
    simuA1 <- function(i, phy) {
        comp = sample(1:nbesp, nbofsp)
        if (nbofsp == 2) {
            phyl.D <- as.matrix(phyl$Wdist^2 / 2)
            resc <- (max(phyl.D) + phyl.D[comp[1], comp[2]])
        }
        else {
            if (nbofsp == 1)
                resc <- max(phyl$Wdist^2 / 2)
            else {
                resc <- EH(phyl, select = comp)
            }
        }
        return(resc)
    }
    res <- sapply(1:nbrep, simuA1, phyl)
    return(res)
}
