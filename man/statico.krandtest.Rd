\name{statico.krandtest}
\alias{statico.krandtest}
\title{Monte-Carlo test on a Statico analysis (in C).}
\description{
Performs the series of Monte-Carlo coinertia tests of a Statico analysis (one for each couple of tables). 
}
\usage{
statico.krandtest(KTX, KTY, nrepet = 999)
}
\arguments{
  \item{KTX}{an objet of class ktab}
  \item{KTY}{an objet of class ktab}
  \item{nrepet}{the number of permutations}
}
\details{
This function takes 2 ktabs and does a coinertia analysis with \link{coinertia} on each pair of tables. It then uses the \link{randtest} function to do a permutation test on each of these coinertia analyses.
}
\value{
krandtest, a list of randtest objects. See \link{krandtest}
}
\references{
Thioulouse J. (2011). Simultaneous analysis of a sequence of paired ecological tables: a comparison of several methods. \emph{Annals of Applied Statistics}, \bold{5}, 2300-2325.
}
\author{Jean Thioulouse \email{jean.thioulouse@univ-lyon1.fr}}
\section{WARNING }{
IMPORTANT : KTX and KTY must have the same k-tables structure, the same number
of columns, and the same column weights.
}
\examples{
data(meau)
wit1 <- withinpca(meau$env, meau$design$season, scan = FALSE, scal = "total")
spepca <- dudi.pca(meau$spe, scale = FALSE, scan = FALSE, nf = 2)
wit2 <- wca(spepca, meau$design$season, scan = FALSE, nf = 2)
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kta2 <- ktab.within(wit2, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
statico1 <- statico(kta1, kta2, scan = FALSE)
kr1 <- statico.krandtest(kta1, kta2)
plot(kr1)
}
\keyword{multivariate}
