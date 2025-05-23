"s_gg.corcircle" <- function(dfxy, xax = 1, yax = 2, label = row.names(dfxy), clabel = 1,
                          grid = TRUE, sub = "", csub = 1, possub = "bottomleft", cgrid = 0,
                          fullcircle = TRUE, box = FALSE, add.plot = FALSE) {
  
  
  if (!requireNamespace("ggplot2", quietly = TRUE) ||
      !requireNamespace("ggrepel", quietly = TRUE)) {
    stop("Packages 'ggplot2' and 'ggrepel' are required. Please install them.", call. = FALSE)
    
    
  } else {
    ggdfxy <- data.frame(x = dfxy[, xax], y = dfxy[, yax], lab = label)
    colnames(ggdfxy)[1:2] <- colnames(dfxy)[c(xax, yax)]
    
    ggscorcircle <-
      ggplot2::ggplot(data = ggdfxy, ggplot2::aes(x = .data[[colnames(ggdfxy)[1]]], 
                                                  y = .data[[colnames(ggdfxy)[2]]], 
                                                  label = .data$lab)) +
      ggplot2::geom_hline(aes(yintercept = 0), linewidth = .2) +
      ggplot2::geom_vline(aes(xintercept = 0), linewidth = .2) +
      ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1)) +
      ggplot2::geom_segment(aes(x = 0, y = 0, xend = .data[[colnames(ggdfxy)[1]]], yend = .data[[colnames(ggdfxy)[2]]]),
                   arrow = ggplot2::arrow(length = ggplot2::unit(0.5, "cm"))) +
      ggrepel::geom_label_repel(position = ggpp::position_nudge_center(x = 0.01, y = 0.01, center_x = 0, center_y = 0),
                               max.overlaps = 12) +
      ggplot2::theme_bw() +
      ggplot2::theme(aspect.ratio=1,
                     axis.text = ggplot2::element_blank(),
                     axis.title = ggplot2::element_blank(),
                     axis.ticks = ggplot2::element_blank())
    
    return(ggscorcircle)
  }
}
