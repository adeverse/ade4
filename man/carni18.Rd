\name{carni18}
\alias{carni18}
\docType{data}
\title{Phylogeny and quantitative traits of carnivora}
\description{
This data set describes the phylogeny of carnivora. It also gives 16 traits corresponding to these 18 species.
}
\usage{data(carni18)}
\format{
\code{carni18} is a list containing the 2 following objects : \cr  
            \item{tre}{is a character string giving the phylogenetic tree in Newick format.} 
            \item{traits}{is a data frame with 18 species (rows) and 16 traits (columns).}
}
\examples{
data(carni18)
w <- as.data.frame(apply(carni18$traits, 2,
 function(x) if (all(x>0)) scalewt(log(x)) else scalewt(x)))
row.names(w) <- row.names(carni18$traits)
carni18.phy <- newick2phylog(carni18$tre)
table.phylog(w, carni18.phy, csi = 1.5, clabel.c = 0.75,
 clabel.r = 0.75)
}
\keyword{datasets}
