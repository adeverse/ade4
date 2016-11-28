\name{costatis}
\alias{costatis}
\title{STATIS and Co-Inertia : Analysis of a series of paired ecological tables}
\description{
Analysis of a series of pairs of ecological tables. This function uses
Partial Triadic Analysis (\link{pta}) and \link{coinertia}
to do the computations.
}
\usage{
costatis(KTX, KTY, scannf = TRUE)
}
\arguments{
  \item{KTX}{an objet of class ktab}
  \item{KTY}{an objet of class ktab}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
}
\details{
This function takes 2 ktabs. It does a PTA (partial triadic analysis: \link{pta}) on each ktab, and does a coinertia analysis (\link{coinertia}) on the compromises of the two PTAs.
}
\value{
a list of class coinertia, subclass dudi. See \link{coinertia}
}
\references{
Thioulouse J. (2011). Simultaneous analysis of a sequence of paired ecological tables: a comparison of several methods. \emph{Annals of Applied Statistics}, \bold{5}, 2300-2325.
}
\author{Jean Thioulouse \email{Jean.Thioulouse@univ-lyon1.fr}}
\section{WARNING }{
IMPORTANT : KTX and KTY must have the same k-tables structure, the same number
of columns, and the same column weights.
}
\examples{
data(meau)
wit1 <- withinpca(meau$env, meau$design$season, scan = FALSE, scal = "total")
pcaspe <- dudi.pca(meau$spe, scale = FALSE, scan = FALSE, nf = 2)
wit2 <- wca(pcaspe, meau$design$season, scan = FALSE, nf = 2)
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kta2 <- ktab.within(wit2, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
costatis1 <- costatis(kta1, kta2, scan = FALSE)
plot(costatis1)
}
\keyword{multivariate}
