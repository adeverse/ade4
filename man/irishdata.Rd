\name{irishdata}
\alias{irishdata}
\non_function{}
\title{Geary's Irish Data}
\description{
This data set contains geographic informations about 25 counties of Ireland. 
}
\usage{data(irishdata)}
\format{
    \code{irishdata} is a list of 5 components.
    \enumerate{
    \item{area}{is a data frame with polygons for each of the 25 contiguous counties.}
    \item{county.names}{is a vector with the names of the 25 counties.}
    \item{xy}{is a data frame with the coordinates centers of the 25 counties.}
    \item{tab}{is a data frame with 25 rows (counties) and 12 variables.}
    \item{contour}{is a data frame with the global polygon of all the 25 counties.}
    }
}
\source{
Geary, R.C. (1954) The contiguity ratio and statistical mapping.\cr
\emph{The incorporated Statistician}, \bold{5}, 3, 115--145.\cr\cr
Cliff, A.D. and Ord, J.K. (1973) \emph{Spatial autocorrelation}, Pion, London. 1--178.
}
\examples{
data(irishdata)
par(mfrow = c(2,2))
area.plot(irishdata$area, lab = irishdata$county.names, clab = 0.75)
area.plot(irishdata$area)
apply(irishdata$contour, 1, function(x) segments(x[1],x[2],x[3],x[4], 
    lwd = 3))
s.corcircle(dudi.pca(irishdata$tab, scan = FALSE)$co)
score <- dudi.pca(irishdata$tab, scan = FALSE, nf = 1)$li$Axis1
names(score) <- row.names(irishdata$tab)
area.plot(irishdata$area, score)
par(mfrow = c(1,1))
}
\keyword{datasets}
