\name{buech}
\alias{buech}
\docType{data}
\title{Buech basin}
\description{
This data set contains informations about Buech basin characteristics.
}
\usage{data(buech)}
\format{
\code{buech} is a list with the following components : 
\describe{
   \item{tab1}{: a data frame with 10 environmental variables collected on 31 sites in Juin (1984)}
   \item{tab2}{: a data frame with 10 environmental variables collected on 31 sites in September (1984)}
   \item{xy}{: a data frame with the coordinates of the sites}
   \item{neig}{: an object of class \code{neig}}
   \item{contour}{: a data frame for background map}}
}
\details{
Variables of \code{buech$tab1} and \code{buech$tab2} are the following ones :\cr 
pH ; Conductivity (\eqn{\mu} S/cm) ; Carbonate (water hardness (mg/l CaCO3)) ;
hardness (total water hardness (mg/l CaCO3)) ; Bicarbonate (alcalinity (mg/l HCO3-)) ;
Chloride (alcalinity (mg/l Cl-)) ; Suspens (particles in suspension (mg/l)) ;
Organic (organic particles (mg/l)) ; Nitrate (nitrate rate (mg/l NO3-)) ;
Ammonia (amoniac rate (mg/l NH4-))
}
\source{
Vespini, F. (1985) \emph{Contribution à l'étude hydrobiologique du Buech, rivière non aménagée de Haute-Provence}. Thèse de troisième cycle, Université de Provence.

Vespini, F., Légier, P. and Champeau, A. (1987) Ecologie d'une rivière non aménagée des Alpes du Sud : Le Buëch (France) I. Evolution longitudinale des descripteurs physiques et chimiques. \emph{Annales de Limnologie}, \bold{23}, 151--164.
}
\examples{
data(buech)
if(adegraphicsLoaded()) {
  if(requireNamespace("sp", quietly = TRUE)) {
    g1 <- s.label(buech$xy, Sp = buech$Spatial, nb = buech$nb, 
      pSp.col = "transparent", plot = FALSE)
    g2 <- s.value(buech$xy, buech$tab2$Suspens - buech$tab1$Suspens, 
      Sp = buech$Spatial, nb = buech$nb, pSp.col = "transparent", plot = FALSE)
    G <- cbindADEg(g1, g2, plot = TRUE)
  }
} else {
  par(mfrow = c(1,2))
  s.label(buech$xy, contour = buech$contour, neig = buech$neig)
  s.value(buech$xy, buech$tab2$Suspens - buech$tab1$Suspens,
    contour = buech$contour, neig = buech$neig, csi = 3)
  par(mfrow = c(1,1))
}}
\keyword{datasets}
