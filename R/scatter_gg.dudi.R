"scatter_gg.dudi" <- function(x, xax = 1, yax = 2, clab.row = .75, clab.col = 1,
                           permute = FALSE, posieig = "top", sub = NULL, ...) {
  if (!inherits(x, "dudi"))
    stop("Object of class 'dudi' expected")
  
  coolig <- x$li[, c(xax, yax)]
  coocol <- x$c1[, c(xax, yax)]
  if (permute) {
    coolig <- x$co[, c(xax, yax)]
    coocol <- x$l1[, c(xax, yax)]
  }
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 package needed for this function. Please install it", call. = FALSE)
  } else {
    born <- c(min(coolig[,xax]), max(coolig[,xax]), min(coolig[,yax]), max(coolig[,yax]))
    k1 <- min(coocol[, 1]) / born[1]
    k2 <- max(coocol[, 1]) / born[2]
    k3 <- min(coocol[, 2]) / born[3]
    k4 <- max(coocol[, 2]) / born[4]
    k <- c(k1, k2, k3, k4)
    coocol <- 0.9 * coocol / max(k)
    gglab <- s.label(coolig, clabel = clab.row, plotstyle = "ggplot")
    ggarrow <- s.arrow(coocol, clabel = clab.col, possub = "bottomright", plotstyle = "ggplot")
    ggscatterdudi <- gglab + ggarrow$layers[[3]] + ggarrow$layers[[4]]
    return(ggscatterdudi)
  }
}
