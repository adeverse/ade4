\name{krandtest}
\alias{krandtest}
\alias{plot.krandtest}
\alias{print.krandtest}
\alias{as.krandtest}
\title{Class of the Permutation Tests (in C).}
\description{
Plot and print many permutation tests. Objects of class \code{'krandtest'} are lists.
}
\usage{
\method{plot}{krandtest}(x, mfrow = NULL, nclass = 10, main.title = x$names, ...)
\method{print}{krandtest}(x, ...)
as.krandtest(sim, obs, alter = "greater", call = match.call(),
names = colnames(sim), p.adjust.method = "none", output = c("light", "full"))
}
\arguments{
  \item{x}{: an object of class \code{'krandtest'}}
  \item{mfrow}{: a vector of the form 'c(nr,nc)', otherwise computed by as special own function \code{n2mfrow}}
  \item{nclass}{a number of intervals for the histogram. Ignored if object output is \code{"light"}}
  \item{main.title}{: a string of character for the main title}
  \item{\dots}{: further arguments passed to or from other methods}
  \item{sim}{a matrix or data.frame of simulated values (repetitions as
    rows, number of tests as columns}
  \item{obs}{a numeric vector of observed values for each test}
  \item{alter}{a vector of character specifying the
    alternative hypothesis for each test. Each element must be one of
    "greater" (default), "less" or "two-sided". The length must be equal
    to the length of the vector obs, values are recycled if shorter.}
  \item{call}{a call order}
  \item{names}{a vector of names for tests}
  \item{p.adjust.method}{a string indicating a method for multiple
    adjustment, see \code{p.adjust.methods} for possible choices.}
  \item{output}{a character string specifying if all simulations should be stored (\code{"full"}). This was the default until \code{ade4} 1.7-5. Now, by default (\code{"light"}), only the distribution of simulated values is stored in element \code{plot} as produced by the \code{hist} function.} 
}
\value{
\code{plot.krandtest} draws the \emph{p} simulated values histograms and the position of the observed value.
}
\author{Daniel Chessel and Stéphane Dray \email{stephane.dray@univ-lyon1.fr} }
\seealso{\code{\link{randtest}}}
\examples{
wkrandtest <- as.krandtest(obs=c(0,1.2,2.4,3.4,5.4,20.4),sim=matrix(rnorm(6*200),200,6))
wkrandtest
plot(wkrandtest)
}
\keyword{methods}
