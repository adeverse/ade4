\name{tintoodiel}
\alias{tintoodiel}
\docType{data}
\title{Tinto and Odiel estuary geochemistry}
\description{
This data set contains informations about geochemical characteristics of heavy metal pollution in surface sediments of the Tinto and Odiel river estuary (south-western Spain).  
}
\usage{data(tintoodiel)}
\format{
\code{tintoodiel} is a list containing the following elements : 
        \item{xy}{: a data frame that contains spatial coordinates of the 52 sites}   
        \item{tab}{: a data frame with 12 columns (concentration of heavy metals) and 52 rows (sites)}
        \item{neig}{: an object of class \code{'neig'}}
}
\source{
Borrego, J., Morales, J.A., de la Torre, M.L. and Grande, J.A. (2002) Geochemical characteristics of heavy metal pollution in surface sediments of the Tinto and Odiel river estuary (south-western Spain). \emph{Environmental Geology}, \bold{41}, 785--796.
}
\examples{
data(tintoodiel)

if (require(pixmap, quiet = TRUE)){
estuary.pnm <- read.pnm(system.file("pictures/tintoodiel.pnm",
    package = "ade4"))
s.label(tintoodiel$xy,pixmap = estuary.pnm, neig = tintoodiel$neig,
    clab = 0, cpoi = 2, cneig = 3, addax = FALSE, cgrid = 0, grid = FALSE)
}

estuary.pca <- dudi.pca(tintoodiel$tab, scan = FALSE, nf = 4)
if (require(maptools, quiet = TRUE) & require(spdep, quiet = TRUE)) {
estuary.listw <- nb2listw(neig2nb(tintoodiel$neig))
estuary.pca.ms <- multispati(estuary.pca, estuary.listw, scan = FALSE,
    nfposi = 3,nfnega = 2)
summary(estuary.pca.ms)
par(mfrow = c(1,2))
barplot(estuary.pca$eig)
barplot(estuary.pca.ms$eig)
par(mfrow = c(1,1))
}
}
\keyword{datasets}
