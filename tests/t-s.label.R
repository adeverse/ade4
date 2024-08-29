library(ade4)
library(ggplot2)

monx <- runif(50, -2, 2)
mony <- runif(50, -2, 2)
dfxy <- data.frame(monx, mony)
label <- row.names(dfxy)
z <- monx^2 + mony^2

# graphics

s.label(dfxy, lab = as.character(z < 1))
s.label(dfxy)
s.label(dfxy, boxes = FALSE, clabel = 0)


# ggplot

s.label(dfxy, plotstyle = "ggplot")
s.label(dfxy, lab = as.character(z < 1), plotstyle = "ggplot")
s.label(dfxy, plotstyle = "ggplot") +
  ggplot2::geom_label(aes(label = as.character(z < 1)))

aa <- s.label(dfxy, plotstyle = "ggplot") +
  geom_point()
# to remove labels a posteriori
aa$layers[[3]] <- NULL
aa

s.label(dfxy, plotstyle = "ggplot") +
  ggplot2::theme(axis.text=element_text())

# the data contained in the ggplot2 graph has the same columns names as the input data
names(aa$data)
