\name{pap}
\alias{pap}
\docType{data}
\title{Taxonomy and quantitative traits of carnivora}
\description{
This data set describes the taxonomy of 39 carnivora. It also gives life-history traits corresponding to these 39 species.
}
\usage{data(pap)}
\format{
\code{pap} is a list containing the 2 following objects : 
\describe{ 
   \item{taxo}{is a data frame with 39 species and 3 columns.} 
   \item{tab}{is a data frame with 39 species and 4 traits.}    
 }}
\details{       
Variables of \code{pap$tab} are the following ones : genre (genus with 30 levels),
famille (family with 6 levels), superfamille (superfamily with 2 levels).\cr

Variables of \code{pap$tab} are Group Size, Body Weight, Brain Weight, Litter Size.
}
\source{
Data taken from the phylogenetic autocorrelation package starting from:\cr
 \url{http://www.ent.orst.edu/pa/demopa.asp}.
}
\examples{
data(pap)
taxo <- taxo2phylog(as.taxo(pap$taxo))
table.phylog(scalewt(pap$tab), taxo, csi = 2, clabel.nod = 0.6,
 f.phylog = 0.6)
}
\keyword{datasets}
