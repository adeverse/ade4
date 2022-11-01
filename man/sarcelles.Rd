\name{sarcelles}
\alias{sarcelles}
\docType{data}

\title{Array of Recapture of Rings}

\description{
  The data frame \code{sarcelles$tab} contains the number of the winter teals 
  (\emph{Anas C. Crecca}) for which the ring was retrieved in the area \emph{i} 
  during the month \emph{j} (\emph{n}=3049).
}

\usage{data(sarcelles)}

\format{\code{sarcelles} is a list with the following components:
  \describe{
    \item{tab}{a data frame with 14 rows-areas and 12 columns-months}
    \item{xy}{a data frame with the 2 spatial coordinates of the 14 region centers}
    \item{neig}{the neighbouring graph between areas, object of the class \code{neig}}
    \item{col.names}{a vector containing the month items}
    \item{nb}{a neighborhood object (class \code{nb} defined in package \code{spdep})}
}}

\source{
 Lebreton, J.D. (1973). Etude des déplacements saisonniers des Sarcelles d'hiver, 
 Anas c. crecca L., hivernant en Camargue à l'aide de l'analyse factorielle des 
 correspondances. \emph{Compte rendu hebdomadaire des séances de l'Académie des 
 sciences}, Paris, D, III, \bold{277}, 2417--2420.
}

\examples{
\dontrun{
if(!adegraphicsLoaded()) {
  # depends of pixmap
  if(requireNamespace("pixmap", quietly = TRUE)) {
    bkgnd.pnm <- pixmap::read.pnm(system.file("pictures/sarcelles.pnm", package = "ade4"))
    data(sarcelles)
    par(mfrow = c(4, 3))
    for(i in 1:12) {
      s.distri(sarcelles$xy, sarcelles$tab[, i], pixmap = bkgnd.pnm, 
       sub = sarcelles$col.names[i], clab = 0, csub = 2)
      s.value(sarcelles$xy, sarcelles$tab[, i], add.plot = TRUE, cleg = 0)
    }
    par(mfrow = c(1, 1))
  }
}}}

\keyword{datasets}
