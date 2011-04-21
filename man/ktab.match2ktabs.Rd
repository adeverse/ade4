\encoding{latin1}
\name{ktab.match2ktabs}
\alias{ktab.match2ktabs}
\title{STATIS and Co-Inertia : Analysis of a series of paired ecological tables}
\description{
Prepares the analysis of a series of paired ecological tables. Partial Triadic
Analysis (see \code{\link{pta}}) can be used thereafter to perform the analysis of this k-table.
}
\usage{
ktab.match2ktabs(KTX, KTY)
}
\arguments{
  \item{KTX}{an objet of class \code{ktab}}
  \item{KTY}{an objet of class \code{ktab}}
}
\value{
a list of class \code{ktab}, subclass \code{kcoinertia}. See \code{\link{ktab}}
}
\references{
Thioulouse J., Simier M. and Chessel D. (2004). Simultaneous analysis of a sequence of paired ecological tables.  \emph{Ecology} \bold{85}, 272-283.. 

Simier, M., Blanc L., Pellegrin F., and Nandris D. (1999). Approche simultanée de K couples de tableaux : 
Application a l'étude des relations pathologie végétale - environnement. \emph{Revue de Statistique Appliquée}, \bold{47}, 31-46.
}
\author{Jean Thioulouse \email{Jean.Thioulouse@univ-lyon1.fr}}
\section{WARNING }{
IMPORTANT : \code{KTX} and \code{KTY} must have the same k-tables structure, the same number
of columns, and the same column weights.
}
\examples{
data(meau)
wit1 <- withinpca(meau$env, meau$design$season, scan = FALSE, scal = "total")
pcaspe <- dudi.pca(meau$spe, scale = FALSE, scan = FALSE, nf = 2)
wit2 <- within(pcaspe, meau$design$season, scan = FALSE, nf = 2)
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kta2 <- ktab.within(wit2, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kcoi <- ktab.match2ktabs(kta1, kta2)
ptacoi <- pta(kcoi, scan = FALSE, nf = 2)
plot(ptacoi)
kplot(ptacoi)
}
\keyword{multivariate}
