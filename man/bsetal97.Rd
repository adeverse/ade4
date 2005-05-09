\name{bsetal97}
\alias{bsetal97}
\docType{data}
\title{Ecological and Biological Traits}
\description{
This data set gives ecological and biological characteristics of 131 species of aquatic insects. 
}
\usage{data(bsetal97)}
\format{
\code{bsetal97} is a list of 8 components.\cr
    \describe{
    \item{species.names}{is a vector of the names of aquatic insects.}
    \item{taxo}{is a data frame containing the taxonomy of species: genus, family and order. }
    \item{biol}{is a data frame containing 10 biological traits for a total of 41 modalities. }
    \item{biol.blo}{is a vector of the numbers of items for each biological trait. }
    \item{biol.blo.names}{is a vector of the names of the biological traits. }
    \item{ecol}{is a data frame with 7 ecological traits for a total of 34 modalities. }
    \item{ecol.blo}{is a vector of the numbers of items for each ecological trait. }
    \item{ecol.blo.names}{is a vector of the names of the ecological traits. }
    }
}
\details{
The 10 variables of the data frame \code{bsetal97$biol} are called in \code{bsetal97$biol.blo.names} 
and the number of modalities per variable given in \code{bsetal97$biol.blo}. The variables are the female size,
the egg length, the egg number, the generation per year, the oviposition period, the incubation time,
the egg shape, the egg attachment, the clutch structure and the clutch number. \cr
The 7 variables of the data frame \code{bsetal97$ecol} are called in \code{bsetal97$ecol.blo.names} 
and the number of modalities per variable given in \code{bsetal97$ecol.blo}. The variables are the oviposition site,
the substratum type for eggs, the egg deposition, the gross habitat, the saturation variance, the time of day
and the season.
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
