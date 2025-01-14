library(ade4)
library(ggplot2)

data(deug)
x <- dudi.pca(deug$tab, scannf = FALSE, nf = 4)

# graphics version
dd1 <- dudi.pca(deug$tab, scannf = FALSE, nf = 4)
scatter(dd1, posieig = "none")

# ggplot version
(gg1 <- scatter(dd1, plotstyle = "ggplot"))

# update after
gg1 + ggplot2::theme_grey()
gg1 + ggplot2::geom_label(colour = "red")
gg1 + ggplot2::geom_label(label.size = NA)
