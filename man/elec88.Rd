\name{elec88}
\alias{elec88}
\non_function{}
\title{Electoral Data}
\description{
This data set gives the results of the presidential election in France in 1988 for each department and all the candidates. 
}
\usage{data(elec88)}
\format{
\code{elec88} is a list of 4 components. 
It is a data frame with 94 rows (departments) and 9 variables (candidates).
    \enumerate{
    \item{res}{is the global result of the election all-over the country.}
    \item{lab}{is the vector of the names of the 94 french departments.}
    \item{area}{is the dataframe of 3 variables returning the boundary lines of each department. 
    The first variable is a factor. The levels of this one are the row.names of tab. 
    The second and third variables return the coordinates (x,y) of the points of the boundary line.}
    }
}
\source{
 Public data
}
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
par(mfrow = c(1,1))
}
\keyword{datasets}
