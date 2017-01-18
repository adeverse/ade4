\name{t3012}
\alias{t3012}
\docType{data}
\title{Average temperatures of 30 French cities}
\description{
  This data set gives the average temperatures of 30 French cities during 12 months.
}
\usage{data(t3012)}
\format{
    \code{t3012} is a list of 3 objects:
\describe{
    \item{xy}{is a data frame with 30 rows (cities) and 2 coordinates (x,y).}
    \item{temp}{is a data frame with 30 rows (cities) and 12 columns (months). Each column contains the average temperature in tenth of degree Celsius. }
    \item{contour}{is a data frame with 4 columns (x1,y1,x2,y2) for the contour display of France.}
}}
\source{
Besse, P. (1979)
\emph{Etude descriptive d'un processus; approximation, interpolation}.
 Thèse de troisième cycle, Université Paul Sabatier, Toulouse.
}
\examples{
data(t3012)
data(elec88)

if(adegraphicsLoaded()) {
  if(requireNamespace("sp", quietly = TRUE)) {
    s.arrow(t3012$xy, pori.ori = as.numeric(t3012$xy["Paris", ]), Sp = t3012$Spatial, 
      pSp.col = "white", pgrid.draw = FALSE)
  }
} else {
  area.plot(elec88$area)
  s.arrow(t3012$xy, ori = as.numeric(t3012$xy["Paris", ]), add.p = TRUE)
}}
\keyword{datasets}
