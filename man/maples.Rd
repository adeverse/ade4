\name{maples}
\alias{maples}
\docType{data}
\title{Phylogeny and quantitative traits of flowers}
\description{
This data set describes the phylogeny of 17 flowers as reported by Ackerly and Donoghue (1998). It also gives 31 traits corresponding to these 17 species.
}
\usage{data(maples)}
\format{
\code{tithonia} is a list containing the 2 following objects : \cr 
        \enumerate{     
            \item{tre}{is a character string giving the phylogenetic tree in Newick format.} 
            \item{tab}{is a data frame with 17 species and 31 traits}    
        }
}
\source{
Data were obtained from the URL \url{http://www.stanford.edu/~dackerly/acerdata.html}.
}
\references{
Ackerly, D. D. and Donoghue, M.J. (1998) Leaf size, sappling allometry, and Corner's rules: phylogeny and correlated evolution in Maples (Acer). \cr \emph{American Naturalist}, \bold{152}, 767--791.
}
\examples{
data(maples)
phy <- newick2phylog(maples$tre)
dom <- maples$tab$Dom
bif <- maples$tab$Bif
orthogram(dom, phylog = phy)
orthogram(bif, phylog = phy)
par(mfrow = c(1,2))
dotchart.phylog(phy, dom)
dotchart.phylog(phy, bif, clabel.nodes = 0.7)
par(mfrow = c(1,1))
plot(bif,dom,pch = 20)
abline(lm(dom~bif))
summary(lm(dom~bif))
library(ape)
cor.test(bif,dom)
phylo <- read.tree(text = maples$tre)
pic.bif <- pic(bif, phylo)
pic.dom <- pic(dom, phylo)
cor.test(pic.bif, pic.dom)
}
\keyword{datasets}
