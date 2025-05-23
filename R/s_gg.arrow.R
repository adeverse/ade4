"s_gg.arrow" <- function(dfxy, xax = 1, yax = 2, label = row.names(dfxy), clabel = 1,
                      pch = 20, cpoint = 0, boxes = TRUE, edge = TRUE, origin = c(0, 0), xlim = NULL,
                      ylim = NULL, grid = TRUE, addaxes = TRUE, cgrid = 1, sub = "",
                      csub = 1.25, possub = "bottomleft", pixmap = NULL, contour = NULL,
                      area = NULL, add.plot = FALSE) {
  
  if (!requireNamespace("ggplot2", quietly = TRUE) ||
      !requireNamespace("ggrepel", quietly = TRUE)) {
    stop("Packages 'ggplot2' and 'ggrepel' are required. Please install them.", call. = FALSE)
    
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
