\name{apis108}
\docType{data}
\alias{apis108}
\title{Allelic frequencies in ten honeybees populations at eight microsatellites loci}
\description{
This data set gives the occurences for the allelic form on 8 loci in 10 populations of honeybees.
} 
\usage{data(apis108)} 
\format{
A data frame containing 180 rows (allelic forms on 8 loci) and 10 columns (populations of honeybees : El.Hermel, Al.Hoceima, 
Nimba, Celinda, Pretoria, Chalkidiki, Forli, Valenciennes, Umea and Seville).
} 
\source{
\url{http://www.montpellier.inra.fr/URLB/apis/libanfreq.pdf}\cr

Franck P., Garnery L., Solignac M. and Cornuet J.M. (2000) Molecular confirmation of a fourth lineage in honeybees from the Near-East. 
\emph{Apidologie}, \bold{31}, 167--180.
}
\examples{
data(apis108)
apis <- count2genet(as.data.frame(t(apis108)))
apis.pca <- dudi.pca(apis$tab, center = apis$center,
    scale = FALSE, scannf = FALSE, nf = 3)
} 
\keyword{datasets}
