\name{meaudret}
\alias{meaudret}
\non_function{}
\title{Ecological Data : sites-variables, sites-species, where and when}
\description{
This data set contains informations about sites, environmental variables
and species (Trichopters). 
}
\usage{data(meaudret)}
\format{
	\code{meaudret} is a list of 4 components.
	\enumerate{
		\item{mil}{is a data frame with 24 sites and 9 variables.}
		\item{fau}{is a data frame with 24 sites and 10 species (Trichopters).}
		\item{date}{is a factor with 4 levels.}
		\item{site}{is a factor with 6 levels.}
	}
}
\source{
Pegaz-Maucet, D. (1980)\cr
Impact d'une perturbation d'origine organique sur la dérive des macro-invertébérés benthiques d'un cours d'eau.\cr
Comparaison avec le benthos.\cr
Th"se de 3° cycle, Université Lyon 1, 130 p.
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
par(mfrow = c(1,1))
}
\keyword{datasets}
