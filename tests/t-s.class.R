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
(gg1 <- s.class(dfxy, posi, plotstyle = "ggplot"))
all(names(gg1$data)[1:2] == names(dfxy))


# with ellipses

xax <- 1
yax <- 2
wt <- rep(1, length(posi))
dfdistri <- ade4:::fac2disj(posi) * wt
w1 <- unlist(lapply(dfdistri, sum))
dfdistri <- t(t(dfdistri) / w1)

ggdfxy <- data.frame(x = dfxy[, xax], y = dfxy[, yax], fac = posi)
colnames(ggdfxy)[1:2] <- colnames(dfxy)[c(xax, yax)]
dfcentroid <- data.frame(meanx = tapply(ggdfxy[[colnames(dfxy)[xax]]], ggdfxy$fac, mean),
                         meany = tapply(ggdfxy[[colnames(dfxy)[yax]]], ggdfxy$fac, mean), 
                         label = levels(ggdfxy$fac), 
                         a = NA, b = NA, angle = NA)


for (i in seq_len(nlevels(ggdfxy$fac))) {
  x <- dfxy[, xax]
  y <- dfxy[, yax]
  z <- dfdistri[, i]
  
  z <- z/sum(z)
  m1 <- sum(x * z)
  m2 <- sum(y * z)
  v1 <- sum((x - m1) * (x - m1) * z)
  v2 <- sum((y - m2) * (y - m2) * z)
  cxy <- sum((x - m1) * (y - m2) * z)
  
  dfcentroid[i, c("a", "b", "angle")] <- c(v1, v2, cxy)
}


ggdfxy <- merge(ggdfxy, dfcentroid, by.x = "fac", by.y = "label", all.x = TRUE)
ggdfxy <- ggdfxy[, c(colnames(dfxy)[c(xax, yax)], "meanx", "meany", "fac")]

# ggsclass <- 
  ggplot2::ggplot(data = ggdfxy, ggplot2::aes(x = .data[[colnames(ggdfxy)[1]]],
                                              y = .data[[colnames(ggdfxy)[2]]])) +
  ggplot2::geom_hline(ggplot2::aes(yintercept = 0)) +
  ggplot2::geom_vline(ggplot2::aes(xintercept = 0)) +
  ggplot2::geom_point() +
  ggplot2::geom_segment(aes(x = .data[[colnames(ggdfxy)[1]]], 
                            y = .data[[colnames(ggdfxy)[2]]], 
                            xend = .data$meanx, 
                            yend = .data$meany)) +
  ggplot2::geom_label(data = dfcentroid, mapping = aes(x = .data$meanx, y = .data$meany, label = .data$label), inherit.aes = FALSE) +
  ggforce::geom_ellipse(data = dfcentroid, mapping = aes(x0 = .data$meanx, y0 = .data$meany, a = .data$a, b = .data$b, angle = .data$angle), inherit.aes = FALSE) +
  ggplot2::theme_bw() +
  ggplot2::coord_fixed(ratio = 1)
  