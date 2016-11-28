\name{palm}
\alias{palm}
\docType{data}
\title{Phylogenetic and quantitative traits of amazonian palm trees}
\description{
This data set describes the phylogeny of 66 amazonian palm trees. It also gives 7 traits corresponding to these 66 species.
}
\usage{data(palm)}
\format{
\code{palm} is a list containing the 2 following objects: 
\describe{ 
   \item{tre}{is a character string giving the phylogenetic tree in Newick format.} 
   \item{traits}{is a data frame with 66 species (rows) and 7 traits (columns).}
} }
\details{       
Variables of \code{palm$traits} are the following ones: \cr
rord: specific richness with five ordered levels\cr
h: height in meter (squared transform)\cr
dqual: diameter at breast height in centimeter with five levels \code{sout : subterranean}, \code{ d1(0, 5 cm)}, \code{ d2(5, 15 cm)}, \code{ d3(15, 30 cm)} and \code{ d4(30, 100 cm)}\cr
vfruit: fruit volume in \eqn{mm^{3}}{mm^3} (logged transform)\cr
vgrain: seed volume in \eqn{mm^{3}}{mm^3} (logged transform)\cr
aire: spatial distribution area (\eqn{km^{2}}{km^2})\cr
alti: maximum altitude in meter (logged transform)\cr       
}
\source{
This data set was obtained by Clémentine Gimaret-Carpentier.
}
\examples{
\dontrun{
data(palm)
palm.phy <- newick2phylog(palm$tre)
radial.phylog(palm.phy,clabel.l=1.25)

orthogram(palm$traits[,4],palm.phy$Bscores)
dotchart.phylog(palm.phy,palm$traits[,4], clabel.l = 1,
 labels.n = palm.phy$Blabels, clabel.n = 0.75)
w <- cbind.data.frame(palm.phy$Bscores[,c(3,4,6,13,21)],
 scalewt((palm$traits[,4])))
names(w)[6] <- names(palm$traits[4])
table.phylog(w, palm.phy, clabel.r = 0.75, f = 0.5)

gearymoran(palm.phy$Amat, palm$traits[,-c(1,3)])
}}
\keyword{datasets}
