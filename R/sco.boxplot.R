"sco.boxplot" <- function (score, df, labels = names(df), clabel = 1, xlim = NULL,
    grid = TRUE, cgrid = 0.75, include.origin = TRUE, origin = 0, sub = NULL, 
    csub = 1) 
{
    if (!is.vector(score)) 
        stop("vector expected for score")
    if (!is.numeric(score)) 
        stop("numeric expected for score")
    if (!is.data.frame(df)) 
        stop("data.frame expected for df")
    if (!all(unlist(lapply(df, is.factor)))) 
        stop("All variables must be factors")
    n <- length(score)
    if ((nrow(df) != n)) 
        stop("Non convenient match")
    n <- length(score)
    nvar <- ncol(df)
    nlev <- unlist(lapply(df, nlevels))
    opar <- par(mar = par("mar"))
    on.exit(par(opar))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    ymin <- scoreutil.base(y = score, xlim = xlim, grid = grid, 
        cgrid = cgrid, include.origin = include.origin, origin = origin, 
        sub = sub, csub = csub)
    n1 <- sum(nlev)
    ymax <- par("usr")[4]
    ylabel <- strheight("A", cex = par("cex") * max(1, clabel)) * 
        1.4
    yunit <- (ymax - ymin - nvar * ylabel)/n1
    y1 <- ymin + ylabel
    xmin <- par("usr")[1]
    xmax <- par("usr")[2]
    xaxp <- par("xaxp")
    nline <- xaxp[3] + 1
    v0 <- seq(xaxp[1], xaxp[2], le = nline)
    for (i in 1:nvar) {
        y2 <- y1 + nlev[i] * yunit
        rect(xmin, y1, xmax, y2)
        if (clabel > 0) {
            text((xmin + xmax)/2, y1 - ylabel/2, labels[i], cex = par("cex") * 
                clabel)
        }
        param <- tapply(score, df[, i], function(x) quantile(x, 
            seq(0, 1, by = 0.25)))
        moy <- tapply(score, df[, i], mean)
        nbox <- length(param)
        namebox <- names(param)
        pp <- ppoints(n = (nbox + 2), a = 1)
        pp <- pp[2:(nbox + 1)]
        ypp <- y1 + (y2 - y1) * pp
        hbar <- (y2 - y1)/nbox/4
        if (grid) {
            segments(v0, rep(y1, nline), v0, rep(y2, nline), 
                col = gray(0.5), lty = 1)
        }
        for (j in 1:nbox) {
            stat <- unlist(param[j])
            amin <- stat[1]
            aq1 <- stat[2]
            amed <- stat[3]
            aq2 <- stat[4]
            amax <- stat[5]
            rect(aq1, ypp[j] - hbar, aq2, ypp[j] + hbar, col = "white")
            segments(amed, ypp[j] - hbar, amed, ypp[j] + hbar, 
                lwd = 2)
            segments(amin, ypp[j], aq1, ypp[j])
            segments(amax, ypp[j], aq2, ypp[j])
            segments(amin, ypp[j] - hbar, amin, ypp[j] + hbar)
            segments(amax, ypp[j] - hbar, amax, ypp[j] + hbar)
            points(moy[j], ypp[j], pch = 20)
            if (clabel > 0) {
                text(amax, ypp[j], namebox[j], pos = 4, cex = par("cex") * 
                  clabel * 0.8, offset = 0.2)
            }
        }
        y1 <- y2 + ylabel
    }
    invisible()
}
