\name{rtest}
\alias{rtest}
\title{Class of the Permutation Tests (in R).}
\description{
rtest is a generic function. It proposes methods for the following objects \code{between}, \code{discrimin}, \code{procuste} \code{\dots}\cr
}
\usage{
    rtest(xtest, \dots)
}
\arguments{
\item{xtest}{an object used to select a method}
\item{\dots}{further arguments passed to or from other methods; in \code{plot.randtest} to \code{hist}}
}
\value{
\code{rtest} returns an object of class \code{randtest}
}
\seealso{\code{\link{RV.rtest}}, \code{\link{mantel.rtest}}, \code{\link{procuste.rtest}}, \code{\link{randtest}}}
\author{Daniel Chessel }
\examples{
par(mfrow = c(2, 2))
for (x0 in c(2.4, 3.4, 5.4, 20.4)) {
    l0 <- as.randtest(sim = rnorm(200), obs = x0)
    print(l0)
    plot(l0, main = paste("p.value = ", round(l0$pvalue, dig = 5)))
}
par(mfrow = c(1, 1))
}
\keyword{methods}
