\encoding{latin1}
\name{statico}
\alias{statico}
\title{STATIS and Co-Inertia : Analysis of a series of paired ecological tables}
\description{
Does the analysis of a series of pairs of ecological tables. This function uses
Partial Triadic Analysis (\link{pta}) and \link{ktab.match2ktabs}
to do the computations.
}
\usage{
statico(KTX, KTY, scannf = TRUE)
}
\arguments{
  \item{KTX}{an objet of class ktab}
  \item{KTY}{an objet of class ktab}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
}
\details{
This function takes 2 ktabs and crosses each pair of tables of these ktabs with the function \link{ktab.match2ktabs}. It then does a partial triadic analysis on this new ktab with \link{pta}.
}
\value{
a list of class ktab, subclass kcoinertia. See \link{ktab}
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
spepca <- dudi.pca(meau$spe, scale = FALSE, scan = FALSE, nf = 2)
wit2 <- within(spepca, meau$design$season, scan = FALSE, nf = 2)
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kta2 <- ktab.within(wit2, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
statico1 <- statico(kta1, kta2, scan = FALSE)
plot(statico1)
kplot(statico1)
}
\keyword{multivariate}
