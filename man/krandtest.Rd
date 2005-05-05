\name{krandtest}
\alias{krandtest}
\alias{plot.krandtest}
\alias{print.krandtest}
\title{Class of the Permutation Tests (in C).}
\description{
Plot and print many permutation tests. Objects of class \code{'krandtest'} are data frame with \emph{n+1} rows and \emph{p} columns. \cr
Each column corresponds to a permutation test : the first value is the observed-value and the \emph{n} others are the simulated ones.
}
\usage{
plot.krandtest(x, mfrow = NULL, nclass = NULL, main.title = names(x), ...)
print.krandtest(x, ...)
}
\arguments{
  \item{x}{: an object of class \code{'krandtest'}}
  \item{mfrow}{: a vector of the form 'c(nr,nc)', otherwise computed by as special own function \code{n2mfrow}}
  \item{nclass}{: a number of intervals for the histogram}
  \item{main.title}{: a string of character for the main title}
  \item{\dots}{: further arguments passed to or from other methods}
}
\value{
\code{plot.krandtest} draws the \emph{p} simulated values histograms and the position of the observed value.
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} \cr
\seealso{\code{\link{randtest}}}
\examples{
wkrandtest <- data.frame(eg1=c(0, rnorm(200)))
for (x0 in c(1.2,2.4,3.4,5.4,20.4)) {
    wkrandtest <- cbind.data.frame(wkrandtest, c(x0, rnorm(200)))
}
names(wkrandtest) <- paste ("Test",1:6,sep="_")
class(wkrandtest) <- "krandtest"
wkrandtest
plot(wkrandtest)
}
\keyword{methods}
