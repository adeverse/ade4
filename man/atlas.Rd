\name{atlas}
\alias{atlas}
\non_function{}
\title{Small Ecological Dataset}
\description{
\code{atlas} is a list containing three kinds of information about 23 regions : \cr
geographical coordinates, meteorology and bird presences. 
}
\usage{data(atlas)}
\format{
 This list contains the following objects:
  \describe{
    \item{area}{is a convex hull of 23 geographical regions. }
    \item{xy}{are the coordinates of the region centers and altitude (in meters). }
    \item{names.district}{is a vector of region names.}
    \item{meteo}{is a data frame with 7 variables (temperature and rainfall).}
    \item{birds}{is a data frame with 15 variables (species).}
    \item{alti}{is a data frame with 3 variables altitude in percentage [0,800], ]800,1500] and ]1500,5000].}
    }
}
\source{
Extract from \cr
Lebreton, Ph. (1977) Les oiseaux nicheurs rhonalpins. \emph{Atlas ornithologique Rhone-Alpes}.\cr
Centre Ornithologique Rhone-Alpes, Université Lyon 1, 69621 Villeurbanne.\cr
Direction de la Protection de la Nature, Minist"re de la Qualité de la Vie. 1--354.
}
\examples{
data(atlas)
op <- par(no.readonly = TRUE) 
par(mfrow = c(2,2))
area.plot(atlas$area, cpoin = 1.5)
area.plot(atlas$area, lab = atlas$names.district, clab = 1)
x <- atlas$meteo$mini.jan

names(x) <- row.names(atlas$meteo)
area.plot(atlas$area, val = x, ncl = 12, sub = "Temp Mini January", 
    csub = 2, cleg = 1)
s.corcircle((dudi.pca(atlas$meteo, scann = FALSE)$co), 
    clab = 1)

area.plot(atlas$area, val = dudi.pca(atlas$meteo,scann=FALSE)$li[,1], 
    ncl = 12, sub = "Principal Component Analysis analysis", csub = 1.5, 
    cleg = 1)
birds.coa <- dudi.coa(atlas$birds, sca = FALSE, nf = 1)
x <- birds.coa$li$Axis1
area.plot(atlas$area, val = x, ncl = 12, 
    sub = "Correspondence analysis", csub = 1.5, cleg = 1)

s.value(atlas$xy, x, contour = atlas$contour, csi = 2, 
    incl = FALSE, addax = FALSE)
triangle.plot(atlas$alti)
par(op)
}
\keyword{datasets}
