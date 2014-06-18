\encoding{latin1}
\name{lascaux}
\alias{lascaux}
\docType{data}
\title{Genetic/Environment and types of variables}
\description{
This data set gives meristic, genetic and morphological data frame 
for 306 trouts.  
}
\usage{data(lascaux)}
\format{
    \code{lascaux} is a list of 9 components.
    \describe{
        \item{riv}{is a factor returning the river where 306 trouts are captured}
        \item{code}{vector of characters : code of the 306 trouts}
        \item{sex}{factor sex of the 306 trouts}
        \item{meris}{data frame 306 trouts - 5 meristic variables}
        \item{tap}{data frame of the total number of red and black points}
        \item{gen}{factor of the genetic code of the 306 trouts}
        \item{morpho}{data frame 306 trouts 37 morphological variables}
        \item{colo}{data frame 306 trouts 15 variables of coloring}
        \item{ornem}{data frame 306 trouts 15 factors (ornementation)}
    }
}
\source{
Lascaux, J.M. (1996)
\emph{Analyse de la variabilité morphologique de la truite commune (Salmo trutta L.) dans les cours d'eau du bassin pyrénéen méditerranéen}.
Thèse de doctorat en sciences agronomiques, INP Toulouse.
}
\references{
See a data description at \url{http://pbil.univ-lyon1.fr/R/pps/pps022.pdf} (in French).
}
\examples{
data(lascaux)

if(adegraphicsLoaded()) {
  g1 <- s1d.barchart(dudi.pca(lascaux$meris, scan = FALSE)$eig, psub.text = "Meristic", 
    p1d.hori = F, plot = FALSE)
  g2 <- s1d.barchart(dudi.pca(lascaux$colo, scan = FALSE)$eig, psub.text = "Coloration", 
    p1d.hori = F, plot = FALSE)
  g3 <- s1d.barchart(dudi.pca(na.omit(lascaux$morpho), scan = FALSE)$eig, 
    psub.text = "Morphometric", p1d.hori = F, plot = FALSE)
  g4 <- s1d.barchart(dudi.acm(na.omit(lascaux$orne), scan = FALSE)$eig, 
    psub.text = "Ornemental", p1d.hori = F, plot = FALSE)
  
  G <- ADEgS(c(g1, g2, g3, g4), layout = c(2, 2))
  
} else {
  par(mfrow = c(2,2))
  barplot(dudi.pca(lascaux$meris, scan = FALSE)$eig)
  title(main = "Meristic")
  barplot(dudi.pca(lascaux$colo, scan = FALSE)$eig)
  title(main = "Coloration")
  barplot(dudi.pca(na.omit(lascaux$morpho), scan = FALSE)$eig)
  title(main = "Morphometric")
  barplot(dudi.acm(na.omit(lascaux$orne), scan = FALSE)$eig)
  title(main = "Ornemental")
  par(mfrow = c(1,1))
}
}
\keyword{datasets}
