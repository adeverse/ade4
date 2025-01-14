library(ade4)
library(ggplot2)

data(deug)
x <- dudi.pca(deug$tab, scannf = FALSE, nf = 4)

# graphics version
dd1 <- dudi.pca(deug$tab, scannf = FALSE, nf = 4)
scatter(dd1, posieig = "none")

# ggplot version
scatter(dd1, plotstyle = "ggplot")
