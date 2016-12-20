\name{rpjdl}
\alias{rpjdl}
\docType{data}
\title{Avifauna and Vegetation}
\description{
This data set gives the abundance of 51 species and 8 environmental variables 
in 182 sites. 
}
\usage{data(rpjdl)}
\format{
    \code{rpjdl} is a list of 5 components.
    \describe{
    \item{fau}{is the faunistic array of 182 sites (rows) and 51 species (columns).}
    \item{mil}{is the array of environmental variables : 182 sites and 8 variables.}
    \item{frlab}{is a vector of the names of species in French.}
    \item{lalab}{is a vector of the names of species in Latin.}
    \item{lab}{is a vector of the simplified labels of species.}
    }
}
\source{
Prodon, R. and Lebreton, J.D. (1981)
Breeding avifauna of a Mediterranean succession : the holm oak and cork oak series in the eastern Pyrénées.
1 : Analysis and modelling of the structure gradient.
\emph{Oïkos}, \bold{37}, 21--38.

Lebreton, J. D., Chessel D., Prodon R. and Yoccoz N. (1988)
L'analyse des relations espèces-milieu par l'analyse canonique des correspondances.
I. Variables de milieu quantitatives.
\emph{Acta Oecologica, Oecologia Generalis}, \bold{9}, 53--67.
}
\references{
See a data description at \url{http://pbil.univ-lyon1.fr/R/pdf/pps048.pdf} (in French).
}
\examples{
\dontrun{
data(rpjdl)
xy <- dudi.coa(rpjdl$fau, scann = FALSE)$l1
xy1 <- dudi.pca(rpjdl$fau, scal = FALSE, scann = FALSE)$l1

if(adegraphicsLoaded()) {
  g1 <- s.distri(xy, rpjdl$fau, xax = 2, yax = 1, starSize = 0.3, ellipseSize = 0, plab.cex = 0)
  g2 <- s.distri(xy1, rpjdl$fau, xax = 2, yax = 1, starSize = 0.3, ellipseSize = 0, plab.cex = 0)
} else {
  s.distri(xy, rpjdl$fau, 2, 1, cstar = 0.3, cell = 0)
  s.distri(xy1, rpjdl$fau, 2, 1, cstar = 0.3, cell = 0)
}

cca1 <- cca(rpjdl$fau, rpjdl$mil, scan = FALSE)
plot(cca1)
}}
\keyword{datasets}
