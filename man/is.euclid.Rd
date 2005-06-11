\name{is.euclid}
\alias{is.euclid}
\alias{summary.dist}
\alias{mat2dist}
\alias{dist2mat}
\title{Is a Distance Matrix Euclidean ?}
\description{
Confirmation of the Euclidean nature of a distance matrix by the Gower's theorem.\cr
\code{is.euclid} is used in \code{summary.dist}.\cr
\code{mat2dist} and \code{dist2mat} are local copies of \code{as.dist} and \code{as.matrix.dist} of mva.
}
\usage{
is.euclid(distmat, plot = FALSE, print = FALSE, tol = 1e-07)
summary.dist(object, \dots)
}
\arguments{
  \item{distmat}{an object of class 'dist'}
  \item{plot}{a logical value indicating whether the eigenvalues bar plot of the matrix of the term \eqn{-\frac{1}{2} {d_{ij}^2}}{-1/2 dij²} centred by rows and columns should be diplayed}
  \item{print}{a logical value indicating whether the eigenvalues of the matrix of the term \eqn{-\frac{1}{2} {d_{ij}^2}}{-1/2 dij²} centred by rows and columns should be printed}
  \item{tol}{a tolerance threshold : an eigenvalue is considered positive if it is larger than \code{-tol*lambda1} where \code{lambda1} is the largest eigenvalue.}
  \item{object}{an object of class 'dist'}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns a logical value indicating if all the eigenvalues are positive or equal to zero
}
\references{Gower, J.C. and Legendre, P. (1986) Metric and Euclidean properties of dissimilarity coefficients. \emph{Journal of Classification}, \bold{3}, 5--48.
}
\author{
Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} \cr
Stéphane Dray \email{dray@biomserv.univ-lyon1.fr}
}
\examples{
w <- matrix(runif(10000), 100, 100)
w <- dist(w)
summary(w)
is.euclid (w) # TRUE
w <- quasieuclid(w) # no correction need in: quasieuclid(w)
w <- lingoes(w) # no correction need in: lingoes(w)
w <- cailliez(w) # no correction need in: cailliez(w)
rm(w)
}
\keyword{array}
