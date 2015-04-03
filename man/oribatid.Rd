\name{oribatid}
\alias{oribatid}
\docType{data}
\title{Oribatid mite}
\description{
This data set contains informations about environmental control and spatial structure in ecological communities of Oribatid mites.
}
\usage{data(oribatid)}
\format{
\code{oribatid} is a list containing the following objects : 
\describe{
        \item{fau}{: a data frame with 70 rows (sites) and 35 columns (Oribatid species)}   
        \item{envir}{: a data frame with 70 rows (sites) and 5 columns (environmental variables)}
        \item{xy}{: a data frame that contains spatial coordinates of the 70 sites}
}}
\details{
Variables of \code{oribatid$envir} are the following ones : \cr
substrate: a factor with seven levels that describes the nature of the substratum\cr
shrubs: a factor with three levels that describes the absence/presence of shrubs\cr
topo: a factor with two levels that describes the microtopography\cr
density: substratum density (\eqn{g.L^{-1}}{g.L^-1})\cr
water: water content of the substratum (\eqn{g.L^{-1}}{g.L^-1})
}
\source{
Data prepared by P. Legendre \email{Pierre.Legendre@umontreal.ca} and \cr
D. Borcard \email{borcardd@magellan.umontreal.ca} starting from \cr
\url{http://www.fas.umontreal.ca/biol/casgrain/fr/labo/oribates.html}\cr
}
\references{
Borcard, D., and Legendre, P. (1994) Environmental control and spatial structure in ecological communities: 
an example using Oribatid mites (\emph{Acari Oribatei}). \emph{Environmental and Ecological Statistics}, \bold{1}, 37--61.

Borcard, D., Legendre, P., and Drapeau, P. (1992) Partialling out the spatial component of ecological variation. 
\emph{Ecology}, \bold{73}, 1045--1055.

See a data description at \url{http://pbil.univ-lyon1.fr/R/pdf/pps039.pdf} (in French).
}
\examples{
data(oribatid)
ori.xy <- oribatid$xy[, c(2, 1)]
names(ori.xy) <- c("x","y")
plot(ori.xy,pch = 20, cex = 2, asp = 1)

if(requireNamespace("deldir", quiet = TRUE)) {
  if(requireNamespace("spdep", quiet = TRUE)) {
    plot(deldir(ori.xy), add = TRUE)
    if(adegraphicsLoaded()) {
      s.label(ori.xy, nb = knn2nb(knearneigh(as.matrix(ori.xy), 3)), plab.cex = 0)
    } else {
      s.label(ori.xy, add.p = TRUE, neig = nb2neig(knn2nb(knearneigh(as.matrix(ori.xy), 3))),
        clab = 0)
    }
  }
}
}
\keyword{datasets}
