\name{jv73}
\alias{jv73}
\docType{data}

\title{K-tables Multi-Regions}

\description{
  This data set gives physical and physico-chemical variables, fish species, 
  spatial coordinates about 92 sites. 
}

\usage{data(jv73)}

\format{\code{jv73} is a list with the following components:
  \describe{
    \item{morpho}{a data frame with 92 sites and 6 physical variables}
    \item{phychi}{a data frame with 92 sites and 12 physico-chemical variables}
    \item{poi}{a data frame with 92 sites and 19 fish species}
    \item{xy}{a data frame with 92 sites and 2 spatial coordinates}
    \item{contour}{a data frame for mapping}
    \item{fac.riv}{a factor distributing the 92 sites on 12 rivers}
    \item{Spatial}{an object of the class \code{SpatialLines} of \code{sp},
      containing the map}
}}

\source{
  Verneaux, J. (1973) Cours d'eau de Franche-Comté (Massif du Jura).
  Recherches écologiques sur le réseau hydrographique du Doubs.
  Essai de biotypologie. Thèse d'Etat, Besançon.
}

\references{
  See a data description at \url{http://pbil.univ-lyon1.fr/R/pdf/pps047.pdf} (in French).
}

\examples{
data(jv73)

w <- split(jv73$morpho, jv73$fac.riv)
w <- lapply(w, function(x) t(dudi.pca(x, scann = FALSE)))
w <- ktab.list.dudi(w)

if(adegraphicsLoaded()) {
  if(requireNamespace("sp", quietly = TRUE)) {
    g11 <- s.label(jv73$xy, Sp = jv73$Spatial, pori.incl = FALSE, plab.cex = 0.75, plot = FALSE)
    g12 <- s.class(jv73$xy, jv73$fac.riv, ellipseSize = 0, pellipses.axes.draw = FALSE, 
      starSize = 0, ppoints.cex = 0, plab.cex = 1.25, plot = FALSE)
    g1 <- superpose(g11, g12, plot = TRUE)
  
    g2 <- kplot(sepan(w), perm = TRUE, row.plab.cex = 0, posieig = "none")
  }
  
} else {
  s.label(jv73$xy, contour = jv73$contour, incl = FALSE, clab = 0.75)
  s.class(jv73$xy, jv73$fac.riv, add.p = TRUE, cell = 0, axese = FALSE, csta = 0, 
    cpoi = 0, clab = 1.25)
  
  kplot(sepan(w), perm = TRUE, clab.r = 0, clab.c = 2, show = FALSE)
}}

\keyword{datasets}
