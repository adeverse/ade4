\name{randtest.apdiv}
\alias{randtest.apdiv}
\title{
Permutation tests on Rao's apportionment of diversity(in C).}
\description{
Tests the components of diversity with permutation processes. The statistics are those used in
a hierarchical ANOVA.
}
\usage{
randtest.apdiv(xtest, nrepet = 99, \dots)
}
\arguments{
  \item{xtest}{an object of class \code{apdiv}
  The matrix 'samples' in \code{xtest} should contain abundances or presences/absences, frequencies are not suitable.}
  \item{nrepet}{the number of permutations}
  \item{\dots}{\code{\dots} further arguments passed to or from other methods}
}
\value{
returns an object of class \code{krandtest} or \code{randtest}
}
\author{Sandrine Pavoine \email{pavoine@biomserv.univ-lyon1.fr}
}
\examples{
\dontrun{
data(ecomor)
ecomor.phylog <- taxo2phylog(ecomor$taxo)
ecomor.apdiv <- apdiv(ecomor$habitat, ecomor.phylog$Wdist)
ecomor.test <- randtest.apdiv(ecomor.apdiv)
plot(ecomor.test)
}}
\keyword{multivariate}
\keyword{nonparametric}
