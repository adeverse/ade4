\name{macaca}
\alias{macaca}
\docType{data}
\title{Landmarks}
\description{
This data set gives the landmarks of a macaca at the ages of 0.9 and 5.77 years. 
}
\usage{data(macaca)}
\format{
    \code{macaca} is a list of 2 components.
    \describe{
    \item{xy1}{is a data frame with 72 points and 2 coordinates.}
    \item{xy2}{is a data frame with 72 points and 2 coordinates.}
    }
}
\source{
Olshan, A.F., Siegel, A.F. and Swindler, D.R. (1982)
Robust and least-squares orthogonal mapping: Methods for the study of cephalofacial form and growth.
\emph{American Journal of Physical Anthropology}, \bold{59}, 131--137.
}
\examples{
data(macaca)
pro1 <- procuste(macaca$xy1, macaca$xy2, scal = FALSE)
pro2 <- procuste(macaca$xy1, macaca$xy2)
  
if(adegraphicsLoaded()) {
  g1 <- s.match(macaca$xy1, macaca$xy2, plab.cex = 0, plot = FALSE)
  g2 <- s.match(pro1$tabX, pro1$rotY, plab.cex = 0.7, plot = FALSE)
  g3 <- s.match(pro1$tabY, pro1$rotX, plab.cex = 0.7, plot = FALSE)
  g4 <- s.match(pro2$tabY, pro2$rotX, plab.cex = 0.7, plot = FALSE)
  G <- ADEgS(c(g1, g2, g3, g4), layout = c(2, 2))

} else {
  par(mfrow = c(2,2))
  s.match(macaca$xy1, macaca$xy2, clab = 0)
  s.match(pro1$tabX, pro1$rotY, clab = 0.7)
  s.match(pro1$tabY, pro1$rotX, clab = 0.7)
  s.match(pro2$tabY, pro2$rotX, clab = 0.7)
  par(mfrow = c(1,1))
}}
\keyword{datasets}
