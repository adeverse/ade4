\name{vegtf}
\alias{vegtf}
\docType{data}
\title{Vegetation in Trois-Fontaines}
\description{
 This data set contains abundance values (Braun-Blanquet scale) of 80 plant
 species for 337 sites. Data have been collected by Sonia Said and
 Francois Debias.
}
\usage{data(vegtf)}
\format{
\code{vegtf} is a list containing the following objects :
\describe{
   \item{veg}{is a data.frame with the abundance values of 80 species (columns)
     in 337 sites (rows).}
   \item{xy}{is a data.frame with the spatial coordinates of the sites.} 
   \item{area}{is data.frame (area) which define the boundaries of the study
     site.}
   \item{nb}{is a neighborhood object (class nb defined in package spdep)} 
}}
\source{
  Dray, S., Said, S. and Debias, F. (2007) Spatial ordination of vegetation data using a generalization of Wartenberg's  multivariate spatial correlation. \emph{Journal of vegetation science}. in press.
}

\examples{
if (require(spdep, quiet=TRUE)){
data(vegtf)
coa1 <- dudi.coa(vegtf$veg,scannf=FALSE)
ms.coa1 <- multispati(coa1,listw=nb2listw(vegtf$nb),nfposi=2,nfnega=0,scannf=FALSE)
summary(ms.coa1)
plot(ms.coa1)
par(mfrow=c(2,2))
s.value(vegtf$xy,coa1$li[,1],area=vegtf$area,include.origin=FALSE)
s.value(vegtf$xy,ms.coa1$li[,1],area=vegtf$area,include.origin=FALSE)
s.label(coa1$c1)
s.label(ms.coa1$c1)
}
}
\keyword{datasets}
