"s_gg.class" <- function (dfxy, fac, wt = rep(1, length(fac)), xax = 1, yax = 2,
                       cstar = 1, cellipse = 1.5, axesell = TRUE, label = levels(fac),
                       clabel = 1, cpoint = 1, pch = 20, col = rep(1, length(levels(fac))), xlim = NULL, ylim = NULL,
                       grid = TRUE, addaxes = TRUE, origin = c(0, 0), include.origin = TRUE,
                       sub = "", csub = 1, possub = "bottomleft", cgrid = 1, pixmap = NULL,
                       contour = NULL, area = NULL, add.plot = FALSE) {
  
  dfdistri <- fac2disj(fac) * wt
  w1 <- unlist(lapply(dfdistri, sum))
  dfdistri <- t(t(dfdistri) / w1)

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 needed for this function. Please install it", call. = FALSE)
    
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
      dfcentroid[i, c("a", "b", "angle")] <- c(v1, v2, -cxy)
    }
    ggdfxy <- merge(ggdfxy, dfcentroid, by.x = "fac", by.y = "label", all.x = TRUE)
    ggdfxy <- ggdfxy[, c(colnames(dfxy)[c(xax, yax)], "meanx", "meany", "fac")]
    
    ggsclass <- 
      ggplot2::ggplot(data = ggdfxy, ggplot2::aes(x = .data[[colnames(ggdfxy)[1]]],
                                                  y = .data[[colnames(ggdfxy)[2]]], 
                                                  col = .data$fac)) +
      ggplot2::geom_hline(ggplot2::aes(yintercept = 0)) +
      ggplot2::geom_vline(ggplot2::aes(xintercept = 0)) +
      ggplot2::geom_point() +
      ggplot2::geom_segment(aes(x = .data[[colnames(ggdfxy)[1]]], 
                                y = .data[[colnames(ggdfxy)[2]]], 
                                xend = .data$meanx, 
                                yend = .data$meany, 
                                col = .data$fac)) +
      ggforce::geom_ellipse(data = dfcentroid, mapping = aes(x0 = .data$meanx, y0 = .data$meany, a = .data$a, b = .data$b, angle = .data$angle, col = .data$label), inherit.aes = FALSE) +
      ggplot2::geom_label(data = dfcentroid, mapping = aes(x = .data$meanx, y = .data$meany, label = .data$label, col = .data$label), inherit.aes = FALSE) +
      ggplot2::theme_bw() +
      ggplot2::coord_fixed(ratio = 1) +
      ggplot2::guides(color = "none")
    
    return(ggsclass)
  }
}
