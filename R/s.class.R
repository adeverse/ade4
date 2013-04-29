"s.class" <- function (dfxy, fac, wt = rep(1, length(fac)), xax = 1, yax = 2, 
                       cstar = 1, cellipse = 1.5, axesell = TRUE, label = levels(fac), 
                       clabel = 1, cpoint = 1, pch = 20, col = rep(1, length(levels(fac))), xlim = NULL, ylim = NULL, 
                       grid = TRUE, addaxes = TRUE, origin = c(0, 0), include.origin = TRUE, 
                       sub = "", csub = 1, possub = "bottomleft", cgrid = 1, pixmap = NULL, 
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
  dfdistri <- fac2disj(fac) * wt
  coul <- col
  w1 <- unlist(lapply(dfdistri, sum))
  dfdistri <- t(t(dfdistri)/w1)
  coox <- as.matrix(t(dfdistri)) %*% dfxy[, xax]
  cooy <- as.matrix(t(dfdistri)) %*% dfxy[, yax]
  if (nrow(dfxy) != nrow(dfdistri)) 
    stop(paste("Non equal row numbers", nrow(dfxy), nrow(dfdistri)))
  coo <- scatterutil.base(dfxy = dfxy, xax = xax, yax = yax, 
                          xlim = xlim, ylim = ylim, grid = grid, addaxes = addaxes, 
                          cgrid = cgrid, include.origin = include.origin, origin = origin, 
                          sub = sub, csub = csub, possub = possub, pixmap = pixmap, 
                          contour = contour, area = area, add.plot = add.plot)
  if (cpoint > 0)
    for (i in 1:ncol(dfdistri)) {
      pch <- rep(pch, length = nrow(dfxy))
      points(coo$x[dfdistri[,i] > 0], coo$y[dfdistri[,i] > 0], pch = pch[dfdistri[,i] > 0], cex = par("cex") * cpoint, col=coul[i])
    }
  if (cstar > 0) 
    for (i in 1:ncol(dfdistri)) {
      scatterutil.star(coo$x, coo$y, dfdistri[, i], cstar = cstar, coul[i])
    }
  if (cellipse > 0) 
    for (i in 1:ncol(dfdistri)) {
      scatterutil.ellipse(coo$x, coo$y, dfdistri[, i], 
                          cellipse = cellipse, axesell = axesell, coul[i])
    }
  if (clabel > 0) 
    scatterutil.eti(coox, cooy, label, clabel, coul = col)
  box()
  invisible(match.call())
}
