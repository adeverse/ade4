\name{disc}
\alias{disc}
\title{Rao's dissimilarity coefficient}
\description{
Calculates the root square of Rao's dissimilarity coefficient between samples.
}
\usage{
disc(samples, dis = NULL, structures = NULL)
}
\arguments{
  \item{samples}{a data frame with elements as rows, samples as columns,
  and abundance, presence-absence or frequencies as entries}
  \item{dis}{an object of class \code{dist} containing distances or dissimilarities among elements.
  If \code{dis} is null, equidistances are used.}
  \item{structures}{a data frame containing, in the jth row and the kth column,
  the name of the group of level k to which the jth population belongs}
}
\value{
Returns a list of objects of class \code{dist}
}
\references{
Rao, C.R. (1982) Diversity and dissimilarity coefficients: a unified approach.
\emph{Theoretical Population Biology}, \bold{21}, 24--43.
}
\author{Sandrine Pavoine \email{pavoine@biomserv.univ-lyon1.fr}
}
\examples{
data(ecomor)
ecomor.phylog <- taxo2phylog(ecomor$taxo)
ecomor.dist <- disc(ecomor$habitat, ecomor.phylog$Wdist)
ecomor.dist
is.euclid(ecomor.dist)

data(humDNAm)
humDNA.dist <- disc(humDNAm$samples, sqrt(humDNAm$distances), humDNAm$structures)
humDNA.dist
is.euclid(humDNA.dist$samples)
is.euclid(humDNA.dist$regions)
}
\keyword{multivariate}
