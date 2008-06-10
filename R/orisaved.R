"orisaved" <- function(phyl, rate = 0.1, method = 1)
{
    if (!inherits(phyl, "phylog")) stop("unconvenient phyl")
    if(is.null(phyl$Wdist)) phyl <- newick2phylog.addtools(phyl)
    if (any(is.na(match(method, 1:2)))) stop("unconvenient method")
    if (length(method) != 1) stop("only one method can be chosen")
    if (length(rate) != 1) stop("unconvenient rate")
    if (!is.numeric(rate)) stop("rate must be a real value")
    if (!(rate>=0 & rate<=1)) stop("rate must be between 0 and 1")
    if (rate == 0) return(0)
    phy.h <- hclust(phyl$Wdist^2 / 2)
    nbesp <- length(phy.h$labels)
    Rate <- round(seq(0, nbesp, by = nbesp * rate))
    Rate <- Rate[-1]
    phyl.D <- as.matrix(phyl$Wdist^2 / 2)
    Orig <- (solve(phyl.D)%*%rep(1, nbesp) / sum(solve(phyl.D)))
    OrigCalc <- function(i) {
        if (method == 1) {
            return(sum(unlist(lapply(split(Orig, cutree(phy.h, i)), max))))
        }
        if (method == 2) {
            return(sum(unlist(lapply(split(Orig, cutree(phy.h, i)), min))))
        }
    }
    res <- c(0, sapply(Rate, OrigCalc))
    return(res)
}
