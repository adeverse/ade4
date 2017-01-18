\name{corvus}
\alias{corvus}
\docType{data}
\title{Corvus morphology}
\description{
This data set gives a morphological description of 28 species of the genus Corvus split in two habitat types and phylogeographic stocks.
}
\usage{data(corvus)}
\format{
\code{corvus} is data frame with 28 observations (the species) and 4 variables : 
\describe{
  \item{wing}{: wing length (mm)}
   \item{bill}{: bill length (mm)}
   \item{habitat}{: habitat with two levels \code{clos} and \code{open}}
   \item{phylog}{: phylogeographic stock with three levels \code{amer}(America), \code{orien}(Oriental-Australian),
     \code{pale}(Paleoarctic-African)}
   }
}
\references{
Laiolo, P. and Rolando, A. (2003) The evolution of vocalisations in the genus Corvus: effects of phylogeny, morphology and habitat. 
\emph{Evolutionary Ecology}, \bold{17}, 111--123.
}
\examples{
data(corvus)

if(adegraphicsLoaded()) {
  g1 <- s.label(corvus[, 1:2], plab.cex = 0, porigin.include = FALSE, pgrid.draw = FALSE, 
    paxes.draw = TRUE, paxes.asp = "full", xlab = names(corvus)[2], 
    ylab = names(corvus)[2], plot = FALSE)
  g2 <- s.class(corvus[, 1:2], corvus[, 4]:corvus[, 3], plot = FALSE)
  G <- superpose(g1, g2, plot = TRUE)

} else {
  plot(corvus[, 1:2])
  s.class(corvus[, 1:2], corvus[, 4]:corvus[, 3], add.p = TRUE)
}
}
\keyword{datasets}
