\name{rtest.between}
\alias{rtest.between}
\title{Monte-Carlo Test on the between-groups inertia percentage (in R).
}
\description{
Performs a Monte-Carlo test on the between-groups inertia percentage. 
}
\usage{
rtest.between(xtest, nrepet = 99, \dots)
}
\arguments{
  \item{xtest}{an object of class \code{between}}
  \item{nrepet}{the number of permutations}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
a list of the class \code{rtest}
}
\author{Daniel Chessel }
\references{
Romesburg, H. C. (1985) Exploring, confirming and randomization tests. \emph{Computers and Geosciences}, \bold{11}, 19--37.
}
\examples{
data(meaudret)
pca1 <- dudi.pca(meaudret$mil, scan = FALSE, nf = 3)
rand1 <- rtest(between(pca1, meaudret$plan$dat, scan = FALSE), 99)
rand1
plot(rand1, main = "Monte-Carlo test")
}
\keyword{multivariate}
\keyword{nonparametric}
