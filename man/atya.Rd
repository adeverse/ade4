\name{atya}
\alias{atya}
\docType{data}
\title{Genetic variability of Cacadors}
\description{
This data set contains informations about genetic variability of \emph{Atya innocous} and \emph{Atya scabra} in Guadeloupe (France).
}
\usage{data(atya)}
\format{
\code{atya} is a list with the following elements : 
        \item{xy}{: a data frame with the coordinates of the 31 sites}
        \item{gen}{: a data frame with 22 variables collected on 31 sites}
        \item{neig}{: an object of class \code{'neig'}}   
}
\source{
Fievet, E., Eppe, F. and Dolédec, S. (2001) Etude de la variabilité morphométrique et génétique des populations de Cacadors (\emph{Atya innocous} et \emph{Atya scabra}) de l'île de Basse-Terre. Direction Régionale de L'Environnement Guadeloupe, Laboratoire des hydrosystèmes fluviaux, Université Lyon 1.
}
\examples{
data(atya)
if (require(pixmap, quiet = TRUE)) {
    atya.digi <- read.pnm(system.file("pictures/atyadigi.pnm",
        package = "ade4"))
    atya.carto <- read.pnm(system.file("pictures/atyacarto.pnm",
        package = "ade4"))
    par(mfrow = c(1,2))
    plot(atya.digi)
    plot(atya.carto)
    points(atya$xy, pch = 20, cex = 2)
}
if (require(maptools, quiet = TRUE) & require(spdep, quiet = TRUE)) {
    plot(neig2nb(atya$neig), atya$xy, col = "red", add = TRUE, lwd = 2)
    par(mfrow = c(1,1))
}
}
\keyword{datasets}
