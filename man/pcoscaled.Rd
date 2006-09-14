\name{pcoscaled}
\alias{pcoscaled}
\title{Simplified Analysis in Principal Coordinates}
\description{
performs a simplified analysis in principal coordinates, 
using an object of class \code{dist}. 
}
\usage{
pcoscaled(distmat, tol = 1e-07)
}
\arguments{
  \item{distmat}{an object of class \code{dist}}
  \item{tol}{a tolerance threshold, an eigenvalue is considered as positive if it is larger than \code{-tol*lambda1} where \code{lambda1} is the largest eigenvalue}
}
\value{
returns a data frame containing the Euclidean representation of the distance matrix with a total inertia equal to 1
}
\references{Gower, J. C. (1966) Some distance properties of latent root and vector methods used in multivariate analysis. \emph{Biometrika}, \bold{53}, 325--338.
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\examples{
    a <- 1 / sqrt(3) - 0.2
    w <- matrix(c(0,0.8,0.8,a,0.8,0,0.8,a,
        0.8,0.8,0,a,a,a,a,0),4,4)
    w <- as.dist(w)
    w <- cailliez(w)
    w
    pcoscaled(w)
    dist(pcoscaled(w)) # w
    dist(pcoscaled(2 * w)) # the same
    sum(pcoscaled(w)^2) # unity
}
\keyword{array}
