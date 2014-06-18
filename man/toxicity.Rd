\name{toxicity}
\alias{toxicity}
\docType{data}
\title{Homogeneous Table}
\description{
This data set gives the toxicity of 7 molecules on 17 targets
  expressed in -log(mol/liter)
}
\usage{data(toxicity)}
\format{
\code{toxicity} is a list of 3 components.
    \describe{
        \item{tab}{is a data frame with 7 columns and 17 rows}
        \item{species}{is a vector of the names of the species in the 17 targets}
        \item{chemicals}{is a vector of the names of the 7 molecules}
    }
}
\source{
Devillers, J., Thioulouse, J. and Karcher W. (1993)
Chemometrical Evaluation of Multispecies-Multichemical Data by Means 
of Graphical Techniques Combined with Multivariate Analyses.
\emph{Ecotoxicology and Environnemental Safety}, \bold{26}, 333--345.
}
\examples{
data(toxicity)
if(adegraphicsLoaded()) {
  table.image(toxicity$tab, labelsy = toxicity$species, labelsx = toxicity$chemicals, nclass = 7, 
    ptable.x.cst = c(25, 5), ptable.y.cst = c(26, 5), pgrid.draw = TRUE)
  table.value(toxicity$tab, labelsy = toxicity$species, labelsx = toxicity$chemicals, 
    ptable.x.cst = c(25, 5), ptable.y.cst = c(26, 5))
} else {
  table.paint(toxicity$tab, row.lab = toxicity$species, col.lab = toxicity$chemicals)
  table.value(toxicity$tab, row.lab = toxicity$species, col.lab = toxicity$chemicals)
}}
\keyword{datasets}
