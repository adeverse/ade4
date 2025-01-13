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


###### doubs example 

data(doubs)
pca1 <- dudi.pca(doubs$env, scan = FALSE)

s.label(pca1$li)
s.label(pca1$li, plotstyle = "ggplot")


data(doubs)
pca1 <- dudi.pca(doubs$env, scan = FALSE)
data <- data.frame(x =pca1$li[,1],y =pca1$li[,2])
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  coord_fixed()

# ==============================
  
# Charger les données et effectuer l'ACP
data(doubs)
pca1 <- dudi.pca(doubs$env, scan = FALSE)
data <- data.frame(x = pca1$li[, 1], y = pca1$li[, 2])

# Calculer les limites pour que la grille soit uniforme
xlim <- range(data$x)
ylim <- range(data$y)
breaks <- seq(min(abs(c(xlim, ylim))), max(abs(c(xlim, ylim))), by = 1) # Ajuste l'intervalle selon besoin

# Créer le graphique avec une grille uniforme
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  coord_equal() +   # Fixe les axes pour qu'ils soient orthonormés
  scale_x_continuous(breaks = breaks, limits = c(min(abs(c(xlim, ylim))), max(abs(c(xlim, ylim))))) +
  scale_y_continuous(breaks = breaks, limits = c(min(abs(c(xlim, ylim))), max(abs(c(xlim, ylim)))))
