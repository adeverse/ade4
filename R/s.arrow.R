"s.arrow" <- function(dfxy, xax = 1, yax = 2, label = row.names(dfxy), clabel = 1,
                      pch = 20, cpoint = 0, boxes = TRUE, edge = TRUE, origin = c(0, 0), xlim = NULL,
                      ylim = NULL, grid = TRUE, addaxes = TRUE, cgrid = 1, sub = "",
                      csub = 1.25, possub = "bottomleft", pixmap = NULL, contour = NULL,
                      area = NULL, add.plot = FALSE, plotstyle = "graphics") {
  
  # check the 'plotstyle' argument
  plotstyle <- match.arg(plotstyle[1], choices = c("graphics", "ggplot"), several.ok = FALSE)
  
  if(plotstyle == "graphics") {
    
    arrow1 <- function(x0, y0, x1, y1, len = 0.1, ang = 15, lty = 1, edge) {
      d0 <- sqrt((x0 - x1)^2 + (y0 - y1)^2)
      if (d0 < 1e-07)
        return(invisible())
      graphics::segments(x0, y0, x1, y1, lty = lty)
      h <- graphics::strheight("A", cex = graphics::par("cex"))
      if (d0 > 2 * h) {
        x0 <- x1 - h * (x1 - x0) / d0
        y0 <- y1 - h * (y1 - y0) / d0
        if (edge)
          graphics::arrows(x0, y0, x1, y1, angle = ang, length = len, lty = 1)
      }
    }
    dfxy <- data.frame(dfxy)
    opar <- graphics::par(mar = graphics::par("mar"))
    on.exit(graphics::par(opar))
    graphics::par(mar = c(0.1, 0.1, 0.1, 0.1))
    coo <- scatterutil.base(dfxy = dfxy, xax = xax, yax = yax,
                            xlim = xlim, ylim = ylim, grid = grid, addaxes = addaxes,
                            cgrid = cgrid, include.origin = TRUE, origin = origin,
                            sub = sub, csub = csub, possub = possub, pixmap = pixmap,
                            contour = contour, area = area, add.plot = add.plot)
    if (grid && !add.plot)
      scatterutil.grid(cgrid)
    if (addaxes && !add.plot)
      graphics::abline(h = 0, v = 0, lty = 1)
    if (cpoint > 0)
      graphics::points(coo$x, coo$y, pch = pch, cex = graphics::par("cex") * cpoint)
    for (i in seq_len(length(coo$x))) arrow1(origin[1], origin[2], coo$x[i], coo$y[i], edge = edge)
    if (clabel > 0)
      scatterutil.eti.circ(coo$x, coo$y, label, clabel, origin, boxes)
    if (csub > 0)
      scatterutil.sub(sub, csub, possub)
    graphics::box()
    invisible(match.call())
    
  } else if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 needed for this function to work with plotstyle = 'ggplot'. Please install it", call. = FALSE)
    
  } else {
    ggdfxy <- data.frame(x = dfxy[, xax], y = dfxy[, yax], lab = label)
    colnames(ggdfxy)[1:2] <- colnames(dfxy)[c(xax, yax)]
    
    ggsclass <- 
      ggplot2::ggplot(data = ggdfxy, ggplot2::aes(x = .data[[colnames(ggdfxy)[1]]],
                                                  y = .data[[colnames(ggdfxy)[2]]],
                                                  label = .data$lab)) +
      ggplot2::geom_hline(ggplot2::aes(yintercept = 0)) +
      ggplot2::geom_vline(ggplot2::aes(xintercept = 0)) +
      ggplot2::geom_segment(data = ggdfxy,
                            aes(x = 0, y = 0, xend = .data[[colnames(ggdfxy)[1]]], yend = .data[[colnames(ggdfxy)[2]]]),
                            arrow = ggplot2::arrow(length = ggplot2::unit(0.2, "cm"))) +
      ggrepel::geom_label_repel(data = ggdfxy, ggplot2::aes(x = .data[[colnames(ggdfxy)[1]]],
                                                            y = .data[[colnames(ggdfxy)[2]]],
                                                            label = .data$lab)) +
      ggplot2::theme_bw() +
      ggplot2::coord_fixed(ratio = 1)
    
    return(ggsclass)
  }
}
