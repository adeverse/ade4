\name{randtest.coinertia}
\alias{randtest.coinertia}
\title{Monte-Carlo test on a coinertia analysis (in C).}
\description{
Performs a Monte-Carlo test on a coinertia analysis. 
}
\usage{
randtest.coinertia(xtest, nrepet = 999, fixed=0, \dots)
}
\arguments{
  \item{xtest}{an object of class \code{coinertia}}
  \item{nrepet}{the number of permutations}
  \item{fixed}{when non uniform row weights are used in the coinertia analysis,
this parameter must be the number of the table that should be kept fixed in the permutations}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
a list of the class \code{randtest}
}
\references{
Doledec, S. and Chessel, D. (1994) Co-inertia analysis: an alternative method for
studying species-environment relationships. \emph{Freshwater Biology}, \bold{31}, 277--294.
}
\examples{
data(doubs)
dudi1 <- dudi.pca(doubs$mil, scale = TRUE, scan = FALSE, nf = 3)
dudi2 <- dudi.pca(doubs$poi, scale = FALSE, scan = FALSE, nf = 2)
coin1 <- coinertia(dudi1,dudi2, scan = FALSE, nf = 2)
plot(randtest(coin1))
 }
\keyword{multivariate}
\keyword{nonparametric}
