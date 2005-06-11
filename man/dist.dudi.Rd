\name{dist.dudi}
\alias{dist.dudi}
\title{Computation of the Distance Matrix from a Statistical Triplet
}
\description{
computes for a statistical triplet a distance matrix. 
}
\usage{
dist.dudi(dudi, amongrow = TRUE)
}
\arguments{
  \item{dudi}{a duality diagram, object of class \code{dudi}}
  \item{amongrow}{a logical value computing the distance if TRUE, between rows, if FALSE between columns.}
}
\value{
an object of class \code{dist}
}
\author{
Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} \cr
Stéphane Dray \email{dray@biomserv.univ-lyon1.fr}
}
\examples{
data (meaudret)
pca1 <- dudi.pca(meaudret$mil, scan = FALSE)
sum((dist(scalewt(meaudret$mil)) - dist.dudi(pca1))^2)
#[1] 4.045e-29 the same thing
}
\keyword{array}
\keyword{multivariate}
