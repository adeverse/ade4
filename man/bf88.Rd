\name{bf88}
\alias{bf88}
\docType{data}
\title{Cubic Ecological Data}
\description{
\code{bf88} is a list of 6 data frames corresponding to 6 stages of vegetation. \cr
Each data frame gives some bird species informations for 4 counties. 
}
\usage{data(bf88)}
\format{
A list of six data frames with 79 rows (bird species) and 4 columns (counties).\cr
The 6 arrays (S1 to S6) are the 6 stages of vegetation.\cr
The attribut 'nomesp' of this list is a vector of species French names. 
}
\source{
Blondel, J. and Farre, H. (1988) 
The convergent trajectories of bird communities along ecological successions in european forests. 
\emph{Oecologia} (Berlin), \bold{75}, 83--93.
}
\examples{
data(bf88)
fou1 <- foucart(bf88, scann = FALSE, nf = 3)
fou1

if(adegraphicsLoaded()) {
  g1 <- scatter(fou1, plot = FALSE)
  g2 <- s.traject(fou1$Tco, fou1$TC[, 1], plines.lty = 1:length(levels(fou1$TC[, 1])), plot = FALSE)
  g3 <- s.traject(fou1$Tco, fou1$TC[, 2], plines.lty = 1:length(levels(fou1$TC[, 2])), plot = FALSE)
  g41 <- s.label(fou1$Tco, plot = FALSE)
  g42 <- s.label(fou1$co, plab.cex = 2, plot = FALSE)
  g4 <- superpose(g41, g42, plot = FALSE)
  G1 <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  
  G2 <- kplot(fou1, row.plab.cex = 0, psub.cex = 2)

} else {
  par(mfrow = c(2,2))
  scatter(fou1)
  s.traject(fou1$Tco, fou1$TC[, 1])
  s.traject(fou1$Tco, fou1$TC[, 2])
  s.label(fou1$Tco)
  s.label(fou1$co, add.p = TRUE, clab = 2)
  par(mfrow = c(1, 1))
  kplot(fou1, clab.c = 2, clab.r = 0, csub = 3)
}}
\keyword{datasets}
