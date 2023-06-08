"score.acm" <- function (x, xax = 1, which.var = NULL, mfrow = NULL, sub = names(oritab),
    csub = 2, possub = "topleft", ...) 
{
    if (!inherits(x, "acm")) 
        stop("Object of class 'acm' expected")
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
        graphics::par(mfrow = grDevices::n2mfrow(length(which.var)))
    if (prod(graphics::par("mfrow")) < length(which.var)) 
        graphics::par(ask = TRUE)
    graphics::par(mar = c(2.6, 2.6, 1.1, 1.1))
    score <- x$l1[, xax]
    for (i in which.var) {
        y <- oritab[, i]
        moy <- unlist(tapply(score, y, mean))
        graphics::plot(score, score, type = "n")
        h <- (max(score) - min(score))/40
        graphics::abline(h = moy)
        graphics::segments(score, moy[y] - h, score, moy[y] + h)
        graphics::abline(0, 1)
        scatterutil.eti(moy, moy, label = as.character(levels(y)), 
            clabel = 1.5)
        scatterutil.sub(sub[i], csub = csub, possub = possub)
    }
}
