\name{table.dist}
\alias{table.dist}
\title{Graph Display for Distance Matrices}
\description{
presents a graph for viewing distance matrices. 
}
\usage{
table.dist(d, x = 1:(attr(d, "Size")), labels = as.character(x), 
    clabel = 1, csize = 1, grid = TRUE)
}
\arguments{
  \item{d}{an object of class \code{'dist'}}
  \item{x}{a vector of the row and column positions}
  \item{labels}{a vector of strings of characters for the labels}
  \item{clabel}{a character size for the labels}
  \item{csize}{a coefficient for the circle size}
  \item{grid}{a logical value indicating whether a grid in the background of the plot should be drawn}
}
\examples{
data(eurodist)
table.dist(eurodist, labels = attr(eurodist, "Labels"))
}
\keyword{hplot}
