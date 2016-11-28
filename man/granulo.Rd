\name{granulo}
\alias{granulo}
\docType{data}
\title{Granulometric Curves}
\description{
This data set gives the repartition in diameter classes of deposit samples. 
}
\usage{data(granulo)}
\format{
    \code{granulo} is a list of 2 components.
    \describe{
        \item{tab}{contains the 49 deposit samples, 9 diameter classes, weight of grains by size class}
        \item{born}{contains the boundaries of the diameter classes}
    }
}
\source{
Gaschignard-Fossati, O. (1986) \emph{Répartition spatiale des macroinvertébrés benthiques d'un bras vif du Rhône.
Rôle des crues et dynamique saisonnière.}
Thèse de doctorat, Université Lyon 1.
}
\examples{
data(granulo)
w <- t(apply(granulo$tab, 1, function (x) x / sum(x)))
w <- data.frame(w)
wtr <- data.frame(t(w))
wmoy <- data.frame(matrix(apply(wtr, 1, mean), 1))
d1 <- dudi.pca(w, scal = FALSE, scan = FALSE)
wmoy <- suprow(d1, wmoy)$lisup

if(adegraphicsLoaded()) {
  s.arrow(d1$c1, plab.cex = 1.5)
  s.distri(d1$c1, wtr, starSize = 0.33, ellipseSize = 0, 
    add = TRUE, plab.cex = 0.75)
  s.label(wmoy, ppoints.cex = 5, plab.cex = 0, add = TRUE)
} else {
  
  s.arrow(d1$c1, clab = 1.5)
  s.distri(d1$c1, wtr, cstar = 0.33, cell = 0, 
    axesell = FALSE, add.p = TRUE, clab = 0.75)
  s.label(wmoy, cpoi = 5, clab = 0, add.p = TRUE)
}}
\keyword{datasets}
