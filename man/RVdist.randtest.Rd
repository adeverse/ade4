\name{RVdist.randtest}
\alias{RVdist.randtest}
\title{Tests of randomization on the correlation between two distance matrices (in R).}
\description{
performs a RV Test between two distance matrices. 
}
\usage{
RVdist.randtest(m1, m2, nrepet = 999, ...)
}
\arguments{
  \item{m1, m2}{two Euclidean matrices}
  \item{nrepet}{the number of permutations}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns a list of class 'randtest'
}
\references{
Heo, M. & Gabriel, K.R. (1997) A permutation test of association between configurations by means of the RV coefficient. 
Communications in Statistics - Simulation and Computation, \bold{27}, 843-856.
}
\author{Daniel Chessel }
\keyword{multivariate}
\keyword{nonparametric}
