\name{carniherbi49}
\alias{carniherbi49}
\docType{data}
\title{Taxonomy, phylogenies and quantitative traits of carnivora and herbivora}
\description{
This data set describes the taxonomic and phylogenetic relationships of 49 carnivora and herbivora species as reported by Garland and Janis (1993) and Garland et al. (1993). It also gives seven traits corresponding to these 49 species.
}
\usage{data(carniherbi49)}
\format{
\code{carniherbi49} is a list containing the 5 following objects : 
\describe{
   \item{taxo}{is a data frame with 49 species and 2 columns : 'fam', a factor family with 14 levels  
   and 'ord', a factor order with 3 levels.}
   \item{tre1}{is a character string giving the phylogenetic tree in Newick format as reported by Garland et al. (1993).}      
   \item{tre2}{is a character string giving the phylogenetic tree in Newick format as reported by Garland and Janis (1993).}      
   \item{tab1}{is a data frame with 49 species and 2 traits: 'bodymass' (body mass (kg)) and 'homerange' (home range (km)).}  
   \item{tab2}{is a data frame with 49 species and 5 traits: 'clade' (dietary with two levels \code{Carnivore} 
   and \code{Herbivore}), 'runningspeed' (maximal sprint running speed (km/h)), 'bodymass' (body mass (kg)),
   'hindlength' (hind limb length (cm)) and 'mtfratio' (metatarsal/femur ratio).}  
}}
\source{
Garland, T., Dickerman, A. W., Janis, C. M. and Jones, J. A. (1993) Phylogenetic analysis of covariance by computer simulation. 
\emph{Systematics Biology}, \bold{42}, 265--292. 

Garland, T. J. and Janis, C.M. (1993) Does metatarsal-femur ratio predict maximal running speed in cursorial mammals? 
\emph{Journal of Zoology}, \bold{229}, 133--151.
}
\examples{
\dontrun{
data(carniherbi49)
par(mfrow=c(1,3))
plot(newick2phylog(carniherbi49$tre1), clabel.leaves = 0,
 f.phylog = 2, sub ="article 1")
plot(newick2phylog(carniherbi49$tre2), clabel.leaves = 0,
 f.phylog = 2, sub = "article 2")
taxo <- as.taxo(carniherbi49$taxo)
plot(taxo2phylog(taxo), clabel.nodes = 1.2, clabel.leaves = 1.2)
par(mfrow = c(1,1))
}}
\keyword{datasets}
