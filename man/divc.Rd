\name{divc}
\alias{divc}
\title{Rao's diversity coefficient also called quadratic entropy}
\description{
Calculates Rao's diversity coefficient within samples.
}
\usage{
divc(df, dis)
}
\arguments{
  \item{df}{a data frame with elements as rows, samples as columns,
  and abundance, presence-absence or frequencies as entries}
  \item{dis}{an object of class \code{dist} containing distances or dissimilarities among elements.
  If \code{dis} is null, Gini-Simpson index is performed.}
}
\value{
Returns a data frame with samples as rows and the diversity coefficient within samples as column
}
\references{
Rao, C.R. (1982) Diversity and dissimilarity coefficients: a unified approach.
\emph{Theoretical Population Biology}, \bold{21}, 24--43.

Gini, C. (1912) Variabilitá e mutabilitá. \emph{Universite di Cagliari III}, Parte II.

Simpson, E.H. (1949) Measurement of diversity. \emph{Nature}, \bold{163}, 688.

}
\author{Sandrine Pavoine \email{pavoine@biomserv.univ-lyon1.fr}
}
\examples{
data(ecomor)
ecomor.phylog <- taxo2phylog(ecomor$taxo)
divc(ecomor$habitat, ecomor.phylog$Wdist)

data(humDNAm)
divc(humDNAm$samples, sqrt(humDNAm$distances))
}
\keyword{multivariate}
