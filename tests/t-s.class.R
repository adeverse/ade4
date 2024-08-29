library(ade4)
library(ggplot2)

dfxy <- cbind.data.frame(unif1 = runif(200, -1, 1), unif2 = runif(200, -1, 1))
posi <- factor(dfxy$unif1 > 0) : factor(dfxy$unif2 > 0)
coul <- c("black", "red", "green", "blue")

# graphics

s.class(dfxy, posi, cpoi = 2)
s.class(dfxy, posi, cell = 0, cstar = 0.5)
s.class(dfxy, posi, cell = 2, axesell = FALSE, csta = 0, col = coul)

# ggplot

aa <- s.class(dfxy, posi, plotstyle = "ggplot")
aa
all(names(aa$data)[1:2] == names(dfxy))


# wip

# xax <- 1
# yax <- 2
# ggdfxy <- data.frame(x = dfxy[, xax], y = dfxy[, yax], fac = posi)
# colnames(ggdfxy)[1:2] <- colnames(dfxy)[c(xax, yax)]
# clabel <- 1
# dfcentroid <- data.frame(meanx = tapply(ggdfxy[[colnames(dfxy)[xax]]], ggdfxy$fac, mean),
#                          meany = tapply(ggdfxy[[colnames(dfxy)[yax]]], ggdfxy$fac, mean), 
#                          label = levels(ggdfxy$fac))
# 
# ggdfxy <- merge(ggdfxy, dfcentroid, by.x = "fac", by.y = "label", all.x = TRUE)
# ggdfxy <- ggdfxy[, c(colnames(dfxy)[c(xax, yax)], "meanx", "meany", "fac")]
# 
# ggsclass <- ggplot2::ggplot(data = ggdfxy, ggplot2::aes(.data$x, .data$y)) +
#   ggplot2::geom_hline(ggplot2::aes(yintercept = 0)) +
#   ggplot2::geom_vline(ggplot2::aes(xintercept = 0)) +
#   ggplot2::geom_point() +
#   ggplot2::geom_segment(aes(x = x, y = y, xend = meanx, yend = meany)) +
#   ggplot2::geom_label(data = dfcentroid, mapping = aes(x = meanx, y = meany, label = label), inherit.aes = FALSE) +
#   ggplot2::theme_bw() +
#   ggplot2::theme(aspect.ratio = 1,
#                  axis.text = ggplot2::element_blank(), 
#                  axis.title = ggplot2::element_blank(),
#                  axis.ticks = ggplot2::element_blank())
# 
# ggsclass
