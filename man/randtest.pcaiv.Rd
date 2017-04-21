\name{randtest.pcaiv}
\alias{randtest.pcaiv}
\alias{randtest.pcaivortho}
\title{Monte-Carlo Test on the percentage of explained (i.e.
  constrained) inertia}
\description{
Performs a Monte-Carlo test on on the percentage of explained (i.e.
  constrained) inertia. The statistic is the ratio of the inertia (sum
  of eigenvalues) of the
  constrained analysis divided by the inertia of the unconstrained analysis.
}
\usage{
\method{randtest}{pcaiv}(xtest, nrepet = 99, ...)
\method{randtest}{pcaivortho}(xtest, nrepet = 99, ...)
}

\arguments{
  \item{xtest}{an object of class \code{pcaiv}, \code{pcaivortho} or \code{caiv}}
  \item{nrepet}{the number of permutations}
  \item{\dots}{further arguments passed to or from other methods}
}

\value{
  a list of the class \code{randtest}
}
\author{Stéphane Dray \email{stephane.dray@univ-lyon1.fr}, original code
  by Raphaël Pélissier}
\examples{
data(rpjdl)
millog <- log(rpjdl$mil + 1)
coa1 <- dudi.coa(rpjdl$fau, scann = FALSE)
caiv1 <- pcaiv(coa1, millog, scan = FALSE)
randtest(caiv1)
}

\keyword{multivariate}
\keyword{nonparametric}
