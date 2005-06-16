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
\details{
The rows of \code{doubs$mil}, \code{doubs$poi} and \code{doubs$xy} are 30 sites along the Doubs, a French and Switzerland river.

\code{doubs$mil} contains the following variables:
das - distance to the source (km * 10), 
alt - altitude (m), 
pen (\eqn{\ln(x + 1)}{log(x + 1)} where \emph{x} is the slope (per mil * 100), 
deb - minimum average debit (m3/s * 100), 
pH (* 10), 
dur - total hardness of water (mg/l of Calcium), 
 pho - phosphates (mg/l * 100), 
 nit - nitrates (mg/l * 100), 
amm - ammonia nitrogen (mg/l * 100), 
oxy - dissolved oxygen (mg/l * 10), 
dbo - biological demand for oxygen (mg/l * 10).

\code{doubs$poi} contains the abundance of the following fish species: \emph{Cottus gobio} (CHA), \emph{Salmo trutta fario} (TRU), 
\emph{Phoxinus phoxinus} (VAI), \emph{Nemacheilus barbatulus} (LOC), \emph{Thymallus thymallus} (OMB), \emph{Telestes soufia agassizi} (BLA), 
\emph{Chondrostoma nasus} (HOT), \emph{Chondostroma toxostoma} (TOX), \emph{Leuciscus leuciscus} (VAN), \emph{Leuciscus cephalus cephalus} (CHE), 
\emph{Barbus barbus} (BAR), \emph{Spirlinus bipunctatus} (SPI), \emph{Gobio gobio} (GOU), \emph{Esox lucius} (BRO), 
\emph{Perca fluviatilis} (PER), \emph{Rhodeus amarus} (BOU), \emph{Lepomis gibbosus} (PSO), \emph{Scardinius erythrophtalmus} (ROT), 
\emph{Cyprinus carpio} (CAR), \emph{Tinca tinca} (TAN), \emph{Abramis brama} (BCO), \emph{Ictalurus melas} (PCH), 
\emph{Acerina cernua} (GRE), \emph{Rutilus rutilus} (GAR), \emph{Blicca bjoerkna} (BBO), \emph{Alburnus alburnus} (ABL), 
\emph{Anguilla anguilla} (ANG). 
}
\source{
 Verneaux, J. (1973) 
 \emph{Cours d'eau de Franche-Comté (Massif du Jura). 
 Recherches écologiques sur le réseau hydrographique du Doubs. Essai de biotypologie}. 
 Thèse d'état, Besançon. 1--257.
}
\references{
See a French description of fish species at \url{http://pbil.univ-lyon1.fr/R/articles/arti049.pdf}.\cr
Chesse, D., Lebreton, J.D. and Yoccoz, N.G. (1987) Propriétés de l'analyse canonique des correspondances. Une illustration
en hydrobiologie. \emph{Revue de Statistique Appliquée}, \bold{35}, 4, 55--72.
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
