"s.class" <- function (dfxy, fac, wt = rep(1, length(fac)), xax = 1, yax = 2,
                       cstar = 1, cellipse = 1.5, axesell = TRUE, label = levels(fac),
                       clabel = 1, cpoint = 1, pch = 20, col = rep(1, length(levels(fac))), xlim = NULL, ylim = NULL,
                       grid = TRUE, addaxes = TRUE, origin = c(0, 0), include.origin = TRUE,
                       sub = "", csub = 1, possub = "bottomleft", cgrid = 1, pixmap = NULL,
                       contour = NULL, area = NULL, add.plot = FALSE, plotstyle = "graphics") {
  
  # check the 'plotstyle' argument
  plotstyle <- match.arg(plotstyle[1], choices = c("graphics", "ggplot"), several.ok = FALSE)
  
  dfdistri <- fac2disj(fac) * wt
  w1 <- unlist(lapply(dfdistri, sum))
  dfdistri <- t(t(dfdistri) / w1)
  
  if(plotstyle == "graphics") {
    
    opar <- graphics::par(mar = graphics::par("mar"))
    graphics::par(mar = c(0.1, 0.1, 0.1, 0.1))
    on.exit(graphics::par(opar))
    dfxy <- data.frame(dfxy)
    if (!is.data.frame(dfxy))
      stop("Non convenient selection for dfxy")
    if (any(is.na(dfxy)))
      stop("NA non implemented")
    if (!is.factor(fac))
      stop("factor expected for fac")
    coul <- col
    
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
      for (i in seq_len(ncol(dfdistri))) {
        pch <- rep(pch, length = nrow(dfxy))
        graphics::points(coo$x[dfdistri[, i] > 0], coo$y[dfdistri[, i] > 0], pch = pch[dfdistri[, i] > 0], cex = graphics::par("cex") * cpoint, col = coul[i])
      }
    if (cstar > 0)
      for (i in seq_len(ncol(dfdistri))) {
        scatterutil.star(coo$x, coo$y, dfdistri[, i], cstar = cstar, coul[i])
      }
    if (cellipse > 0)
      for (i in seq_len(ncol(dfdistri))) {
        scatterutil.ellipse(coo$x, coo$y, dfdistri[, i], cellipse = cellipse, axesell = axesell, coul[i])
      }
    if (clabel > 0)
      scatterutil.eti(coox, cooy, label, clabel, coul = col)
    graphics::box()
    invisible(match.call())
    
  } else if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 needed for this function to work with plotstyle = 'ggplot'. Please install it", call. = FALSE)
    
  } else {
    ggdfxy <- data.frame(x = dfxy[, xax], y = dfxy[, yax], fac = fac)
    colnames(ggdfxy)[1:2] <- colnames(dfxy)[c(xax, yax)]
    
    dfcentroid <- data.frame(meanx = tapply(ggdfxy[[colnames(dfxy)[xax]]], ggdfxy$fac, mean),
                             meany = tapply(ggdfxy[[colnames(dfxy)[yax]]], ggdfxy$fac, mean), 
                             label = levels(ggdfxy$fac),
                             a = NA, b = NA, angle = NA)
    for (i in seq_len(nlevels(ggdfxy$fac))) {
      x <- dfxy[, xax]
      y <- dfxy[, yax]
      z <- dfdistri[, i]
      z <- z/sum(z)
      m1 <- sum(x * z)
      m2 <- sum(y * z)
      v1 <- sum((x - m1) * (x - m1) * z)
      v2 <- sum((y - m2) * (y - m2) * z)
      cxy <- sum((x - m1) * (y - m2) * z)
      dfcentroid[i, c("a", "b", "angle")] <- c(v1, v2, cxy)
    }
    ggdfxy <- merge(ggdfxy, dfcentroid, by.x = "fac", by.y = "label", all.x = TRUE)
    ggdfxy <- ggdfxy[, c(colnames(dfxy)[c(xax, yax)], "meanx", "meany", "fac")]
    
    ggsclass <- 
      ggplot2::ggplot(data = ggdfxy, ggplot2::aes(x = .data[[colnames(ggdfxy)[1]]],
                                                  y = .data[[colnames(ggdfxy)[2]]])) +
      ggplot2::geom_hline(ggplot2::aes(yintercept = 0)) +
      ggplot2::geom_vline(ggplot2::aes(xintercept = 0)) +
      ggplot2::geom_point() +
      ggplot2::geom_segment(aes(x = .data[[colnames(ggdfxy)[1]]], 
                                y = .data[[colnames(ggdfxy)[2]]], 
                                xend = .data$meanx, 
                                yend = .data$meany)) +
      ggplot2::geom_label(data = dfcentroid, mapping = aes(x = .data$meanx, y = .data$meany, label = .data$label), inherit.aes = FALSE) +
      ggforce::geom_ellipse(data = dfcentroid, mapping = aes(x0 = .data$meanx, y0 = .data$meany, a = .data$a, b = .data$b, angle = .data$angle), inherit.aes = FALSE) +
      ggplot2::theme_bw() +
      ggplot2::coord_fixed(ratio = 1)
    
    return(ggsclass)
  }
}
