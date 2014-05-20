\name{mantel.randtest}
\alias{mantel.randtest}
\title{Mantel test (correlation between two distance matrices (in C).)
}
\description{
Performs a Mantel test between two distance matrices.
}
\usage{
mantel.randtest(m1, m2, nrepet = 999)
}
\arguments{
  \item{m1}{an object of class \code{dist}}
  \item{m2}{an object of class \code{dist}}
  \item{nrepet}{the number of permutations}
}
\value{
an object of class \code{randtest} (randomization tests)
}
\references{Mantel, N. (1967) The detection of disease clustering and a generalized regression approach. \emph{Cancer Research}, \bold{27}, 209--220.
}
\author{Jean Thioulouse \email{Jean.Thioulouse@univ-lyon1.fr}}
\examples{
data(yanomama)
gen <- quasieuclid(as.dist(yanomama$gen))
geo <- quasieuclid(as.dist(yanomama$geo))
plot(r1 <- mantel.randtest(geo,gen), main = "Mantel's test")
r1
}
\keyword{array}
\keyword{nonparametric}
