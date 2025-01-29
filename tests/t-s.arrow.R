library(ade4)
library(ggplot2)
library(ggrepel)
set.seed(1234)

# graphics version
dfxy <- cbind.data.frame(runif(55, -2, 3), runif(55, -3, 2))
s.arrow(dfxy)

# ggplot version
s.arrow(dfxy, plotstyle = "ggplot")
