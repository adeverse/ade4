\name{apdiv}
\alias{apdiv}
\alias{print.apdiv}
\title{Apportionment of diversity}
\description{
Decomposition of quadratic entropy. 
}
\usage{
apdiv(samples, dis = NULL, structures)
print.apdiv(x, full = FALSE, \dots)
}
\arguments{
  \item{samples}{a data frame with haplotypes (or genotypes) as rows, populations as columns
  and abundance or presence-absence as entries}
  \item{dis}{an object of class \code{dist} computed from Euclidean distance.
  If \code{dis} is null, equidistances are used.}
  \item{structures}{a data frame containing, in the jth row and the kth column,
  the name of the group of level k to which the jth population belongs}
  \item{x}{an object of class \code{apdiv}}
  \item{full}{a logical value indicating whether the original data ('distances', 'samples', 'structures')
  should be printed}
  \item{\dots}{\code{\dots} further arguments passed to or from other methods}
}
\value{
Returns a list of class \code{apdiv}
  \item{call}{call}
  \item{results}{a data frame containing the components of diversity.}
}
\references{
Rao, C.R. (1982) Diversity: its measurement, decomposition, apportionment and analysis. \emph{Sankhya: The Indian Journal of Statistics}, \bold{A44}, 1--22.
}
\author{
Sandrine Pavoine \email{pavoine@biomserv.univ-lyon1.fr}
}
\seealso{\code{\link{randtest.apdiv}}}
\examples{
data(ecomor)
ecomor.phylog <- taxo2phylog(ecomor$taxo)
apdiv(ecomor$habitat, ecomor.phylog$Wdist)
}
\keyword{multivariate}

