"score.pca" <- function (x, xax = 1, which.var = NULL, mfrow = NULL, csub = 2,
    sub = names(x$tab), abline = TRUE, ...) 
{
    if (!inherits(x, "pca")) 
        stop("Object of class 'pca' expected")
    if (x$nf == 1) 
        xax <- 1
    if ((xax < 1) || (xax > x$nf)) 
        stop("non convenient axe number")
    def.par <- graphics::par(no.readonly = TRUE)
    on.exit(graphics::par(def.par))
    oritab <- eval.parent(as.list(x$call)[[2]])
    nvar <- ncol(oritab)
    if (is.null(which.var)) 
        which.var <- (1:nvar)
    if (is.null(mfrow)) 
        mfrow <- grDevices::n2mfrow(length(which.var))
    graphics::par(mfrow = mfrow)
    if (prod(graphics::par("mfrow")) < length(which.var)) 
        graphics::par(ask = TRUE)
    graphics::par(mar = c(2.6, 2.6, 1.1, 1.1))
    score <- x$l1[, xax]
    for (i in which.var) {
        y <- oritab[, i]
        graphics::plot(score, y, type = "n")
        graphics::points(score, y, pch = 20)
        if (abline) 
            graphics::abline(stats::lm(y ~ score))
        scatterutil.sub(sub[i], csub = csub, "topleft")
    }
}
