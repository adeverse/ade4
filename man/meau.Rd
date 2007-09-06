\encoding{latin1}
\name{meau}
\alias{meau}
\docType{data}
\title{Ecological Data : sites-variables, sites-species, where and when}
\description{
This data set contains information about sites, environmental variables
and species (Trichopters). 
}
\usage{data(meau)}
\format{
\code{meau} is a list of 3 components.
\describe{
   \item{mil}{is a data frame with 24 sites and 10 variables.}
   \item{fau}{is a data frame with 24 sites and 13 species (Trichopters).}
   \item{plan}{is a data frame with 24 sites and 2 factors.
            \enumerate{
                \item{dat}{is a factor with 4 levels.}
                \item{sta}{is a factor with 6 levels.}
            }
        }
    }
}
\source{
Pegaz-Maucet, D. (1980)
\emph{Impact d'une perturbation d'origine organique sur la dérive des macro-invertébérés benthiques d'un cours d'eau.
Comparaison avec le benthos}.
Thèse de troisième cycle, Université Lyon 1, 130 p.
}
\examples{
data(meau)
par(mfrow = c(2,2))
pca1 <- dudi.pca(meau$mil, scan = FALSE, nf = 4)
s.class(pca1$li, meau$plan$dat, 
    sub = "Principal Component Analysis")
pca2 <- between(pca1, meau$plan$dat, scan = FALSE, nf = 2)
s.class(pca2$ls, meau$plan$dat, sub = "Between dates Principal Component Analysis")
s.corcircle(pca1$co)
s.corcircle(pca2$as)
}
\keyword{datasets}
