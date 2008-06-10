\name{rtest}
\alias{rtest}
\alias{as.rtest}
\alias{plot.rtest}
\alias{print.rtest}
\title{Class of the Permutation Tests (in R).}
\description{
rtest is a generic function. It proposes methods for the following objects \code{between}, \code{discrimin}, \code{procuste} \code{\dots}\cr
}
\usage{
    rtest(xtest, \dots)
    \method{plot}{rtest}(x, nclass = 10, coeff = 1, \dots)
    as.rtest (sim, obs, call = match.call())
    \method{print}{rtest}(x, \dots)
}
\arguments{
\item{xtest}{an object used to select a method}
\item{x}{an object of class 'rtest'}
\item{\dots}{further arguments passed to or from other methods; in \code{plot.randtest} to \code{hist}}
\item{nclass}{a number of intervals for the histogram}
\item{coeff}{to fit the magnitude of the graph}
\item{sim}{a numeric vector of simulated values}
\item{obs}{a numeric vector of an observed value}
\item{call}{a call order}
}
\value{
\code{as.rtest} returns a list of class \code{rtest}\cr
\code{plot.rtest} draws the simulated values histograms and the position of the observed value\cr
}
\seealso{\code{\link{RV.rtest}}, \code{\link{mantel.rtest}}, \code{\link{procuste.rtest}}, \code{\link{randtest}}}
\author{Daniel Chessel }
\examples{
par(mfrow = c(2,2))
for (x0 in c(2.4,3.4,5.4,20.4)) {
    l0 <- as.rtest(sim = rnorm(200), obs = x0)
    print(l0)
    plot(l0,main=paste("p.value = ", round(l0$pvalue, dig = 5)))
}
}
\keyword{methods}
