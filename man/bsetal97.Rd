\name{bsetal97}
\alias{bsetal97}
\docType{data}
\title{Ecological and Biological Traits}
\description{
This data set gives ecological and biological characteristics of 131 species of aquatic insects. 
}
\usage{data(bsetal97)}
\format{
'bsetal97' is a list of 8 components.\cr
    \describe{
    \item{species.names}{is a vector of the species names.}
    \item{taxo}{is a data frame containing the taxonomy of species. }
    \item{biol}{is a data frame containing the biological traits. }
    \item{biol.blo}{is a vector of the numbers of items for each biological trait. }
    \item{biol.blo.names}{is a vector of the names of the biological traits. }
    \item{ecol}{is a data frame with the ecological traits. }
    \item{ecol.blo}{is a vector of the numbers of items for each ecological trait. }
    \item{ecol.blo.names}{is a vector of the names of the ecological traits. }
    }
}
\source{
 Statzner, B., Hoppenhaus, K., Arens, M.-F. and Richoux, P. (1997) 
 Reproductive traits, habitat use and templet theory: a synthesis of world-wide data on aquatic insects.
 \emph{Freshwater Biology}, \bold{38}, 109--135.
}
\examples{
data(bsetal97)
X <- prep.fuzzy.var(bsetal97$biol, bsetal97$biol.blo)
Y <- prep.fuzzy.var(bsetal97$ecol, bsetal97$ecol.blo)
plot(coinertia(dudi.fca(X, scan = FALSE), 
    dudi.fca(Y, scan = FALSE), scan = FALSE))
}
\keyword{datasets}
