\name{perthi02}
\alias{perthi02}
\docType{data}
\title{Contingency Table with a partition in Molecular Biology}
\description{
This data set gives the amino acids of 904 proteins 
distributed in three classes. 
}
\usage{data(perthi02)}
\format{
    \code{perthi02} is a list of 2 components.
    \enumerate{
    \item{tab}{is a data frame 904 rows (proteins of 201 species) 20 columns (amino acids).}
    \item{cla}{is a factor of 3 classes of protein}
    }
    The levels of \code{perthi02$cla} are \code{cyto} (cytoplasmic proteins) \code{memb} (integral membran proteins) \code{peri} (periplasmic proteins)
}
\source{
Perriere, G. and Thioulouse, J. (2002)\cr
Use of Correspondence Discriminant Analysis to predict the subcellular location of bacterial proteins.\cr
\emph{Computer Methods and Programs in Biomedicine}, \bold{70}, 2, 99--105.
}
\examples{
data(perthi02)
plot(discrimin.coa(perthi02$tab, perthi02$cla, scan = FALSE))
}
\keyword{datasets}
