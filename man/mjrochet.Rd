\encoding{latin1}
\name{mjrochet}
\alias{mjrochet}
\docType{data}
\title{Phylogeny and quantitative traits of teleos fishes}
\description{
This data set describes the phylogeny of 49 teleos fishes as reported by Rochet et al. (2000). It also gives life-history traits corresponding to these 49 species.
}
\usage{data(mjrochet)}
\format{
\code{mjrochet} is a list containing the 2 following objects : 
\describe{ 
   \item{tre}{is a character string giving the phylogenetic tree in Newick format.}
   \item{tab}{is a data frame with 49 rows and 7 traits.}  
}}
\details{        
 Variables of \code{mjrochet$tab} are the following ones : tm (age at maturity (years)), 
 lm (length at maturity (cm)), l05 (length at 5 per cent survival (cm)),
 t05 (time to 5 per cent survival (years)), fb (slope of the log-log fecundity-length relationship),
 fm (fecundity the year of maturity), egg (volume of eggs (\eqn{mm^{3}}{mm^3})).
}
\source{
Data taken from: \cr
    Summary of data - Clupeiformes : \url{http://www.ifremer.fr/maerha/clupe.html} \cr
    Summary of data - Argentiniformes : \url{http://www.ifremer.fr/maerha/argentin.html} \cr
    Summary of data - Salmoniformes : \url{http://www.ifremer.fr/maerha/salmon.html} \cr
    Summary of data - Gadiformes : \url{http://www.ifremer.fr/maerha/gadi.html} \cr
    Summary of data - Lophiiformes : \url{http://www.ifremer.fr/maerha/loph.html} \cr
    Summary of data - Atheriniformes : \url{http://www.ifremer.fr/maerha/ather.html} \cr
    Summary of data - Perciformes : \url{http://www.ifremer.fr/maerha/perci.html} \cr
    Summary of data - Pleuronectiformes : \url{http://www.ifremer.fr/maerha/pleuro.html} \cr
    Summary of data - Scorpaeniformes : \url{http://www.ifremer.fr/maerha/scorpa.html} \cr
    Phylogenetic tree : \url{http://www.ifremer.fr/maerha/life_history.html}
}
\references{
Rochet, M. J., Cornillon, P-A., Sabatier, R. and Pontier, D. (2000) 
Comparative analysis of phylogenic and fishing effects in life history patterns of teleos fishes.
\emph{Oïkos}, \bold{91}, 255--270.
}
\examples{
data(mjrochet)
mjrochet.phy <- newick2phylog(mjrochet$tre)
tab <- log((mjrochet$tab))
tab0 <- data.frame(scalewt(tab))
table.phylog(tab0, mjrochet.phy, csi = 2, clabel.r = 0.75)
orthogram(tab0[,1], ortho = mjrochet.phy$Bscores)
}
\keyword{datasets}
