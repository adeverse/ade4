\name{multispati.rtest}
\alias{multispati.rtest}
\title{Multivariate spatial autocorrelation test}
\description{
This function performs a multivariate autocorrelation test.
}
\usage{
multispati.rtest(dudi, listw, nrepet = 99, ...)
}
\arguments{
  \item{dudi}{an object of class \code{dudi} for the duality diagram analysis}
  \item{listw}{an object of class \code{listw} for the spatial dependence of data observations}
  \item{nrepet}{the number of permutations}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
We note X the data frame with the variables, Q the column weight matrix 
and D the row weight matrix associated to the duality diagram \emph{dudi}.
We note L the neighbouring weights matrix associated to  \emph{listw}.
This function performs a Monte-Carlo Test on the multivariate spatial 
autocorrelation index : \deqn{r = \frac{X^{t}DLXQ}{X^{t}DXQ}}{r = t(X)DLXQ / t(X)DXQ}
}
\value{
Returns an object of class \code{randtest} (randomization tests).
}
\references{
Smouse, P. E. and Peakall, R. (1999) Spatial autocorrelation analysis of individual multiallele and multilocus genetic structure. 
\emph{Heredity}, \bold{82}, 561--573.
}
\author{Daniel Chessel  \cr
Sébastien Ollier \email{sebastien.ollier@u-psud.fr}
}
\seealso{\code{\link{dudi}},\code{\link[spdep]{mat2listw}}}
\examples{
if (requireNamespace("spdep", quietly = TRUE) & requireNamespace("adespatial", quietly = TRUE)) {
    data(mafragh)
    maf.listw <- spdep::nb2listw(mafragh$nb)
    maf.pca <- dudi.pca(mafragh$env, scannf = FALSE)
    multispati.rtest(maf.pca, maf.listw)
    maf.pca.ms <- adespatial::multispati(maf.pca, maf.listw, scannf = FALSE)
    plot(maf.pca.ms)
}
}
\keyword{multivariate}
\keyword{spatial}
\keyword{nonparametric}
