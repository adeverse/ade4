"s.arrow" <- function (dfxy, xax = 1, yax = 2, label = row.names(dfxy), clabel = 1,
    pch = 20, cpoint = 0, boxes = TRUE, edge = TRUE, origin = c(0, 0), xlim = NULL, 
    ylim = NULL, grid = TRUE, addaxes = TRUE, cgrid = 1, sub = "", 
    csub = 1.25, possub = "bottomleft", pixmap = NULL, contour = NULL, 
    area = NULL, add.plot = FALSE) 
{
    arrow1 <- function(x0, y0, x1, y1, len = 0.1, ang = 15, lty = 1, 
        edge) {
        d0 <- sqrt((x0 - x1)^2 + (y0 - y1)^2)
        if (d0 < 1e-07) 
            return(invisible())
        segments(x0, y0, x1, y1, lty = lty)
        h <- strheight("A", cex = par("cex"))
        if (d0 > 2 * h) {
            x0 <- x1 - h * (x1 - x0)/d0
            y0 <- y1 - h * (y1 - y0)/d0
            if (edge) 
                arrows(x0, y0, x1, y1, angle = ang, length = len, 
                  lty = 1)
        }
    }
    dfxy <- data.frame(dfxy)
    opar <- par(mar = par("mar"))
    on.exit(par(opar))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    coo <- scatterutil.base(dfxy = dfxy, xax = xax, yax = yax, 
        xlim = xlim, ylim = ylim, grid = grid, addaxes = addaxes, 
        cgrid = cgrid, include.origin = TRUE, origin = origin, 
        sub = sub, csub = csub, possub = possub, pixmap = pixmap, 
        contour = contour, area = area, add.plot = add.plot)
    if (grid & !add.plot) 
        scatterutil.grid(cgrid)
    if (addaxes & !add.plot) 
        abline(h = 0, v = 0, lty = 1)
    if (cpoint > 0) 
        points(coo$x, coo$y, pch = pch, cex = par("cex") * cpoint)
    for (i in 1:(length(coo$x))) arrow1(origin[1], origin[2], 
        coo$x[i], coo$y[i], edge = edge)
    if (clabel > 0) 
        scatterutil.eti.circ(coo$x, coo$y, label, clabel, origin, boxes)
    if (csub > 0) 
        scatterutil.sub(sub, csub, possub)
    box()
    invisible(match.call())
}
