"s.corcircle" <- function(dfxy, xax = 1, yax = 2, label = row.names(df), clabel = 1,
                          grid = TRUE, sub = "", csub = 1, possub = "bottomleft", cgrid = 0,
                          fullcircle = TRUE, box = FALSE, add.plot = FALSE, plotstyle = "graphics") {
  
  # check the 'plotstyle' argument
  plotstyle <- match.arg(plotstyle[1], choices = c("graphics", "ggplot"), several.ok = FALSE)
  
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
  
  if(plotstyle == "graphics") {
    
    scatterutil.circ <- function(cgrid, h, grid) {
      cc <- seq(from = -1, to = 1, by = h)
      col <- "lightgray"
      for (i in seq_along(cc)) {
        if (grid) {
          x <- cc[i]
          a1 <- sqrt(1 - x * x)
          a2 <- (-a1)
          graphics::segments(x, a1, x, a2, col = col)
          graphics::segments(a1, x, a2, x, col = col)
        }
      }
      graphics::symbols(0, 0, circles = 1, inches = FALSE, add = TRUE)
      graphics::segments(-1, 0, 1, 0)
      graphics::segments(0, -1, 0, 1)
      if (cgrid <= 0 || !grid) {
        return(invisible())
      }
      cha <- paste("d = ", h, sep = "")
      cex0 <- graphics::par("cex") * cgrid
      xh <- graphics::strwidth(cha, cex = cex0)
      yh <- graphics::strheight(cha, cex = cex0) + graphics::strheight(" ", cex = cex0) / 2
      x0 <- graphics::strwidth(" ", cex = cex0)
      y0 <- graphics::strheight(" ", cex = cex0) / 2
      x1 <- graphics::par("usr")[2]
      y1 <- graphics::par("usr")[4]
      graphics::rect(x1 - x0, y1 - y0, x1 - xh - x0, y1 - yh - y0, col = "white", border = 0)
      graphics::text(x1 - xh / 2 - x0 / 2, y1 - yh / 2 - y0 / 2, cha, cex = cex0)
    }
    
    origin <- c(0, 0)
    df <- data.frame(dfxy)
    if (!is.data.frame(df))
      stop("Non convenient selection for df")
    if ((xax < 1) || (xax > ncol(df)))
      stop("Non convenient selection for xax")
    if ((yax < 1) || (yax > ncol(df)))
      stop("Non convenient selection for yax")
    x <- df[, xax]
    y <- df[, yax]
    if (add.plot) {
      for (i in seq_along(x)) {
        arrow1(0, 0, x[i], y[i], len = 0.1, ang = 15, edge = TRUE)
      }
      if (clabel > 0)
        scatterutil.eti.circ(x, y, label, clabel)
      return(invisible())
    }
    
    opar <- graphics::par(mar = graphics::par("mar"))
    on.exit(graphics::par(opar))
    graphics::par(mar = c(0.1, 0.1, 0.1, 0.1))
    x1 <- x
    y1 <- y
    x1 <- c(x1, -0.01, +0.01)
    y1 <- c(y1, -0.01, +0.01)
    if (fullcircle) {
      x1 <- c(x1, -1, 1)
      y1 <- c(y1, -1, 1)
    }
    x1 <- c(x1 - diff(range(x1) / 20), x1 + diff(range(x1)) / 20)
    y1 <- c(y1 - diff(range(y1) / 20), y1 + diff(range(y1)) / 20)
    graphics::plot(x1, y1, type = "n", ylab = "", asp = 1, xaxt = "n",
                   yaxt = "n", frame.plot = FALSE)
    scatterutil.circ(cgrid = cgrid, h = 0.2, grid = grid)
    for (i in seq_along(x)) {
      arrow1(0, 0, x[i], y[i], len = 0.1, ang = 15, edge = TRUE)
    }
    
    if (clabel > 0)
      scatterutil.eti.circ(x, y, label, clabel, origin)
    if (csub > 0)
      scatterutil.sub(sub, csub, possub)
    if (box)
      graphics::box()
    invisible(match.call())
    
  } else if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 needed for this function to work with plotstyle = 'ggplot'. Please install it", call. = FALSE)
    
  } else {
    ggdf <- data.frame(x = dfxy[, xax], y = dfxy[, yax], lab = row.names(dfxy))
    
    ggscorcircle <- ggplot2::ggplot(data = ggdf, ggplot2::aes(x = .data$x, y = .data$y, label = .data$lab)) +
      ggplot2::geom_hline(aes(yintercept = 0), linewidth = .2) +
      ggplot2::geom_vline(aes(xintercept = 0), linewidth = .2) +
      ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1)) +
      ggplot2::geom_segment(aes(x = 0, y = 0, xend = x, yend = y),
                   arrow = ggplot2::arrow(length = ggplot2::unit(0.5, "cm"))) +
      ggrepel::geom_label_repel(position = ggpp::position_nudge_center(x = 0.01, y = 0.01, center_x = 0, center_y = 0)) +
      ggplot2::theme_bw() +
      ggplot2::theme(aspect.ratio=1,
                     axis.text = ggplot2::element_blank(),
                     axis.title = ggplot2::element_blank(),
                     axis.ticks = ggplot2::element_blank())
    
    return(ggscorcircle)
  }
}
