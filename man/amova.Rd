\name{amova}
\alias{amova}
\alias{print.amova}
\title{Analysis of molecular variance}
\description{
The analysis of molecular variance tests the differences among population and/or groups of populations
in a way similar to ANOVA. It includes evolutionary distances among alleles.
}
\usage{
amova(samples, distances, structures)
print.amova(x, full = FALSE, \dots)
}
\arguments{
  \item{samples}{a data frame with haplotypes (or genotypes) as rows, populations as columns
  and abundance or presence-absence as entries}
  \item{distances}{an object of class \code{dist} computed from Euclidean distance.
  If \code{distances} is null, equidistances are used.}
  \item{structures}{a data frame containing, in the jth row and the kth column,
  the name of the group of level k to which the jth population belongs}
  \item{x}{an object of class \code{amova}}
  \item{full}{a logical value indicating whether the original data ('distances','samples','structures')
  should be printed}
  \item{\dots}{\code{\dots} further arguments passed to or from other methods}
}
\value{
Returns a list of class \code{amova}
  \item{call}{call}
  \item{results}{a data frame with the degrees of freedom, the sums of squares, and the mean squares.
  Rows represent levels of variability.}
  \item{componentsofcovariance}{a data frame containing the components
  of covariance and their contribution to the total covariance}
  \item{statphi}{a data frame containing the phi-statistics}
}
\references{
Excoffier, L., Smouse, P.E. and Quattro, J.M. (1992) Analysis of molecular variance inferred
from metric distances among DNA haplotypes: application to human mitochondrial DNA restriction
data. \emph{Genetics}, \bold{131}, 479--491.
}
\author{Sandrine Pavoine \email{pavoine@biomserv.univ-lyon1.fr}
}
\seealso{\code{\link{randtest.amova}}}
\examples{
data(humDNAm)
amovahum <- amova(humDNAm$samples, sqrt(humDNAm$distances), humDNAm$structures)
amovahum
}
\keyword{multivariate}
