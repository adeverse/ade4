\name{randxval}
\alias{randxval}
\alias{krandxval}
\alias{as.krandxval}
\alias{print.krandxval}
\alias{as.randxval}
\alias{print.randxval}

\title{Two-fold cross-validation}
\description{Functions and classes to manage outputs of two-fold
  cross-validation for one (class \code{randxval}) or several (class
  \code{krandxval}) statistics}
\usage{
as.krandxval(RMSEc, RMSEv, quantiles = c(0.25, 0.75), names =
colnames(RMSEc), call = match.call())
\method{print}{krandxval}(x, ...)
as.randxval(RMSEc, RMSEv, quantiles = c(0.25, 0.75), call =
match.call())
\method{print}{randxval}(x, ...)
}

\arguments{
  \item{RMSEc}{a vector (class \code{randxval}) or a matrix (class
    \code{krandxval}) with the root-mean-square error of calibration
  (statistics as columns and repetions as rows)}
  \item{RMSEv}{a vector (class \code{randxval}) or a matrix (class
    \code{krandxval}) with the root-mean-square error of validation
  (statistics as columns and repetions as rows)}
  \item{quantiles}{a vector indicating the lower and upper quantiles to compute}
  \item{names}{a vector of names for the statistics}
  \item{call}{the matching call}
  \item{x}{an object of class \code{randxval} or \code{krandxval}}
  \item{\dots}{other arguments to be passed to methods}
}

\value{an object of class \code{randxval} or \code{krandxval}}

\references{Stone M. (1974) Cross-validatory choice and assessment of
  statistical predictions. \emph{Journal of the Royal Statistical
    Society}, 36, 111-147}
\author{Stéphane Dray (\email{stephane.dray@univ-lyon1.fr})}

\seealso{\code{\link{testdim.multiblock}}}
\examples{
## an example corresponding to 10 statistics and 100 repetitions
cv <- as.krandxval(RMSEc = matrix(rnorm(1000), nrow = 100), RMSEv =
matrix(rnorm(1000, mean = 1), nrow = 100))
cv
if(adegraphicsLoaded())
plot(cv) 

}

\keyword{htest}
