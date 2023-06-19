\name{kcponds}
\alias{kcponds}
\docType{data}

\title{Ponds in a nature reserve}

\description{
  This data set contains informations about 33 ponds in De Maten reserve 
  (Genk, Belgium).
}

\usage{data(kcponds)}

\format{\code{kponds} is a list with the following components:
  \describe{
    \item{tab}{a data frame with 15 environmental variables (columns) on 33 ponds (rows)}
    \item{area}{an object of class \code{area}}
    \item{xy}{a data frame with the coordinates of ponds}
    \item{nb}{the neighbourhood graph of the 33 sites (an object of class \code{nb})}
    \item{Spatial}{an object of the class \code{SpatialPolygons} of \code{sp}, containing the map}
}}

\details{ 
Variables of \code{kcponds$tab} are the following ones : depth, area, O2 (oxygen concentration), 
cond (conductivity), pH, Fe (Fe concentration), secchi (Secchi disk depth), N (NNO concentration),
TP (total phosphorus concentration), chla (chlorophyll-a concentration), EM (emergent macrophyte cover),
FM (floating macrophyte cover), SM (submerged macrophyte cover), denMI (total density of macroinvertebrates),
divMI (diversity macroinvertebrates)
}

\source{
  Cottenie, K. (2002) Local and regional processes in a zooplankton metacommunity. 
  PhD, Katholieke Universiteit Leuven, Leuven, Belgium. \cr
  \url{https://bio.kuleuven.be/eco/phdkarlcottenie.pdf}
}

\examples{
data(kcponds)
w <- as.numeric(scalewt(kcponds$tab$N))

if(adegraphicsLoaded()) {
  if(requireNamespace("sp", quietly = TRUE)) {
    g1 <- s.label(kcponds$xy, Sp = kcponds$Spatial, pSp.col = "white", nb = kcponds$nb, 
      plab.cex = 0, paxes.asp = "fill", plot = FALSE)
    g2 <- s.label(kcponds$xy, Sp = kcponds$Spatial, pSp.col = "white", plabels.cex = 0.8, 
      paxes.asp = "fill", plot = FALSE)
    g3 <- s.value(kcponds$xy, w, psub.text = "Nitrogen concentration", paxe.asp = "fill", 
      plot = FALSE)
    G <- rbindADEg(g1, g2, g3, plot = TRUE)
  }

} else {
  par(mfrow = c(3, 1))
  area.plot(kcponds$area)
  s.label(kcponds$xy, add.p = TRUE, cpoi = 2, clab = 0)
  s.label(kcponds$xy, add.p = TRUE, cpoi = 3, clab = 0)
  area.plot(kcponds$area)
  s.label(kcponds$xy, add.p = TRUE, clab = 1.5)
  s.value(kcponds$xy, w, cleg = 2, sub = "Nitrogen concentration", csub = 4, 
    possub = "topright", include = FALSE)
  par(mfrow = c(1, 1))
}

\dontrun{
  par(mfrow = c(3, 1))
  pca1 <- dudi.pca(kcponds$tab, scan = FALSE, nf = 4)
  if(requireNamespace("spdep", quietly = TRUE) &
    requireNamespace("adespatial", quietly = TRUE)) {
    multi1 <- adespatial::multispati(pca1, spdep::nb2listw(kcponds$nb),
        scannf = FALSE, nfposi = 2, nfnega = 1)
    summary(multi1)
  }
  par(mfrow = c(1, 1))
}}

\keyword{datasets}
