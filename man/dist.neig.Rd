\name{dist.neig}
\alias{dist.neig}
\title{Computation of the Distance Matrix associated to a Neighbouring Graph
}
\description{
  This distance matrix  between two points is the length of the shortest path between
these points. 
}
\usage{
dist.neig(neig)
}
\arguments{
  \item{neig}{a neighbouring graph, object of class 'neig'}
}
\value{
returns a distance matrix, object of class 'dist'
}
\examples{
library(mva)
    data(elec88)
    d0 <- dist.neig(elec88$neig)
    plot(dist(elec88$xy),d0)
}
\keyword{array}
\keyword{multivariate}
