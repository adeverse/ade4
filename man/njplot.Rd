\name{njplot}
\alias{njplot}
\docType{data}
\title{Phylogeny and trait of bacteria}
\description{
This data set describes the phylogenety of 36 bacteria as reported by Perrière and Gouy (1996). It also gives the GC rate corresponding to these 36 species.
}
\usage{data(njplot)}
\format{
\code{njplot} is a list containing the 2 following objects: \cr 
   \item{tre}{is a character string giving the fission tree in Newick format.} 
   \item{tauxcg}{is a numeric vector that gives the CG rate of the 36 species.}    
}
\source{
Data were obtained by Manolo Gouy \email{mgouy@biomserv.univ-lyon1.fr}
}
\references{
Perrière, G. and Gouy, M. (1996) WWW-Query : an on-line retrieval system for biological sequence banks. \emph{Biochimie}, \bold{78}, 364--369.
}
\examples{
data(njplot)
njplot.phy <- newick2phylog(njplot$tre)
par(mfrow = c(2,1))
tauxcg0 <- njplot$tauxcg - mean(njplot$tauxcg)
symbols.phylog(njplot.phy, squares = tauxcg0)
symbols.phylog(njplot.phy, circles = tauxcg0)
par(mfrow = c(1,1))
}
\keyword{datasets}
