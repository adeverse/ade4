\name{multispati.rtest}
\alias{multispati.rtest}
\title{Multivariate spatial autocorrelation test}
\description{
This function performs a multivariate autocorrelation test.
}
\usage{
multispati.rtest(dudi, listw, nrepet = 99)
}
\arguments{
  \item{dudi}{an object of class \code{dudi} for the duality diagram analysis}
  \item{listw}{an object of class \code{listw} for the spatial dependence of data observations}
  \item{nrepet}{the number of permutations}
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
\emph{Heredity},\ bold{82}, 561--573.
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
    maf.coa <- dudi.coa(maf.flo, scannf = FALSE)
    multispati.rtest(maf.coa, maf.listw)
}
}
\keyword{multivariate}
\keyword{spatial}
\keyword{nonparametric}
