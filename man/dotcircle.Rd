\name{dotcircle}
\alias{dotcircle}
\title{Representation of n values on a circle}
\description{
This function represents \emph{n} values on a circle. The \emph{n} points are shared out regularly over the circle and put on the radius according to the value attributed to that measure.
}
\usage{
dotcircle(z, alpha0 = pi/2, xlim = range(pretty(z)),
 labels = names(z), clabel = 1, cleg = 1)
}
\arguments{
  \item{z}{: a numeric vector}
  \item{alpha0}{: polar angle to put the first value}
  \item{xlim}{: the ranges to be encompassed by the circle radius}
  \item{labels}{: a vector of strings of characters for the angle labels}
  \item{clabel}{: a character size for the labels, used with  \code{par("cex")*clabel}}
  \item{cleg}{: a character size for the ranges, used with \code{par("cex")*cleg}}
}
\seealso{\code{\link[CircStats]{circ.plot}}}
\examples{
w <- scores.neig(neig(n.cir = 24))
par(mfrow = c(4,4))
for (k in 1:16) dotcircle(w[,k],labels = 1:24)
par(mfrow = c(1,1))
}
\keyword{hplot}
