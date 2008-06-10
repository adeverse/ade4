\name{tithonia}
\alias{tithonia}
\docType{data}
\title{Phylogeny and quantitative traits of flowers}
\description{
This data set describes the phylogeny of 11 flowers as reported by Morales (2000). It also gives morphologic and demographic traits corresponding to these 11 species.
}
\usage{data(tithonia)}
\format{
\code{tithonia} is a list containing the 2 following objects :
\describe{  
   \item{tre}{is a character string giving the phylogenetic tree in Newick format.} 
   \item{tab}{is a data frame with 11 species and 14 traits (6 morphologic traits and 8 demographic).}    
}}
\details{      
Variables of \code{tithonia$tab} are the following ones : \cr
morho1: is a numeric vector that describes the seed size (mm)\cr
morho2: is a numeric vector that describes the flower size (mm)\cr
morho3: is a numeric vector that describes the female leaf size (cm)\cr
morho4: is a numeric vector that describes the head size (mm)\cr
morho5: is a integer vector that describes the number of flowers per head \cr
morho6: is a integer vector that describes the number of seeds per head \cr
demo7: is a numeric vector that describes the seedling height (cm)\cr
demo8: is a numeric vector that describes the growth rate (cm/day)\cr
demo9: is a numeric vector that describes the germination time\cr
demo10: is a numeric vector that describes the establishment (per cent)\cr
demo11: is a numeric vector that describes the viability (per cent)\cr
demo12: is a numeric vector that describes the germination (per cent)\cr
demo13: is a integer vector that describes the resource allocation\cr
demo14: is a numeric vector that describes the adult height (m)\cr
}
\source{
Data were obtained from Morales, E. (2000) Estimating phylogenetic inertia in Tithonia (Asteraceae) : 
a comparative approach. \emph{Evolution}, \bold{54}, 2, 475--484.
}
\examples{
data(tithonia)
phy <- newick2phylog(tithonia$tre)
tab <- log(tithonia$tab + 1)
table.phylog(scalewt(tab), phy)
gearymoran(phy$Wmat, tab)
gearymoran(phy$Amat, tab)
}
\keyword{datasets}
