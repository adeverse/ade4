\name{scalewt}
\alias{scalewt}
\title{Centring and Scaling a Matrix of Any Weighting}
\description{
transforms a numeric matrix in a centred and scaled matrix for any weighting. 
}
\usage{
scalewt(X, wt = rep(1, nrow(X)), center = TRUE, scale = TRUE)
}
\arguments{
  \item{X}{a numeric matrix (like object)}
  \item{wt}{a vector of weighting}
  \item{center}{a logical value indicating whether the array should be centred}
  \item{scale}{a logical value indicating whether the array should be scaled}
}
\value{
returns a centred, scaled matrix
}
\note{The norms are calculated with 1/n and the columns of null variance are still equal to zero.
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\examples{
scalewt(matrix(1:12,4,3))
scale((matrix(1:12,4,3)))
scale(matrix(1,4,3))
scalewt(matrix(1,4,3))
}
\keyword{utilities}
