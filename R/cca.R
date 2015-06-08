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

summary.cca <- function(object, ...){
    thetitle <- "Canonical correspondence analysis" 
    cat(thetitle)
    cat("\n\n")
    summary.dudi(object, ...)
    
    appel <- as.list(object$call)
    df <- as.data.frame(eval.parent(appel$sitenv))
    spe <- eval.parent(appel$sitspe)
    coa1 <- dudi.coa(spe, scannf = FALSE)

    cat(paste("Total unconstrained inertia (",deparse(appel$sitspe),"): ", sep = ""))
    cat(signif(sum(coa1$eig), 4))
    cat("\n\n")

    cat(paste("Inertia of" ,deparse(appel$sitspe),"explained by", deparse(appel$sitenv), "(%): "))
    cat(signif(sum(object$eig) / sum(coa1$eig) * 100, 4))
    cat("\n\n")

}
