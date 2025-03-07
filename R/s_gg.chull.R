"s_gg.chull" <- function (dfxy, fac, xax = 1, yax = 2, optchull = c(0.25, 0.5,
    0.75, 1), label = levels(fac), clabel = 1, cpoint = 0, col = rep(1, length(levels(fac))),
    xlim = NULL, ylim = NULL, grid = TRUE, addaxes = TRUE, origin = c(0, 0), 
    include.origin = TRUE, sub = "", csub = 1, possub = "bottomleft", 
    cgrid = 1, pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE) 
{
  if (!requireNamespace("ggplot2", quietly = TRUE) || !requireNamespace("dplyr", quietly = TRUE)) {
    stop("ggplot2 and dplyr needed for this function. Please install them", call. = FALSE)
    
  } else {
  
  	ggdfxy <- data.frame(x = dfxy[, xax], y = dfxy[, yax], lab = fac)
    colnames(ggdfxy)[1:2] <- colnames(dfxy)[c(xax, yax)]

	hulls <- ggdfxy %>%
	  group_by(lab) %>%
	  slice(chull(Axis1, Axis2))
	
	ggschull <- ggplot2::ggplot(data = ggdfxy, ggplot2::aes(x = .data[[colnames(ggdfxy)[1]]],
			y = .data[[colnames(ggdfxy)[2]]], label = .data$lab)) +
			ggplot2::geom_hline(ggplot2::aes(yintercept = 0)) +
			ggplot2::geom_vline(ggplot2::aes(xintercept = 0)) +
			ggplot2::aes(fill = lab) +
			ggplot2::geom_polygon(data = hulls, alpha = 0.5) +
			ggplot2::geom_point(shape = 21) +
			ggplot2::coord_fixed(ratio = 1)
  }
  return(ggschull)
}
