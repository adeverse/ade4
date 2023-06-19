\name{tintoodiel}
\alias{tintoodiel}
\docType{data}

\title{Tinto and Odiel estuary geochemistry}

\description{
  This data set contains informations about geochemical characteristics of heavy 
  metal pollution in surface sediments of the Tinto and Odiel river estuary 
  (south-western Spain).  
}

\usage{data(tintoodiel)}

\format{\code{tintoodiel} is a list with the following components:
  \describe{
    \item{xy}{a data frame that contains spatial coordinates of the 52 sites}   
    \item{tab}{a data frame with 12 columns (concentration of heavy metals) and 52 rows (sites)}
    \item{nb}{the neighbourhood graph of the 52 sites (an object of class \code{nb})}
}}

\source{
  Borrego, J., Morales, J.A., de la Torre, M.L. and Grande, J.A. (2002) 
  Geochemical characteristics of heavy metal pollution in surface sediments of 
  the Tinto and Odiel river estuary (south-western Spain). \emph{Environmental 
  Geology}, \bold{41}, 785--796.
}

\examples{
data(tintoodiel)
  estuary.pca <- dudi.pca(tintoodiel$tab, scan = FALSE, nf = 4)
  
  if(requireNamespace("spdep", quietly = TRUE) & requireNamespace("adespatial", quietly = TRUE)) {
    estuary.listw <- spdep::nb2listw(tintoodiel$nb)
    estuary.pca.ms <- adespatial::multispati(estuary.pca, estuary.listw, scan = FALSE, 
        nfposi = 3, nfnega = 2)
    summary(estuary.pca.ms)
    par(mfrow = c(1, 2))
    barplot(estuary.pca$eig)
    barplot(estuary.pca.ms$eig)
    par(mfrow = c(1, 1))
}}

\keyword{datasets}
