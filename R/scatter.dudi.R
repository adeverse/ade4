"scatter.dudi" <- function(x, xax = 1, yax = 2, clab.row = .75, clab.col = 1,
                           permute = FALSE, posieig = "top", sub = NULL, plotstyle = "graphics", ...) {
  if (!inherits(x, "dudi"))
    stop("Object of class 'dudi' expected")
  
  # check the 'plotstyle' argument
  plotstyle <- match.arg(plotstyle[1], choices = c("graphics", "ggplot"), several.ok = FALSE)
  
  opar <- graphics::par(mar = graphics::par("mar"))
  on.exit(graphics::par(opar))
  coolig <- x$li[, c(xax, yax)]
  coocol <- x$c1[, c(xax, yax)]
  if (permute) {
    coolig <- x$co[, c(xax, yax)]
    coocol <- x$l1[, c(xax, yax)]
  }
  
  born <- graphics::par("usr")
  k1 <- min(coocol[, 1]) / born[1]
  k2 <- max(coocol[, 1]) / born[2]
  k3 <- min(coocol[, 2]) / born[3]
  k4 <- max(coocol[, 2]) / born[4]
  k <- c(k1, k2, k3, k4)
  coocol <- 0.9 * coocol / max(k)
  
  if(plotstyle == "graphics") {
    s.label(coolig, clabel = clab.row)
    s.arrow(coocol, clabel = clab.col, add.plot = TRUE, sub = sub, possub = "bottomright")
    add.scatter.eig(x$eig, x$nf, xax, yax, posi = posieig, ratio = 1 / 4)
    
  } else if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 needed for this function to work with plotstyle = 'ggplot'. Please install it", call. = FALSE)
    
  } else {
    gglab <- s.label(coolig, clabel = clab.row, plotstyle = "ggplot")
    ggarrow <- s.arrow(coocol, clabel = clab.col, possub = "bottomright", plotstyle = "ggplot")
    gglab + ggarrow$layers[[3]] + ggarrow$layers[[4]] 
  }
}
