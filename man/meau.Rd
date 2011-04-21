\encoding{latin1}
\name{meau}
\alias{meau}
\docType{data}
\title{Ecological Data : sites-variables, sites-species, where and when}
\description{
This data set contains information about sites, environmental variables
and Ephemeroptera Species. 
}
\usage{data(meau)}
\format{
\code{meau} is a list of 3 components.
\describe{
   \item{env}{is a data frame with 24 sites and 10 physicochemical variables.}
   \item{fau}{is a data frame with 24 sites and 13 Ephemeroptera Species.}
   \item{design}{is a data frame with 24 sites and 2 factors.
            \itemize{
                \item \code{season}: is a factor with 4 levels = seasons.
                \item \code{site}: is a factor with 6 levels = sites.
            }
        }
    }
}
\details{Data set equivalents to \code{\link{meaudret}}, except that one site (6) along the Bourne (a Meaudret affluent) and
one physico chemical variable - the oxygen concentration were added.
}
\source{
Pegaz-Maucet, D. (1980)
\emph{Impact d'une perturbation d'origine organique sur la dérive des macro-invertébrés benthiques d'un cours d'eau.
Comparaison avec le benthos}.
Thèse de troisième cycle, Université Lyon 1, 130 p.

Thioulouse, J., Simier, M. and Chessel, D. (2004) Simultaneous analysis of a sequence of paired ecological
tables. \emph{Ecology}, \bold{85}, 1, 272--283.
}
\examples{
data(meau)
par(mfrow = c(2,2))
pca1 <- dudi.pca(meau$env, scan = FALSE, nf = 4)
s.class(pca1$li, meau$design$season, 
    sub = "Principal Component Analysis")
pca2 <- between(pca1, meau$design$season, scan = FALSE, nf = 2)
s.class(pca2$ls, meau$design$season, sub = "Between seasons Principal Component Analysis")
s.corcircle(pca1$co)
s.corcircle(pca2$as)
}
\keyword{datasets}
