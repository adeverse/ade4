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
        \item{env}{is a data frame with 20 sites and 9 variables.}
        \item{spe}{is a data frame with 20 sites and 13 Ephemeroptera Species.}
        \item{design}{is a data frame with 20 sites and 2 factors.
            \itemize{
                \item \code{season} is a factor with 4 levels = seasons.
                \item \code{site} is a factor with 5 levels = sites along the Meaudret river.
            }
        }
       \item{spe.names}{is a character vector containing the names of the 13 species.}
    }
}
\details{Data set equivalents to \code{\link{meau}}: site (6) on the Bourne (a Meaudret affluent) and
oxygen concentration were removed.
}
\source{
Pegaz-Maucet, D. (1980) 
\emph{Impact d'une perturbation d'origine organique sur la dérive des macro-invertébrés benthiques d'un cours d'eau.
Comparaison avec le benthos.}
Thèse de 3ème cycle, Université Lyon 1, 130 p.

Thioulouse, J., Simier, M. and Chessel, D. (2004) Simultaneous analysis of a sequence of paired ecological
tables. \emph{Ecology}, \bold{85}, 1, 272--283.
}
\examples{
data(meaudret)
pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 4)
pca2 <- bca(pca1, meaudret$design$season, scan = FALSE, nf = 2)
  
if(adegraphicsLoaded()) {
  g1 <- s.class(pca1$li, meaudret$design$season, 
    psub.text = "Principal Component Analysis", plot = FALSE)
  g2 <- s.class(pca2$ls, meaudret$design$season, 
    psub.text = "Between dates Principal Component Analysis", plot = FALSE)
  g3 <- s.corcircle(pca1$co, plot = FALSE)
  g4 <- s.corcircle(pca2$as, plot = FALSE)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))

} else {
  par(mfrow = c(2, 2))
  s.class(pca1$li, meaudret$design$season, sub = "Principal Component Analysis")
  s.class(pca2$ls, meaudret$design$season, sub = "Between dates Principal Component Analysis")
  s.corcircle(pca1$co)
  s.corcircle(pca2$as)
  par(mfrow = c(1, 1))
}}
\keyword{datasets}
