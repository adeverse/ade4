"s_gg.chull" <- function (dfxy, fac, xax = 1, yax = 2, optchull = c(0.25, 0.5,
    0.75, 1), label = levels(fac), clabel = 4, cpoint = 0, col = rep(1, length(levels(fac))),
    xlim = NULL, ylim = NULL, grid = TRUE, addaxes = TRUE, origin = c(0, 0), 
    include.origin = TRUE, sub = "", csub = 1, possub = "bottomleft", 
    cgrid = 1, pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE) 
{
  if (!requireNamespace("ggplot2", quietly = TRUE) || !requireNamespace("dplyr", quietly = TRUE)) {
    stop("ggplot2 and dplyr needed for this function. Please install them", call. = FALSE)
    
  } else {
  
    if (clabel > 0) {
        coox <- tapply(dfxy[, xax], fac, mean)
        cooy <- tapply(dfxy[, yax], fac, mean)
        ggcooxy <- data.frame(x = coox, y = cooy, lab = levels(fac))
    }
    
  	ggdfxy <- data.frame(x = dfxy[, xax], y = dfxy[, yax], lab = fac)

	hulls <- ggdfxy %>%
	  dplyr::group_by(lab) %>%
	  dplyr::slice(chull(x, y))
	
	colnames(ggdfxy)[1:2] <- colnames(dfxy)[c(xax, yax)]
	colnames(hulls)[1:2] <- colnames(dfxy)[c(xax, yax)]

	ggschull <- ggplot2::ggplot(data = ggdfxy, ggplot2::aes(x = .data[[colnames(ggdfxy)[1]]],
			y = .data[[colnames(ggdfxy)[2]]], fill = lab))
			ggschull <- ggschull + ggplot2::coord_fixed(ratio = 1)
			if (addaxes) {
				ggschull <- ggschull + ggplot2::geom_hline(ggplot2::aes(yintercept = 0))
				ggschull <- ggschull + ggplot2::geom_vline(ggplot2::aes(xintercept = 0))
			}
			ggschull <- ggschull + ggplot2::geom_polygon(data = hulls, alpha = 0.5)
			if (cpoint > 0) ggschull <- ggschull + ggplot2::geom_point(shape = 21, size = cpoint, show.legend = FALSE)
			if (clabel > 0) ggschull <- ggschull + ggplot2::geom_label(data = ggcooxy, ggplot2::aes(x = .data$x, 
            y = .data$y, label = .data$lab), size = clabel, show.legend = FALSE)
            if (length(sub) > 0) ggschull <- ggschull + ggplot2::labs(caption = sub)
  }
  return(ggschull)
}
