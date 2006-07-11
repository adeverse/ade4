"s.distri" <- function (dfxy, dfdistri, xax = 1, yax = 2, cstar = 1, cellipse = 1.5,
    axesell = TRUE, label = names(dfdistri), clabel = 0, cpoint = 1, 
    pch = 20, xlim = NULL, ylim = NULL, grid = TRUE, addaxes = TRUE, 
    origin = c(0, 0), include.origin = TRUE, sub = "", csub = 1, 
    possub = "bottomleft", cgrid = 1, pixmap = NULL, contour = NULL, 
    area = NULL, add.plot = FALSE) 
{
    opar <- par(mar = par("mar"))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    on.exit(par(opar))
    dfxy <- data.frame(dfxy)
    dfdistri <- data.frame(dfdistri)
    if (!is.data.frame(dfxy)) 
        stop("Non convenient selection for dfxy")
    if (!is.data.frame(dfdistri)) 
        stop("Non convenient selection for dfdistri")
    if (any(dfdistri < 0)) 
        stop("Non convenient selection for dfdistri")
    if (nrow(dfxy) != nrow(dfdistri)) 
        stop("Non equal row numbers")
    if (any(is.na(dfxy))) 
        stop("NA non implemented")
    w1 <- unlist(lapply(dfdistri, sum))
    label <- label
    dfdistri <- t(t(dfdistri)/w1)
    coox <- as.matrix(t(dfdistri)) %*% as.matrix(dfxy[, xax])
    cooy <- as.matrix(t(dfdistri)) %*% as.matrix(dfxy[, yax])
    coo <- scatterutil.base(dfxy = dfxy, xax = xax, yax = yax, 
        xlim = xlim, ylim = ylim, grid = grid, addaxes = addaxes, 
        cgrid = cgrid, include.origin = include.origin, origin = origin, 
        sub = sub, csub = csub, possub = possub, pixmap = pixmap, 
        contour = contour, area = area, add.plot = add.plot)
    if (cpoint > 0) 
        points(coo$x, coo$y, pch = pch, cex = par("cex") * cpoint)
    if (cstar > 0) 
        for (i in 1:ncol(dfdistri)) {
            scatterutil.star(coo$x, coo$y, dfdistri[, i], cstar = cstar)
        }
    if (cellipse > 0) 
        for (i in 1:ncol(dfdistri)) {
            scatterutil.ellipse(coo$x, coo$y, dfdistri[, i], 
                cellipse = cellipse, axesell = axesell)
        }
    if (clabel > 0) 
        scatterutil.eti(unlist(coox), unlist(cooy), label, clabel)
    box()
    invisible(match.call())
}
