\encoding{latin1}
\name{carni70}
\alias{carni70}
\docType{data}
\title{Phylogeny and quantitative traits of carnivora}
\description{
This data set describes the phylogeny of 70 carnivora as reported by Diniz-Filho and Torres (2002). It also gives the geographic range size and body size corresponding to these 70 species.
}
\usage{data(carni70)}
\format{
\code{carni70} is a list containing the 2 following objects: 
\describe{
   \item{tre}{is a character string giving the phylogenetic tree in Newick format.
   Branch lengths are expressed as divergence times (millions of years)} 
   \item{tab}{is a data frame with 70 species and two traits: size (body size (kg)) ; range (geographic range size (km)).}    
}}
\source{
Diniz-Filho, J. A. F., and N. M. Tôrres. (2002) Phylogenetic comparative methods and the 
geographic range size-body size relationship in new world terrestrial carnivora. \emph{Evolutionary Ecology}, \bold{16}, 351--367.
}
\examples{
\dontrun{
data(carni70)
carni70.phy <- newick2phylog(carni70$tre)
plot(carni70.phy)

size <- scalewt(log(carni70$tab))[,1]
names(size) <- row.names(carni70$tab)
symbols.phylog(carni70.phy,size)
orthogram(size, phylog = carni70.phy)

yrange <- scalewt(carni70$tab[,2])
names(yrange) <- row.names(carni70$tab)
symbols.phylog(carni70.phy,yrange)
orthogram(yrange, phylog = carni70.phy)

s.hist(cbind.data.frame(size, yrange), clabel = 0)
}}
\keyword{datasets}
