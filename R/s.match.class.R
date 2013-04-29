s.match.class <-
function(df1xy, df2xy, fac, wt = rep(1/nrow(df1xy),nrow(df1xy)), xax = 1, yax = 2,
                        pch1 = 16, pch2 = 15, col1 = rep("lightgrey",nlevels(fac)),
                        col2 = rep("darkgrey",nlevels(fac)), cpoint = 1, label = levels(fac), clabel = 1, 
                        cstar = 1, cellipse = 0, axesell = TRUE,xlim = NULL, 
                        ylim = NULL, grid = TRUE, addaxes = TRUE, cgrid = 1, include.origin = TRUE, 
                        origin = c(0, 0), sub = "", csub = 1.25, possub = "bottomleft", 
                        pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE) {
  
  
  df1xy <- data.frame(df1xy)
  df2xy <- data.frame(df2xy)
  if (!is.data.frame(df1xy)) 
    stop("Non convenient selection for df1xy")
  if (!is.data.frame(df2xy)) 
    stop("Non convenient selection for df2xy")
  if (any(is.na(df1xy))) 
    stop("NA non implemented")
  if (any(is.na(df2xy))) 
    stop("NA non implemented")
  n <- nrow(df1xy)
  if (n != nrow(df2xy)) 
    stop("Non equal row numbers")
  if (!is.factor(fac)) 
    stop("factor expected for fac")
  
  dfdistri <- fac2disj(fac) * wt
  w1 <- unlist(lapply(dfdistri, sum))
  dfdistri <- t(t(dfdistri)/w1)
  coox1 <- as.matrix(t(dfdistri)) %*% df1xy[, xax]
  cooy1 <- as.matrix(t(dfdistri)) %*% df1xy[, yax]
  coox2 <- as.matrix(t(dfdistri)) %*% df2xy[, xax]
  cooy2 <- as.matrix(t(dfdistri)) %*% df2xy[, yax]
  if (nrow(df1xy) != nrow(dfdistri)) 
    stop(paste("Non equal row numbers", nrow(df1xy), nrow(dfdistri)))   
  
  opar <- par(mar = par("mar"))
  on.exit(par(opar))
  par(mar = c(0.1, 0.1, 0.1, 0.1))
  coo <- scatterutil.base(dfxy = rbind.data.frame(df1xy, df2xy), 
                          xax = xax, yax = yax, xlim = xlim, ylim = ylim, grid = grid, 
                          addaxes = addaxes, cgrid = cgrid, include.origin = include.origin, 
                          origin = origin, sub = sub, csub = csub, possub = possub, 
                          pixmap = pixmap, contour = contour, area = area, add.plot = add.plot)
  
  points(cbind(coox1,cooy1),pch=pch1,cex=4 * par("cex") * cpoint,col=col1)
  points(cbind(coox2,cooy2),pch=pch2,cex=4 * par("cex") * cpoint,col=col2)
  coo1=list(x=coo$x[1:n],y=coo$y[1:n])
  coo2=list(x=coo$x[(n+1):(2*n)],y=coo$y[(n+1):(2*n)])
  if (cpoint > 0){
    for (i in 1:ncol(dfdistri)) {
      points(coo1$x[dfdistri[, i] > 0], coo1$y[dfdistri[, i] > 0], pch = pch1, cex = par("cex") * cpoint, col = col1[i])
      points(coo2$x[dfdistri[, i] > 0], coo2$y[dfdistri[, i] > 0], pch = pch2, cex = par("cex") * cpoint, col = col2[i])            
    }
  }
  if (cstar > 0) {
    for (i in 1:ncol(dfdistri)) {
            scatterutil.star(coo1$x, coo1$y, dfdistri[, i], cstar = cstar, col1[i])
            scatterutil.star(coo2$x, coo2$y, dfdistri[, i], cstar = cstar, col2[i])
          }
  }
  if (cellipse > 0) {
    for (i in 1:ncol(dfdistri)) {
      scatterutil.ellipse(coo1$x, coo1$y, dfdistri[, i], cellipse = cellipse, axesell = axesell, col1[i])
      scatterutil.ellipse(coo2$x, coo2$y, dfdistri[, i], cellipse = cellipse, axesell = axesell, col2[i])
    }
  }
  
  for (i in 1:n) {
    segments(coox1[i], cooy1[i], coox2[i], cooy2[i], lty = 1, lwd=2)
  }
  if (clabel > 0) {
    a <- (coox1 + coox2)/2
    b <- (cooy1 + cooy2)/2
    scatterutil.eti(a, b, label, clabel)
  } 
  
  box()
  invisible(match.call())
}

