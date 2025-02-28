"s_gg.label" <- function(dfxy, xax = 1, yax = 2, label = row.names(dfxy), clabel = 1,
                      pch = 20, cpoint = if (clabel == 0) 1 else 0, boxes = TRUE, neig = NULL,
                      cneig = 2, xlim = NULL, ylim = NULL, grid = TRUE, addaxes = TRUE,
                      cgrid = 1, include.origin = TRUE, origin = c(0, 0), sub = "",
                      csub = 1.25, possub = "bottomleft", pixmap = NULL, contour = NULL,
                      area = NULL, add.plot = FALSE) {
  
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 needed for this function. Please install it", call. = FALSE)
    
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
      ggplot2::coord_fixed(ratio = 1) # +
      # ggplot2::theme(axis.text = ggplot2::element_blank(),
      #               axis.title = ggplot2::element_blank(),
      #               axis.ticks = ggplot2::element_blank())
    
    return(ggslabel)
  }
}
