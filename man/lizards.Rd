\name{lizards}
\alias{lizards}
\docType{data}
\title{Phylogeny and quantitative traits of lizards}
\description{
This data set describes the phylogeny of 18 lizards as reported by Bauwens and Díaz-Uriarte (1997). It also gives life-history traits corresponding to these 18 species.
}
\usage{data(lizards)}
\format{
\code{lizards} is a list containing the 3 following objects : 
\describe{    
   \item{traits}{is a data frame with 18 species and 8 traits.}  
   \item{hprA}{is a character string giving the phylogenetic tree (hypothesized phylogenetic relationships based on immunological distances) in Newick format.} 
   \item{hprB}{is a character string giving the phylogenetic tree (hypothesized phylogenetic relationships based on morphological characteristics) in Newick format.}
}}
\details{
Variables of \code{lizards$traits} are the following ones : 
mean.L (mean length (mm)), matur.L (length at maturity (mm)), 
max.L (maximum length (mm)), hatch.L (hatchling length (mm)),
hatch.m (hatchling mass (g)), clutch.S (Clutch size),
age.mat (age at maturity (number of months of activity)),
clutch.F (clutch frequency).
}
\references{
Bauwens, D., and Díaz-Uriarte, R. (1997) Covariation of life-history traits in lacertid lizards: a comparative study. \emph{American Naturalist}, \bold{149}, 91--111.
}
\examples{
data(lizards)
w <- data.frame(scalewt(log(lizards$traits)))
par(mfrow = c(1,2))
wphy <- newick2phylog(lizards$hprA)
table.phylog(w, wphy, csi = 3)
wphy <- newick2phylog(lizards$hprB)
table.phylog(w, wphy, csi = 3)
par(mfrow = c(1,1))
}
\keyword{datasets}
