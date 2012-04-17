\name{piosphere}
\alias{piosphere}
\docType{data}
\title{
Plant traits response to grazing
}
\description{
Plant species cover, traits and environmental parameters recorded around
livestock watering points in different habitats of central Namibian
farmlands. See the Wesuls et al. (2012) paper for a full description of
the data set.
}
\usage{data(piosphere)}
\format{
  \code{piosphere} is a list of 4 components.
  \describe{
    \item{veg}{is a data frame containing plant species cover}
    \item{traits}{is a data frame with plant traits}
    \item{env}{is a data frame with environmental variables}
    \item{habitat}{is a factor describing habitat/years for each site}
  }
}
\source{
Wesuls, D., Oldeland, J. and Dray, S. (2012) Disentangling plant trait
responses to livestock grazing from spatio-temporal variation: the
partial RLQ approach. \emph{Journal of Vegetation Science}, \bold{23}, 98--113. 
}

\examples{
data(piosphere)
names(piosphere)
afcL <- dudi.coa(log(piosphere$veg + 1), scannf = FALSE)
acpR <- dudi.pca(piosphere$env, scannf = FALSE, row.w = afcL$lw)
acpQ <- dudi.hillsmith(piosphere$traits, scannf = FALSE, row.w = afcL$cw)
rlq1 <- rlq(acpR, afcL, acpQ, scannf = FALSE)
plot(rlq1)
}
\keyword{datasets}
