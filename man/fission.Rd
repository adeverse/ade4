\name{fission}
\alias{fission}
\docType{data}
\title{Fission pattern and heritable morphological traits}
\description{
This data set contains the mean values of five highly heritable linear combinations of cranial metric (GM1-GM3) and non metric (GN1-GN2) for 8 social groups of Rhesus Macaques on Cayo Santiago. It also describes the fission tree depicting the historical phyletic relationships.
}
\usage{data(fission)}
\format{
\code{fission} is a list containing the 2 following objects : \cr 
        \enumerate{     
            \item{tre}{is a character string giving the fission tree in Newick format.} 
            \item{tab}{is a data frame with 8 social groups and five traits}    
        }
        
        Variables of \code{fission$tab} are the following ones : \cr
        \enumerate{
        \item{GM1}{: cranial metric}
        \item{GM2}{: cranial metric}
        \item{GM3}{: cranial non metric}
        \item{GN1}{: cranial non metric}
        \item{GN2}{: cranial non metric}
        } 
}
\references{
Cheverud, J. and Dow, M.M. (1985) An autocorrelation analysis of genetic variation due to lineal fission in social groups of rhesus macaques. \cr \emph{American Journal of Physical Anthropology}, \bold{67}, 113--122.
}
\examples{
data(fission)
fis.phy <- newick2phylog(fission$tre)
table.phylog(fission$tab[names(fis.phy$leaves),],fis.phy,csi=2)
gearymoran(fis.phy$Amat,fission$tab)
}
\keyword{datasets}
