\encoding{latin1}
\name{meaudret}
\alias{meaudret}
\docType{data}
\title{Ecological Data : sites-variables, sites-species, where and when}
\description{
This data set contains information about sites, environmental variables
and Ephemeroptera Species. 
}
\usage{data(meaudret)}
\format{
    \code{meaudret} is a list of 4 components.
\describe{
        \item{mil}{is a data frame with 20 sites and 9 variables.}
        \item{fau}{is a data frame with 20 sites and 13 Ephemeroptera Species.}
        \item{plan}{is a data frame with 20 sites and 2 factors.
            \itemize{
                \item \code{dat} is a factor with 4 levels-seasons.
                \item \code{sta} is a factor with 5 levels-sites along the Meaudret river.
            }
        }
       \item{fau.names}{is a character vector containing the names of the 13 species.}
    }
}
\details{Data set equivalents to \code{\link{meau}}: the site (6) along the Bourne, a Meaudret affluent, was removed ; 
the oxygen concentration were removed from the physico-chemical data frame.
}
\source{
Pegaz-Maucet, D. (1980) 
\emph{Impact d'une perturbation d'origine organique sur la dérive des macro-invertébérés benthiques d'un cours d'eau.
Comparaison avec le benthos.}
Thèse de troisième cycle, Université Lyon 1, 130 p.

Thioulouse, J., Simier, M. and Chessel, D. (2004) Simultaneous analysis of a sequence of paired ecological
tables. \emph{Ecology}, \bold{85}, 1, 272--283.
}
\examples{
data(meaudret)
par(mfrow = c(2,2))
pca1 <- dudi.pca(meaudret$mil, scan = FALSE, nf = 4)
s.class(pca1$li, meaudret$plan$dat, 
    sub = "Principal Component Analysis")
pca2 <- between(pca1, meaudret$plan$dat, scan = FALSE, nf = 2)
s.class(pca2$ls, meaudret$plan$dat, sub = "Between dates Principal Component Analysis")
s.corcircle(pca1$co)
s.corcircle(pca2$as)
}
\keyword{datasets}
