\name{doubs}
\alias{doubs}
\docType{data}
\title{Pair of Ecological Tables}
\description{
This data set gives environmental variables, fish species and spatial coordinates for 30 sites. 
}
\usage{data(doubs)}
\format{
    \code{doubs} is a list with 3 components.
    \describe{
        \item{mil}{is a data frame with 30 rows (sites) and 11 environmental variables.}
        \item{poi}{is a data frame with 30 rows (sites) and 27 fish species.}
        \item{xy}{is a data frame with 30 rows (sites)  and 2 spatial coordinates.}
    }
}
\source{
 Verneaux, J. (1973) 
 \emph{Cours d'eau de Franche-Comté (Massif du Jura). 
 Recherches écologiques sur le réseau hydrographique du Doubs. Essai de biotypologie}. 
 Thèse d'état, Besançon. 1--257.
}
\examples{
data(doubs)
pca1 <- dudi.pca(doubs$mil, scan = FALSE)
pca2 <- dudi.pca(doubs$poi, scale = FALSE, scan = FALSE)
coiner1 <- coinertia(pca1, pca2, scan = FALSE)
par(mfrow = c(3,3))
s.corcircle(coiner1$aX)
s.value(doubs$xy, coiner1$lX[,1])
s.value(doubs$xy, coiner1$lX[,2])
s.arrow(coiner1$c1)
s.match(coiner1$mX, coiner1$mY)
s.corcircle(coiner1$aY)
s.arrow(coiner1$l1)
s.value(doubs$xy, coiner1$lY[,1])
s.value(doubs$xy, coiner1$lY[,2])
par(mfrow = c(1,1))
}
\keyword{datasets}
