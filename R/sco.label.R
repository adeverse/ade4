################################
## Evenly spaced labels for a score
################################
## Can be used as a legend for the Gauss curve function.
## Takes one vector of quantitative values (abscissae) and draws lines connecting
## these abscissae to evenly spaced labels.
################################
"sco.label" <- function(score, label = names(score),  clabel = 1, horizontal = TRUE, reverse = FALSE,
                        pos.lab = 0.5, pch = 20, cpoint = 1, boxes = TRUE,  lim = NULL, grid = TRUE,
                        cgrid = 1, include.origin = TRUE, origin = c(0, 0), sub = "", csub = 1.25,
                        possub = "bottomleft", plotstyle = "graphics") {
  
  # check the 'plotstyle' argument
  plotstyle <- match.arg(plotstyle[1], choices = c("graphics", "ggplot"), several.ok = FALSE)
  
  if(plotstyle == "graphics") {
    
    if (!is.vector(score))
      stop("score should be a vector")
    nval <- length(score)
    if (is.null(label))
      label <- 1:nval
    if (nval != length(label))
      stop("length of 'label' is not convenient")
    
    if (pos.lab > 1 || pos.lab < 0) {
      stop("pos.lab should be between 0 and 1")
    }
    
    oldpar <- graphics::par(mar = rep(0.1, 4))
    on.exit(graphics::par(oldpar))
    res <- scatterutil.sco(score = score, lim = lim, grid = grid, cgrid = cgrid,
                           include.origin = include.origin, origin = origin, sub = sub,
                           csub = csub, horizontal = horizontal, reverse = reverse)
    if (horizontal) {
      if (reverse) {
        graphics::points(score, rep(1 - res[3], nval), pch = pch,  cex = graphics::par("cex") * cpoint)
      } else {
        graphics::points(score, rep(res[3], nval), pch = pch,  cex = graphics::par("cex") * cpoint)
      }
      if (clabel > 0) {
        if (is.null(pos.lab)) {
          pos.lab <- 0.5
        }
        if (reverse) {
          pos.lab <- 1 - res[3] - pos.lab * (1 - res[3])
          pos.elbow <- 1 - res[3] - (pos.lab - res[3]) / 5
        } else {
          pos.lab <- res[3] + pos.lab * (1 - res[3])
          pos.elbow <- res[3] + (pos.lab - res[3]) / 5
        }
        
        for (i in 1:nval) {
          xh <- graphics::strwidth(paste(" ", label[order(score)][i], " ", sep = ""), cex = graphics::par("cex") * clabel)
          tmp <- scatterutil.convrot90(xh, 0)
          yh <- tmp[2]
          y2 <- res[1] + (res[2] - res[1]) / (nval + 1) * i
          graphics::segments(score[order(score)][i], pos.elbow, y2, pos.lab)
          if (reverse) {
            graphics::segments(score[order(score)][i], 1 - res[3], score[order(score)][i], pos.elbow)
            scatterutil.eti(y2, pos.lab - yh / 2, label[order(score)][i], clabel = clabel, boxes = boxes, horizontal = FALSE)
          } else {
            graphics::segments(score[order(score)][i], res[3], score[order(score)][i], pos.elbow)
            scatterutil.eti(y2, pos.lab + yh / 2, label[order(score)][i], clabel = clabel, boxes = boxes, horizontal = FALSE)
          }
        }
      }
    } else {
      if (reverse) {
        graphics::points(rep(1 - res[3], nval), score, pch = pch,  cex = graphics::par("cex") * cpoint)
      } else {
        graphics::points(rep(res[3], nval), score, pch = pch,  cex = graphics::par("cex") * cpoint)
      }
      if (clabel > 0) {
        if (is.null(pos.lab)) {
          pos.lab <- 0.5
        }
        if (reverse) {
          pos.lab <- 1 - res[3] - pos.lab * (1 - res[3])
          pos.elbow <- 1 - res[3] - (pos.lab - res[3]) / 5
        } else {
          pos.lab <- res[3] + pos.lab * (1 - res[3])
          pos.elbow <- res[3] + (pos.lab - res[3]) / 5
        }
        
        for (i in 1:nval) {
          xh <- graphics::strwidth(paste(" ", label[order(score)][i], " ", sep = ""), cex = graphics::par("cex") * clabel)
          y2 <- res[1] + (res[2] - res[1]) / (nval + 1) * i
          graphics::segments(pos.elbow, score[order(score)][i], pos.lab, y2)
          if (reverse) {
            graphics::segments(1 - res[3], score[order(score)][i], pos.elbow, score[order(score)][i])
            scatterutil.eti(pos.lab - xh / 2, y2, label[order(score)][i], clabel = clabel, boxes = boxes, horizontal = TRUE)
          } else {
            graphics::segments(res[3], score[order(score)][i], pos.elbow, score[order(score)][i])
            scatterutil.eti(pos.lab + xh / 2, y2, label[order(score)][i], clabel = clabel, boxes = boxes, horizontal = TRUE)
          }
        }
      }
    }
    invisible(match.call())
    
  } else if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 needed for this function to work with plotstyle = 'ggplot'. Please install it", call. = FALSE)
    
  } else {
    ggscore <- score[order(score)]
    gglabel <- label[order(score)]
    ggdfxy <- data.frame(x0 = ggscore, x1 = seq(min(ggscore), max(ggscore), length.out = length(ggscore)),
                         y0 = 0, y1 = 1, lab = gglabel)
    
    ggscolabel <-
      ggplot2::ggplot(data = ggdfxy, ggplot2::aes(x0, y0, xend = x1, yend = y1, label = .data$lab)) +
      ggplot2::geom_hline(ggplot2::aes(yintercept = 0)) +
      ggplot2::geom_vline(ggplot2::aes(xintercept = 0)) +
      ggplot2::geom_segment() +
      ggplot2::geom_point(ggplot2::aes(x = x0, y = y0)) +
      {if (horizontal) ggplot2::geom_label(ggplot2::aes(x = x1, y = y1, label = .data$lab), angle = 90) else ggplot2::geom_label(ggplot2::aes(x = x1, y = y1, label = .data$lab))} +
      {if (!horizontal) ggplot2::coord_flip()} + 
      {if (reverse && horizontal) ggplot2::scale_x_reverse()} +
      {if (reverse && !horizontal) ggplot2::scale_y_reverse()} +
      ggplot2::theme_bw() +
      ggplot2::ylim(0, 1.5) +
      ggplot2::theme(aspect.ratio = 1,
                     axis.text = ggplot2::element_blank(),
                     axis.title = ggplot2::element_blank(),
                     axis.ticks = ggplot2::element_blank())
    
    return(ggscolabel)
    
  }
}
