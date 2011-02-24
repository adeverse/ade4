\encoding{latin1}
\name{lingoes}
\alias{lingoes}
\title{Transformation of a Distance Matrix for becoming Euclidean}
\description{
transforms a distance matrix in a Euclidean one. 
}
\usage{
lingoes(distmat, print = FALSE, tol = 1e-07, cor.zero = TRUE)
}
\arguments{
  \item{distmat}{an object of class \code{dist}}
  \item{print}{if TRUE, prints the eigenvalues of the matrix}
  \item{tol}{a tolerance threshold for zero}
  \item{cor.zero}{if TRUE, zero distances are not modified}
}
\value{
returns an object of class \code{dist} with a Euclidean distance
}
\references{Lingoes, J.C. (1971) Some boundary conditions for a monotone analysis of symmetric matrices. 
\emph{Psychometrika}, \bold{36}, 195--203. 
}
\details{
 The function uses the smaller positive constant k which transforms the matrix of \eqn{\sqrt{d_{ij}^2 + 2 \ast k}}{sqrt(dij² + 2*k)} in an Euclidean one
}
\author{
Daniel Chessel  \cr
Stéphane Dray \email{dray@biomserv.univ-lyon1.fr}
}
\examples{
data(capitales)
d0 <- as.dist(capitales$df)
is.euclid(d0) # FALSE
d1 <- lingoes(d0, TRUE)
# Lingoes constant = 2120982
is.euclid(d1) # TRUE
plot(d0, d1)
x0 <- sort(unclass(d0))
lines(x0, sqrt(x0^2 + 2 * 2120982), lwd = 3)
 
is.euclid(sqrt(d0^2 + 2 * 2120981), tol = 1e-10) # FALSE
is.euclid(sqrt(d0^2 + 2 * 2120982), tol = 1e-10) # FALSE
is.euclid(sqrt(d0^2 + 2 * 2120983), tol = 1e-10) 
    # TRUE the smaller constant
}
\keyword{array}
\keyword{multivariate}
