\name{carni19}
\alias{carni19}
\docType{data}
\title{Phylogeny and quantative trait of carnivora}
\description{
This data set describes the phylogeny of carnivora as reported by Diniz-Filho et al. (1998). It also gives the body mass of these 19 species.
}
\usage{data(carni19)}
\format{
\code{carni19} is a list containing the 2 following objects : \cr 
        \enumerate{     
            \item{tre}{is a character string giving the phylogenetic tree in Newick format.} 
            \item{bm}{is a numeric vector which values correspond to the body mass of the 19 species (log scale).}
        } 
}
\references{
Diniz-Filho, J. A. F., de Sant'Ana, C.E.R. and Bini, L.M. (1998) An eigenvector method for estimating phylogenetic inertia. \emph{Evolution}, \bold{52}, 1247--1262.
}
\examples{
data(carni19)
carni19.phy <- newick2phylog(carni19$tre)
par(mfrow = c(1,2))
symbols.phylog(carni19.phy,carni19$bm-mean(carni19$bm))
dotchart.phylog(carni19.phy, carni19$bm, clabel.l=0.75)
par(mfrow = c(1,1))
}
\keyword{datasets}
