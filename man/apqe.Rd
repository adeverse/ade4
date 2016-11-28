\name{apqe}
\alias{apqe}
\alias{print.apqe}
\title{Apportionment of Quadratic Entropy}
\description{
The hierarchical apportionment of quadratic entropy defined by Rao (1982).
}
\usage{
apqe(samples, dis = NULL, structures)
\method{print}{apqe}(x, full = FALSE, \dots)
}
\arguments{
  \item{samples}{a data frame with haplotypes (or genotypes) as rows, populations as columns
  and abundance or presence-absence as entries}
  \item{dis}{an object of class \code{dist} computed from Euclidean distance.
  If \code{dis} is null, equidistances are used.}
  \item{structures}{a data frame that contains, in the jth row and the kth column,
  the name of the group of level k to which the jth population belongs}
  \item{x}{an object of class \code{apqe}}
  \item{full}{a logical value that indicates whether the original data ('distances', 'samples', 'structures')
  should be printed}
  \item{\dots}{\code{\dots} further arguments passed to or from other methods}
}
\value{
Returns a list of class \code{apqe}
  \item{call}{call}
  \item{results}{a data frame that contains the components of diversity.}
}
\references{
  Rao, C.R. (1982) Diversity: its measurement, decomposition, apportionment and analysis. 
  \emph{Sankhya: The Indian Journal of Statistics}, \bold{A44}, 1--22.

  Pavoine S. and Dolédec S. (2005) The apportionment of quadratic entropy: 
  a useful alternative for partitioning diversity in ecological data. 
  \emph{Environmental and Ecological Statistics}, \bold{12}, 125--138.
}
\author{Sandrine Pavoine \email{pavoine@mnhn.fr}
}
%\seealso{\code{\link{randtest.apqe}}}
\examples{
data(ecomor)
ecomor.phylog <- taxo2phylog(ecomor$taxo)
apqe(ecomor$habitat, ecomor.phylog$Wdist)
}
\keyword{multivariate}

