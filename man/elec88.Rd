\name{elec88}
\alias{elec88}
\docType{data}
\title{Electoral Data}
\description{
This data set gives the results of the presidential election in France in 1988 for each department and all the candidates. 
}
\usage{data(elec88)}
\format{
\code{elec88} is a list of 7 components. 
\describe{
    \item{tab}{is a data frame with 94 rows (departments) and 9 variables (candidates)}
    \item{res}{is the global result of the election all-over the country.}
    \item{lab}{is a data frame with two variables: 
    \code{elec88$lab$dep} a vector containing the names of the 94 french departments and,
    \code{elec88$lab$reg} a factor with 21 levels defining the French administraitve regions.}
    \item{area}{is the data frame of 3 variables returning the boundary lines of each department. 
    The first variable is a factor. The levels of this one are the row.names of tab. 
    The second and third variables return the coordinates (x,y) of the points of the boundary line.}
    \item{contour}{is a data frame with 4 variables (x1,y1,x2,y2)for the contour display of France}
    \item{xy}{is a data frame with two variables (x,y) giving the position of the center for each department}
    \item{neig}{is the neighbouring graph between departments, object of the class \code{neig}}
    }
}
\source{
 Public data
}
\seealso{
This dataset is compatible with \code{presid2002} and \code{cnc2003}}
\examples{
data(elec88)
apply(elec88$tab, 2, mean)
summary(elec88$res)

par(mfrow = c(2,2))
plot(elec88$area[,2:3], type = "n", asp = 1)
lpoly <- split(elec88$area[,2:3], elec88$area[,1])
lapply(lpoly, function(x) {points (x,type = "l");invisible()})
polygon(elec88$area[elec88$area$V1=="D25", 2:3], col = 1)
area.plot(elec88$area, graph = elec88$neig, lwdg = 1)
polygon(elec88$area[elec88$area$V1=="D25", 2:3], col = 1)
pca1 <- dudi.pca(elec88$tab, scal = FALSE, scan = FALSE)
area.plot(elec88$area, val = elec88$xy[,1] + elec88$xy[,2])
area.plot(elec88$area, val = pca1$li[,1], sub = "F1 PCA", 
    csub = 2, cleg = 1.5)
par(mfrow = c(1,1))}
\keyword{datasets}
