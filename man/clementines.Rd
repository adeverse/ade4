\encoding{latin1}
\name{clementines}
\alias{clementines}
\docType{data}
\title{Fruit Production}
\description{
The \code{clementines} is a data set containing the fruit production of 20 clementine trees during 15 years.
}
\usage{data(clementines)}
\format{
A data frame with 15 rows and 20 columns
}
\source{
Tisné-Agostini, D. (1988) \emph{Description par analyse en composantes principales de l'évolution de 
la production du clémentinier en association avec 12 types de porte-greffe}.
Rapport technique, DEA Analyse et modélisation des systèmes biologiques, Université Lyon 1. 
}
\examples{
data(clementines)

op <- par(no.readonly = TRUE) 
par(mfrow = c(5, 4))
par(mar = c(2, 2, 1, 1))
for(i in 1:20) {
  w0 <- 1:15
  plot(w0, clementines[, i], type = "b")
  abline(lm(clementines[, i] ~ w0))
}
par(op)

pca1 <- dudi.pca(clementines, scan = FALSE)
if(adegraphicsLoaded()) {
  g1 <- s.corcircle(pca1$co, plab.cex = 0.75)
  g2 <- s1d.barchart(pca1$li[, 1], p1d.hori = FALSE)
} else {
  s.corcircle(pca1$co, clab = 0.75)
  barplot(pca1$li[, 1])
}

op <- par(no.readonly = TRUE) 
par(mfrow = c(5, 4))
par(mar = c(2, 2, 1, 1))
clem0 <- pca1$tab
croi <- 1:15
alter <- c(rep(c(1, -1), 7), 1)
for(i in 1:20) {
  y <- clem0[,i]
  plot(w0, y, type = "b", ylim = c(-2, 2))
  z <- predict(lm(clem0[, i] ~ croi * alter))
  points(w0, z, pch = 20, cex = 2)
  for(j in 1:15)
    segments(j, y[j], j, z[j])
}
par(op)
par(mfrow = c(1, 1))
}
\keyword{datasets}
