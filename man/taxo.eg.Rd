\name{taxo.eg}
\alias{taxo.eg}
\docType{data}
\title{Examples of taxonomy}
\description{
This data sets contains two taxonomies.
}
\usage{data(taxo.eg)}
\format{
\code{taxo.eg} is a list containing the 2 following objects: 
\describe{     
        \item{taxo.eg[[1]]}{is a data frame with 15 species and 3 columns.} 
        \item{taxo.eg[[2]]}{is a data frame with 40 species and 2 columns.}
 }}
 \details{       
 Variables of the first data frame are : genre (a factor genre with 8 levels), 
 famille (a factor familiy with 5 levels) and ordre (a factor order with 2 levels).\cr
        
Variables of the second data frame are : gen(a factor genre with 29 levels), 
fam (a factor family with 19 levels).
}
\source{
Dol�dec, S., Chessel, D., Ter Braak,C. J. F.  and Champely S. (1996) 
Matching species traits to environmental variables: a new three-table ordination method. 
\emph{Environmental and Ecological Statistics}, \bold{3}, 143--166.
}
\examples{
data(taxo.eg)
taxo.eg[[1]]
as.taxo(taxo.eg[[1]])
class(taxo.eg[[1]])
class(as.taxo(taxo.eg[[1]]))

tax.phy <- taxo2phylog(as.taxo(taxo.eg[[1]]))
plot.phylog(tax.phy,clabel.l=1)

par(mfrow = c(1,2))
table.phylog(tax.phy$Bindica,tax.phy)
table.phylog(tax.phy$Bscores,tax.phy)
par(mfrow = c(1,1))

radial.phylog(taxo2phylog(as.taxo(taxo.eg[[2]])))
}
\keyword{datasets}