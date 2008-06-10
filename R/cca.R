"cca" <- function (sitspe, sitenv, scannf = TRUE, nf = 2) {
    sitenv <- data.frame(sitenv)
    if (!inherits(sitspe, "data.frame")) 
        stop("data.frame expected")
    if (!inherits(sitenv, "data.frame")) 
        stop("data.frame expected")
    coa1 <- dudi.coa(sitspe, scannf = FALSE, nf = 8)
    x <- pcaiv(coa1, sitenv, scannf = scannf, nf = nf)
    class(x) <- c("cca", "pcaiv", "dudi")
    x$call <- match.call()
    return(x)
}
