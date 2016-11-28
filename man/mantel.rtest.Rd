\name{mantel.rtest}
\alias{mantel.rtest}
\title{Mantel test (correlation between two distance matrices (in R).)
}
\description{
Performs a Mantel test between two distance matrices.
}
\usage{
mantel.rtest(m1, m2, nrepet = 99)
}
\arguments{
  \item{m1}{an object of class \code{dist}}
  \item{m2}{an object of class \code{dist}}
  \item{nrepet}{the number of permutations}
}
\value{
an object of class \code{rtest} (randomization tests)
}
\references{Mantel, N. (1967) The detection of disease clustering and a generalized regression approach. \emph{Cancer Research}, \bold{27}, 209--220.
}
\author{
Daniel Chessel  \cr
Stéphane Dray \email{stephane.dray@univ-lyon1.fr}
}
\examples{
    data(yanomama)
    gen <- quasieuclid(as.dist(yanomama$gen))
    geo <- quasieuclid(as.dist(yanomama$geo))
    plot(r1 <- mantel.rtest(geo,gen), main = "Mantel's test")
    r1
}
\keyword{array}
\keyword{nonparametric}
