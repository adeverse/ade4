\name{trichometeo}
\alias{trichometeo}
\docType{data}
\title{Pair of Ecological Data}
\description{
This data set gives for trappong nights informations about 
species and meteorological variables. 
}
\usage{data(trichometeo)}
\format{
\code{trichometeo} is a list of 3 components.
\describe{
    \item{fau}{is a data frame with 49 rows (trapping nights) and 17 species.}
    \item{meteo}{is a data frame with 49 rows and 11 meteorological variables.}
    \item{cla}{is a factor of 12 levels for the definition of the consecutive night groups}
    }
}
\source{
Data from P. Usseglio-Polatera
}
\references{
Usseglio-Polatera, P. and Auda, Y. (1987) 
Influence des facteurs météorologiques sur les résultats de piégeage lumineux. 
\emph{Annales de Limnologie}, \bold{23}, 65--79. (code des espèces p. 76)

See a data description at \url{http://pbil.univ-lyon1.fr/R/pdf/pps034.pdf} (in French).
}
\examples{
data(trichometeo)
faulog <- log(trichometeo$fau + 1)
pca1 <- dudi.pca(trichometeo$meteo, scan = FALSE)
niche1 <- niche(pca1, faulog, scan = FALSE)

if(adegraphicsLoaded()) {
  g1 <- s.distri(niche1$ls, faulog, plab.cex = 0.6, ellipseSize = 0, starSize = 0.3, plot = FALSE)
  g2 <- s.arrow(7 * niche1$c1, plab.cex = 1, plot = FALSE)
  G <- superpose(g1, g2, plot = TRUE)
  
} else {
  s.label(niche1$ls, clab = 0)
  s.distri(niche1$ls, faulog, clab = 0.6, add.p = TRUE, cell = 0, csta = 0.3)
  s.arrow(7 * niche1$c1, clab = 1, add.p = TRUE)
}}
\keyword{datasets}
