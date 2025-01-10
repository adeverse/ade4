library(ade4)
library(ggplot2)

data(deug)
x <- dudi.pca(deug$tab, scannf = FALSE, nf = 4)
xax <- 1
yax <- 2
clab.row <- 0.75
clab.col <- 1

# graphics version
dd1 <- dudi.pca(deug$tab, scannf = FALSE, nf = 4)
scatter(dd1, posieig = "none")


# ggplot version
coolig <- x$li[, c(xax, yax)]
coocol <- x$c1[, c(xax, yax)]
s.label(coolig, clabel = clab.row)
(gglab <- s.label(coolig, clabel = clab.row, plotstyle = "ggplot"))

born <- graphics::par("usr")
k1 <- min(coocol[, 1])/born[1]
k2 <- max(coocol[, 1])/born[2]
k3 <- min(coocol[, 2])/born[3]
k4 <- max(coocol[, 2])/born[4]
k <- c(k1, k2, k3, k4)
coocol <- 0.9 * coocol/max(k)
(ggarrow <- s.arrow(coocol, clabel = clab.col, possub = "bottomright", plotstyle = "ggplot"))

# superpose labels and arrows
gglab + ggarrow$layers[[3]] + ggarrow$layers[[4]] 
