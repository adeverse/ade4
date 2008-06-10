"EH" <- function(phyl, select = NULL)
{
    if (!inherits(phyl, "phylog")) stop("unconvenient phyl")
    if(is.null(phyl$Wdist)) phyl <- newick2phylog.addtools(phyl)
    if (is.null(select))
        return(sum(phyl$leaves) + sum(phyl$nodes))
    else {
        if(!is.numeric(select)) stop("unconvenient select")
        select <- unique(select)
        nbesp <- length(phyl$leaves)
        nbselect <- length(select)
        if(any(is.na(match(select, 1:nbesp)))) stop("unconvenient select")
        phyl.D <- as.matrix(phyl$Wdist^2 / 2)
        if(length(select)==1) return(max(phyl.D))
        if(length(select)==2) return(phyl.D[select[1], select[2]] + max(phyl.D))
        fun <- function(i) {
            min(phyl.D[select[i], select[1:(i - 1)]])
        }
        res <-  phyl.D[select[1], select[2]] + max(phyl.D) + sum(sapply(3:nbselect, fun)) 
        return(res)
    }
}
