"score.pca" <- function (x, xax = 1, which.var = NULL, mfrow = NULL, csub = 2,
    sub = names(x$tab), abline = TRUE, ...) 
{
    if (!inherits(x, "pca")) 
        stop("Object of class 'pca' expected")
    if (x$nf == 1) 
        xax <- 1
    if ((xax < 1) || (xax > x$nf)) 
        stop("non convenient axe number")
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    oritab <- eval.parent(as.list(x$call)[[2]])
    nvar <- ncol(oritab)
    if (is.null(which.var)) 
        which.var <- (1:nvar)
    if (is.null(mfrow)) 
        mfrow <- n2mfrow(length(which.var))
    par(mfrow = mfrow)
    if (prod(par("mfrow")) < length(which.var)) 
        par(ask = TRUE)
    par(mar = c(2.6, 2.6, 1.1, 1.1))
    score <- x$l1[, xax]
    for (i in which.var) {
        y <- oritab[, i]
        plot(score, y, type = "n")
        points(score, y, pch = 20)
        if (abline) 
            abline(lm(y ~ score))
        scatterutil.sub(sub[i], csub = csub, "topleft")
    }
}
