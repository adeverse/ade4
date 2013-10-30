\encoding{latin1}
\name{costatis}
\alias{costatis}
\title{STATIS and Co-Inertia : Analysis of a series of paired ecological tables}
\description{
Does the analysis of a series of pairs of ecological tables. This function uses
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
Thioulouse J., Simier M. and Chessel D. (2004). Simultaneous analysis of a sequence of paired ecological tables.  \emph{Ecology} \bold{85}, 272-283.. 

Simier, M., Blanc L., Pellegrin F., and Nandris D. (1999). Approche simultanée de K couples de tableaux : 
Application a l'étude des relations pathologie végétale - environnement. \emph{Revue de Statistique Appliquée}, \bold{47}, 31-46.
}
\author{Jean Thioulouse \email{jean.thioulouse@univ-lyon1.fr}}
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
