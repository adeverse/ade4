"s.label" <- function(dfxy, xax = 1, yax = 2, label = row.names(dfxy), clabel = 1,
                      pch = 20, cpoint = if (clabel == 0) 1 else 0, boxes = TRUE, neig = NULL,
                      cneig = 2, xlim = NULL, ylim = NULL, grid = TRUE, addaxes = TRUE,
                      cgrid = 1, include.origin = TRUE, origin = c(0, 0), sub = "",
                      csub = 1.25, possub = "bottomleft", pixmap = NULL, contour = NULL,
                      area = NULL, add.plot = FALSE, plotstyle = "graphics") {
  
  # check the 'plotstyle' argument
  plotstyle <- match.arg(plotstyle[1], choices = c("graphics", "ggplot"), several.ok = FALSE)
  
  if(plotstyle == "graphics") {
    
    dfxy <- data.frame(dfxy)
    opar <- graphics::par(mar = graphics::par("mar"))
    on.exit(graphics::par(opar))
    graphics::par(mar = c(0.1, 0.1, 0.1, 0.1))
    coo <- scatterutil.base(dfxy = dfxy, xax = xax, yax = yax,
                            xlim = xlim, ylim = ylim, grid = grid, addaxes = addaxes,
                            cgrid = cgrid, include.origin = include.origin, origin = origin,
                            sub = sub, csub = csub, possub = possub, pixmap = pixmap,
                            contour = contour, area = area, add.plot = add.plot)
    if (!is.null(neig)) {
      if (is.null(class(neig)))
        neig <- NULL
      if (!inherits(neig, "neig"))
        neig <- NULL
      deg <- attr(neig, "degrees")
      if ((length(deg)) != (length(coo$x)))
        neig <- NULL
    }
    if (!is.null(neig)) {
      fun <- function(x, coo) {
        graphics::segments(coo$x[x[1]], coo$y[x[1]], coo$x[x[2]], coo$y[x[2]],
                           lwd = graphics::par("lwd") * cneig)
      }
      apply(unclass(neig), 1, fun, coo = coo)
    }
    if (clabel > 0)
      scatterutil.eti(coo$x, coo$y, label, clabel, boxes)
    if (cpoint > 0 && clabel < 1e-6)
      graphics::points(coo$x, coo$y, pch = pch, cex = graphics::par("cex") * cpoint)
    graphics::box()
    invisible(match.call())
    
  } else if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 needed for this function to work with plotstyle = 'ggplot'. Please install it", call. = FALSE)
    
  } else {
    ggdfxy <- data.frame(x = dfxy[, xax], y = dfxy[, yax], lab = label)
    colnames(ggdfxy)[1:2] <- colnames(dfxy)[c(xax, yax)]
    
    ggslabel <- 
      ggplot2::ggplot(data = ggdfxy, ggplot2::aes(x = .data[[colnames(ggdfxy)[1]]], 
                                                  y = .data[[colnames(ggdfxy)[2]]], 
                                                  label = .data$lab)) +
      ggplot2::geom_hline(ggplot2::aes(yintercept = 0)) +
      ggplot2::geom_vline(ggplot2::aes(xintercept = 0)) +
      ggplot2::geom_label() +
      ggplot2::theme_bw() +
      ggplot2::theme(aspect.ratio = 1,
                     axis.text = ggplot2::element_blank(),
                     axis.title = ggplot2::element_blank(),
                     axis.ticks = ggplot2::element_blank())
    
    return(ggslabel)
  }
}
