"s.traject" <- function (dfxy, fac = factor(rep(1, nrow(dfxy))), ord = (1:length(fac)),
    xax = 1, yax = 2, label = levels(fac), clabel = 1, cpoint = 1, 
    pch = 20, xlim = NULL, ylim = NULL, grid = TRUE, addaxes = TRUE, 
    edge = TRUE, origin = c(0, 0), include.origin = TRUE, sub = "", 
    csub = 1, possub = "bottomleft", cgrid = 1, pixmap = NULL, 
    contour = NULL, area = NULL, add.plot = FALSE) 
{
    opar <- par(mar = par("mar"))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    on.exit(par(opar))
    dfxy <- data.frame(dfxy)
    if (!is.data.frame(dfxy)) 
        stop("Non convenient selection for dfxy")
    if (any(is.na(dfxy))) 
        stop("NA non implemented")
    if (!is.factor(fac)) 
        stop("factor expected for fac")
    if (length(fac) != nrow(dfxy)) 
        stop("Non convenient length (fac)")
    if (length(ord) != nrow(dfxy)) 
        stop("Non convenient length (ord)")
    coo <- scatterutil.base(dfxy = dfxy, xax = xax, yax = yax, 
        xlim = xlim, ylim = ylim, grid = grid, addaxes = addaxes, 
        cgrid = cgrid, include.origin = include.origin, origin = origin, 
        sub = sub, csub = csub, possub = possub, pixmap = pixmap, 
        contour = contour, area = area, add.plot = add.plot)
    arrow1 <- function(x0, y0, x1, y1, length = 0.15, angle = 15, 
        lty = 1, edge) {
        d0 <- sqrt((x0 - x1)^2 + (y0 - y1)^2)
        if (d0 < 1e-07) 
            return(invisible())
        segments(x0, y0, x1, y1, lty = lty)
        h <- strheight("A", cex = par("cex"))
        x0 <- x1 - h * (x1 - x0)/d0
        y0 <- y1 - h * (y1 - y0)/d0
        if (edge) 
            arrows(x0, y0, x1, y1, angle = 15, length = 0.1, lty = 1)
    }
    trajec <- function(X, cpoint, clabel, label) {
        if (nrow(X) == 1) 
            return(as.numeric(X[1, ]))
        x <- X$x
        y <- X$y
        ord <- order(X$ord)
        fac <- as.numeric(X$fac)
        dmax <- 0
        xmax <- 0
        ymax <- 0
        for (i in 1:(length(x) - 1)) {
            x0 <- x[ord[i]]
            y0 <- y[ord[i]]
            x1 <- x[ord[i + 1]]
            y1 <- y[ord[i + 1]]
            arrow1(x0, y0, x1, y1, lty = fac, edge = edge)
            if (cpoint > 0) 
                points(x0, y0, pch = (14 + fac)%%25, cex = par("cex") * 
                  cpoint)
            d0 <- sqrt((origin[1] - (x0 + x1)/2)^2 + (origin[2] - 
                (y0 + y1)/2)^2)
            if (d0 > dmax) {
                xmax <- (x0 + x1)/2
                ymax <- (y0 + y1)/2
                dmax <- d0
            }
        }
        if (cpoint > 0) 
            points(x[ord[length(x)]], y[ord[length(x)]], pch = (14 + 
                fac)%%25, cex = par("cex") * cpoint)
        return(c(xmax, ymax))
    }
    provi <- cbind.data.frame(x = coo$x, y = coo$y, fac = fac, 
        ord = ord)
    provi <- split(provi, fac)
    w <- lapply(provi, trajec, cpoint = cpoint, clabel = clabel, 
        label = label)
    w <- t(data.frame(w))
    if (clabel > 0) 
        scatterutil.eti(w[, 1], w[, 2], label, clabel)
    box()
    invisible(match.call())
}
