\encoding{latin1}
\name{mcoa}
\alias{mcoa}
\alias{print.mcoa}
\alias{summary.mcoa}
\alias{plot.mcoa}
\title{Multiple CO-inertia Analysis}
\description{
performs a multiple CO-inertia analysis, 
using an object of class \code{ktab}. 
}
\usage{
mcoa(X, option = c("inertia", "lambda1", "uniform", "internal"), 
    scannf = TRUE, nf = 3, tol = 1e-07)
\method{print}{mcoa}(x, \dots)
\method{summary}{mcoa}(object, \dots)
\method{plot}{mcoa}(x, xax = 1, yax = 2, eig.bottom = TRUE, \dots)
}
\arguments{
  \item{X}{an object of class \code{ktab}}
  \item{option}{a string of characters for the weightings of the arrays
    options :
    \describe{
     \item{"inertia"}{weighting of group k by the inverse of the total inertia of the array k}
     \item{"lambda1"}{weighting of group k by the inverse of the first eigenvalue of the k analysis}
     \item{"uniform"}{uniform weighting of groups}
     \item{"internal"}{weighting included in \code{X$tabw}}
   }
   }
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{tol}{a tolerance threshold, an eigenvalue is considered positive if it is larger than \code{-tol*lambda1} where \code{lambda1} is the largest eigenvalue.}
  \item{x, object}{an object of class 'mcoa'}
  \item{\dots}{further arguments passed to or from other methods}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{eig.bottom}{a logical value indicating whether the eigenvalues bar plot should be added}
}
\value{
mcoa returns a list of  class 'mcoa' containing :
  \item{pseudoeig}{a numeric vector with the all pseudo eigenvalues}
  \item{call}{the call-up order}
  \item{nf}{a numeric value indicating the number of kept axes}
  \item{SynVar}{a data frame with the synthetic scores}
  \item{axis}{a data frame with the co-inertia axes}
  \item{Tli}{a data frame with the co-inertia coordinates}
  \item{Tl1}{a data frame with the co-inertia normed scores}
  \item{Tax}{a data frame with the inertia axes onto co-inertia axis}
  \item{Tco}{a data frame with the column coordinates onto synthetic scores}
  \item{TL}{a data frame with the factors for Tli Tl1}
  \item{TC}{a data frame with the factors for Tco}
  \item{T4}{a data frame with the factors for Tax}
  \item{lambda}{a data frame with the all eigenvalues (computed on the separate analyses)}
  \item{cov2}{a numeric vector with the all pseudo eigenvalues (synthetic analysis)}
}
\references{
Chessel, D. and Hanafi, M. (1996) Analyses de la co-inertie de K nuages de points, \emph{Revue de Statistique Appliquée}, \bold{44}, 35--60.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
}
\examples{
data(friday87)
w1 <- data.frame(scale(friday87$fau, scal = FALSE))
w2 <- ktab.data.frame(w1, friday87$fau.blo, tabnames = friday87$tab.names)
mcoa1 <- mcoa(w2, "lambda1", scan = FALSE)
mcoa1
summary(mcoa1)
plot(mcoa1)
}
\keyword{multivariate}
