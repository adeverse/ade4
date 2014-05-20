\name{randtest.amova}
\alias{randtest.amova}
\title{
Permutation tests on an analysis of molecular variance (in C).}
\description{
Tests the components of covariance with permutation processes described by Excoffier et al. (1992).
}
\usage{
\method{randtest}{amova}(xtest, nrepet = 99, \dots)
}
\arguments{
  \item{xtest}{an object of class \code{amova}}
  \item{nrepet}{the number of permutations}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns an object of class \code{krandtest} or \code{randtest}
}
\references{
  Excoffier, L., Smouse, P.E. and Quattro, J.M. (1992) Analysis of molecular variance inferred from
  metric distances among DNA haplotypes: application to human mitochondrial DNA restriction data.
  \emph{Genetics}, \bold{131}, 479--491.
}
\author{Sandrine Pavoine \email{pavoine@mnhn.fr}
}
\examples{
data(humDNAm)
amovahum <- amova(humDNAm$samples, sqrt(humDNAm$distances), humDNAm$structures)
amovahum
randtesthum <- randtest(amovahum, 49)
plot(randtesthum)
}
\keyword{multivariate}
\keyword{nonparametric}
