\name{randboot}
\alias{as.krandboot}
\alias{print.krandboot}
\alias{as.randboot}
\alias{print.randboot}
\alias{randboot}
\title{Bootstrap simulations}
\description{Functions and classes to manage outputs of bootstrap
  simulations for one (class \code{randboot}) or several (class \code{krandboot}) statistics}
\usage{
as.krandboot(obs, boot, quantiles = c(0.025, 0.975), names =
colnames(boot), call = match.call())
\method{print}{krandboot}(x, ...)
as.randboot(obs, boot, quantiles = c(0.025, 0.975), call = match.call())
\method{print}{randboot}(x, ...)
randboot(object, ...)
}

\arguments{
  \item{obs}{a value (class \code{randboot}) or a vector (class
    \code{krandboot}) with observed statistics}
  \item{boot}{a vector (class \code{randboot}) or a matrix (class
    \code{krandboot}) with the bootstrap values of the statistics}
  \item{quantiles}{a vector indicating the lower and upper quantiles to compute}
  \item{names}{a vector of names for the statistics}
  \item{call}{the matching call}
  \item{x}{an object of class \code{randboot} or \code{krandboot}}
  \item{object}{an object on which bootstrap should be perform}
  \item{\dots}{other arguments to be passed to methods}
}

\value{an object of class \code{randboot} or \code{krandboot}}

\references{Carpenter, J. \& Bithell, J. (2000) Bootstrap confidence
  intervals: when, which, what? A practical guide for medical
  statisticians.\emph{Statistics in medicine}, 19, 1141-1164}

\author{Stéphane Dray (\email{stephane.dray@univ-lyon1.fr})}

\seealso{\code{\link{randboot.multiblock}}}
\examples{
## an example corresponding to 10 statistics and 100 repetitions
bt <- as.krandboot(obs = rnorm(10), boot = matrix(rnorm(1000), nrow = 100))
bt
if(adegraphicsLoaded())
plot(bt) 

}

\keyword{htest}

