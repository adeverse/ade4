"s.chull" <- function (dfxy, fac, xax = 1, yax = 2, optchull = c(0.25, 0.5,
    0.75, 1), label = levels(fac), clabel = 1, cpoint = 0, xlim = NULL, 
    ylim = NULL, grid = TRUE, addaxes = TRUE, origin = c(0, 0), 
    include.origin = TRUE, sub = "", csub = 1, possub = "bottomleft", 
    cgrid = 1, pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE) 
{
    dfxy <- data.frame(dfxy)
    opar <- par(mar = par("mar"))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    on.exit(par(opar))
    coo <- scatterutil.base(dfxy = dfxy, xax = xax, yax = yax, 
        xlim = xlim, ylim = ylim, grid = grid, addaxes = addaxes, 
        cgrid = cgrid, include.origin = include.origin, origin = origin, 
        sub = sub, csub = csub, possub = possub, pixmap = pixmap, 
        contour = contour, area = area, add.plot = add.plot)
    scatterutil.chull(coo$x, coo$y, fac, optchull = optchull)
    if (cpoint > 0) 
        points(coo$x, coo$y, pch = 20, cex = par("cex") * cpoint)
    if (clabel > 0) {
        coox <- tapply(coo$x, fac, mean)
        cooy <- tapply(coo$y, fac, mean)
        scatterutil.eti(coox, cooy, label, clabel)
    }
    box()
}
