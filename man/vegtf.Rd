\name{vegtf}
\alias{vegtf}
\docType{data}

\title{Vegetation in Trois-Fontaines}

\description{
  This data set contains abundance values (Braun-Blanquet scale) of 80 plant
  species for 337 sites. Data have been collected by Sonia Said and Francois Debias.
}

\usage{data(vegtf)}

\format{\code{vegtf} is a list with the following components:
  \describe{
    \item{veg}{a data.frame with the abundance values of 80 species (columns)
      in 337 sites (rows)}
    \item{xy}{a data.frame with the spatial coordinates of the sites}
    \item{area}{a data.frame (area) which define the boundaries of the study site}
    \item{sp.names}{a vector containing the species latin names}
    \item{nb}{a neighborhood object (class \code{nb} defined in package \code{spdep})}
    \item{Spatial}{an object of the class \code{SpatialPolygons} of \code{sp},
      containing the map}
}}

\source{
  Dray, S., Said, S. and Debias, F. (2008) Spatial ordination of vegetation 
  data using a generalization of Wartenberg's multivariate spatial correlation. 
  \emph{Journal of vegetation science}, \bold{19}, 45--56.
}

\examples{
if(requireNamespace("spdep", quietly = TRUE)) {
  data(vegtf)
  coa1 <- dudi.coa(vegtf$veg, scannf = FALSE)
  ms.coa1 <- multispati(coa1, listw = spdep::nb2listw(vegtf$nb), nfposi = 2, 
    nfnega = 0, scannf = FALSE)
  summary(ms.coa1)
  plot(ms.coa1)
  
  if(adegraphicsLoaded()) {
    g1 <- s.value(vegtf$xy, coa1$li[, 1], Sp = vegtf$Spatial, pSp.col = "white", plot = FALSE)
    g2 <- s.value(vegtf$xy, ms.coa1$li[, 1], Sp = vegtf$Spatial, pSp.col = "white", plot = FALSE)
    g3 <- s.label(coa1$c1, plot = FALSE)
    g4 <- s.label(ms.coa1$c1, plot = FALSE)
    G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  } else {
    par(mfrow = c(2, 2))
    s.value(vegtf$xy, coa1$li[, 1], area = vegtf$area, include.origin = FALSE)
    s.value(vegtf$xy, ms.coa1$li[, 1], area = vegtf$area, include.origin = FALSE)
    s.label(coa1$c1)
    s.label(ms.coa1$c1)
  }
}}

\keyword{datasets}
