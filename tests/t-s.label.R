library(ade4)
library(ggplot2)

x1 <- runif(50, -2, 2)
y1 <- runif(50, -2, 2)
dfxy <- data.frame(x1, y1)
label <- row.names(dfxy)
z <- x1^2 + y1^2

# graphics

s.label(dfxy, lab = as.character(z < 1))
s.label(dfxy)
s.label(dfxy, boxes = FALSE, clabel = 0)


# ggplot

s.label(dfxy, plotstyle = "ggplot")
s.label(dfxy, plotstyle = "ggplot") +
  ggplot2::geom_label(aes(label = as.character(z < 1)))

s.label(dfxy, plotstyle = "ggplot", clabel = 0) +
  geom_point()

s.label(dfxy, plotstyle = "ggplot") +
  ggplot2::theme(axis.text=element_text())
  