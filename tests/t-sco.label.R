library(ade4)
library(ggplot2)

data(meau)
envpca <- dudi.pca(meau$env, scannf=FALSE)

# graphics

sco.label(envpca$l1[,1], row.names(envpca$l1))
sco.label(envpca$l1[,1], row.names(envpca$l1), reverse = TRUE)
sco.label(envpca$l1[,1], row.names(envpca$l1), horizontal = FALSE)
sco.label(envpca$l1[,1], row.names(envpca$l1), horizontal = FALSE, reverse = TRUE)

# sco.label(envpca$co[,1], row.names(envpca$co), reverse = TRUE)



# ggplot

sco.label(envpca$l1[,1], row.names(envpca$l1), plotstyle = "ggplot")
sco.label(envpca$l1[,1], row.names(envpca$l1), plotstyle = "ggplot", reverse = TRUE)
sco.label(envpca$l1[,1], row.names(envpca$l1), plotstyle = "ggplot", horizontal = FALSE)
sco.label(envpca$l1[,1], row.names(envpca$l1), plotstyle = "ggplot", reverse = TRUE, horizontal = FALSE)

dfxy <- envpca$l1
dfxy <- dfxy[order(dfxy[,1]),]
xax <- 1
label <- row.names(dfxy)
ggdfxy <- data.frame(x0 = dfxy[, xax], x1 = seq(min(dfxy[, xax]), max(dfxy[, xax]), length.out = nrow(dfxy)),
                     y0 = 0, y1 = 1, lab = label)

# ggslabel <- 
ggplot2::ggplot(data = ggdfxy, ggplot2::aes(x0, y0, xend = x1, yend = y1, label = .data$lab)) +
  ggplot2::geom_hline(ggplot2::aes(yintercept = 0)) +
  ggplot2::geom_vline(ggplot2::aes(xintercept = 0)) +
  ggplot2::geom_segment() +
  ggplot2::geom_point(ggplot2::aes(x = x0, y = y0)) +
  ggplot2::geom_label(ggplot2::aes(x = x1, y = y1 + 0.01, label = .data$lab)) +
  ggplot2::theme_bw() +
  ggplot2::ylim(0, 1.5) +
  ggplot2::theme(aspect.ratio = 1,
                 axis.text = ggplot2::element_blank(),
                 axis.title = ggplot2::element_blank(),
                 axis.ticks = ggplot2::element_blank()) +
  ggplot2::coord_flip() +
scale_x_reverse()


# s.label(dfxy, plotstyle = "ggplot")
# s.label(dfxy, lab = as.character(z < 1), plotstyle = "ggplot")
# s.label(dfxy, plotstyle = "ggplot") +
#   ggplot2::geom_label(aes(label = as.character(z < 1)))
# 
# aa <- s.label(dfxy, plotstyle = "ggplot") +
#   geom_point()
# # to remove labels a posteriori
# aa$layers[[3]] <- NULL
# aa
# 
# s.label(dfxy, plotstyle = "ggplot") +
#   ggplot2::theme(axis.text=element_text())
# 
# # the data contained in the ggplot2 graph has the same columns names as the input data
# names(aa$data)
