\encoding{latin1}
\name{costatis.randtest}
\alias{costatis.randtest}
\title{Monte-Carlo test on a Costatis analysis (in C).}
\description{
Performs a Monte-Carlo test on a Costatis analysis. 
}
\usage{
costatis.randtest(KTX, KTY, nrepet = 999)
}
\arguments{
  \item{KTX}{an objet of class ktab}
  \item{KTY}{an objet of class ktab}
  \item{nrepet}{the number of permutations}
}
\value{
a list of the class \code{randtest}
}
\references{
Thioulouse J. (2011). Simultaneous analysis of a sequence of paired ecological tables: a comparison of several methods. \emph{Annals of Applied Statistics}, \bold{5}, 2300-2325.
}
\author{Jean Thioulouse \email{Jean.Thioulouse@univ-lyon1.fr}}
\examples{
data(meau)
wit1 <- withinpca(meau$env, meau$design$season, scan = FALSE, scal = "total")
pcaspe <- dudi.pca(meau$spe, scale = FALSE, scan = FALSE, nf = 2)
wit2 <- wca(pcaspe, meau$design$season, scan = FALSE, nf = 2)
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kta2 <- ktab.within(wit2, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
costatis1 <- costatis(kta1, kta2, scan = FALSE)
costatis.randtest(kta1, kta2)
}
\keyword{multivariate}
\keyword{nonparametric}
