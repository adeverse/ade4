\name{multispati.randtest}
\alias{multispati.randtest}
\title{Multivariate spatial autocorrelation test (in C)}
\description{
This function performs a multivariate autocorrelation test.
}
\usage{
multispati.randtest(dudi, listw, nrepet = 999)
}
\arguments{
  \item{dudi}{: an object of class \code{'dudi'} for the duality diagram analysis}
  \item{listw}{: an object of class \code{'listw'} for the spatial dependence of data observations}
  \item{nrepet}{: an integer for the number of permutations}
}
\details{
A faire.
}
\value{
Returns an object of class \code{'randtest'} (randomization tests).
}
\references{
Smouse, P. E. and Peakall, R. (1999) Spatial autocorrelation analysis of individual multiallele and multilocus genetic structure. \emph{Heredity}, bold{82}, 561--573.
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} \cr
Sébastien Ollier \email{ollier@biomserv.univ-lyon1.fr}
}
\seealso{\code{\link{dudi}},\code{\link[spdep]{listw}}}
\examples{
if(require(spdep, quiet = TRUE)){
    data(mafragh)
    maf.xy <- mafragh$xy
    maf.flo <- mafragh$flo
    maf.listw <- nb2listw(neig2nb(mafragh$neig))
    s.label(maf.xy, neig = mafragh$neig, clab = 0.75)
    maf.coa <- dudi.coa(maf.flo,scannf = FALSE)
    multispati.randtest(maf.coa, maf.listw)
}
}
\keyword{multivariate}
\keyword{spatial}
\keyword{nonparametric}
