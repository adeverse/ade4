\name{oribatid}
\alias{oribatid}
\docType{data}
\title{Oribatid mite}
\description{
This data set contains informations about environmental control and spatial structure in ecological communities of Oribatid mites.
}
\usage{data(oribatid)}
\format{
\code{oribatid} is a list containing the following elements : 
        \item{fau}{: a data frame with 70 rows (sites) and 35 columns (Oribatid species)}   
        \item{envir}{: a data frame with 70 rows (sites) and 5 columns (environmental variables)}
        \item{xy}{: a data frame that contains spatial coordinates of the 70 sites}

Variables of \code{oribatid$envir} are the following ones : \cr
       \item{substrate}{: a factor with seven levels that describes the nature of the substratum}
       \item{shrubs}{: a factor with three levels that describes the absence/presence of shrubs}
       \item{topo}{: a factor with two levels that describes the microtopography}
       \item{density}{: substratum density (\eqn{g.L^{-1}}{g.L^-1})}
       \item{water}{: water content of the substratum (\eqn{g.L^{-1}}{g.L^-1})}
}
\source{
Data prepared by P. Legendre \email{Pierre.Legendre@umontreal.ca} and D. Borcard \email{borcardd@magellan.umontreal.ca} starting from \url{http://www.fas.umontreal.ca/biol/casgrain/fr/labo/oribates.html}
}
\references{
Borcard, D., and Legendre, P. (1994) Environmental control and spatial structure in ecological communities: an example using Oribatid mites (\emph{Acari Oribatei}). \emph{Environmental and Ecological Statistics}, \bold{1}, 37--61.

Borcard, D., Legendre, P., and Drapeau, P. (1992) Partialling out the spatial component of ecological variation. \emph{Ecology}, \bold{73}, 1045--1055.
}
\examples{
data(oribatid)
ori.xy <- oribatid$xy[,c(2,1)]
names(ori.xy) <- c("x","y")
plot(ori.xy,pch = 20, cex = 2, asp = 1)

if (require(tripack, quiet = TRUE)){
plot(voronoi.mosaic(ori.xy), add = TRUE)
s.label(ori.xy, add.p = TRUE,
     neig = nb2neig(knn2nb(knearneigh(as.matrix(ori.xy), 3))),
     clab = 0)
}
}
\keyword{datasets}
