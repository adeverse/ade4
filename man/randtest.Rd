\name{randtest}
\alias{randtest}
\alias{as.randtest}
\alias{plot.randtest}
\alias{print.randtest}

\title{Class of the Permutation Tests (in C).}

\description{\code{randtest} is a generic function. It proposes methods for the following objects \code{between}, \code{discrimin}, \code{coinertia} \code{\dots}
}

\usage{
randtest(xtest, \dots)
as.randtest(sim, obs, alter = c("greater", "less", "two-sided"), 
  output = c("light", "full"), call = match.call(), subclass = NULL)

\method{plot}{randtest}(x, nclass = 10, coeff = 1, \dots)
\method{print}{randtest}(x, \dots)
}

\arguments{
\item{xtest}{an object used to select a method}
\item{x}{an object of class \code{randtest}}
\item{\dots}{further arguments passed to or from other methods; in \code{plot.randtest} to \code{hist}}
\item{output}{a character string specifying if all simulations should be stored (\code{"full"}). This was the default until \code{ade4} 1.7-5. Now, by default (\code{"light"}), only the distribution    of simulated values is stored in element \code{plot} as produced by the \code{hist} function.}
\item{nclass}{a number of intervals for the histogram. Ignored if object output is \code{"light"}}
\item{coeff}{to fit the magnitude of the graph. Ignored if object output is \code{"light"}}
\item{sim}{a numeric vector of simulated values}
\item{obs}{a numeric vector of an observed value}
\item{alter}{a character string specifying the alternative hypothesis, must be one of "greater" (default), "less" or "two-sided"}
\item{call}{a call order}
\item{subclass}{a character vector indicating the subclasses associated to the returned object}
}

\value{
\code{as.randtest} returns a list of class \code{randtest}.\cr
\code{plot.randtest} draws the simulated values histograms and the position of the observed value.
}

\details{
If the alternative hypothesis is "greater", a p-value is estimated as: (number of random values equal to or greater than the observed one +
1)/(number of permutations + 1). The null hypothesis is rejected if the p-value is less than the significance level. If the alternative
hypothesis is "less", a p-value is estimated as: (number of random values equal to or less than the observed one + 1)/(number of
permutations + 1). Again, the null hypothesis is rejected if the p-value is less than the significance level. Lastly, if the alternative
hypothesis is "two-sided", the estimation of the p-value is equivalent to the one used for "greater" except that random and observed values are
firstly centered (using the average of random values) and secondly transformed to their absolute values. Note that this is only suitable
for symmetric random distribution.
}

\seealso{\link{randtest.amova}, \link{randtest.between}, \link{randtest.coinertia}, \link{randtest.discrimin}, 
\link{randtest.dpcoa}, \link{randtest.pcaiv}, \link{rtest}, \link{rtest.between}, \link{rtest.discrimin}, 
\link{RV.rtest}, \link{RVdist.randtest}, \link{mantel.randtest}, \link{mantel.rtest}, \link{procuste.randtest}, \link{procuste.rtest}
}

\examples{
par(mfrow = c(2,2))
for (x0 in c(2.4,3.4,5.4,20.4)) {
  l0 <- as.randtest(sim = rnorm(200), obs = x0)
  print(l0)
  plot(l0,main=paste("p.value = ", round(l0$pvalue, dig = 5)))
}
par(mfrow = c(1,1))
}

\keyword{methods}
