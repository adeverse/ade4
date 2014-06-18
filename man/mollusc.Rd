\encoding{latin1}
\name{mollusc}
\alias{mollusc}
\docType{data}
\title{Faunistic Communities and Sampling Experiment}
\description{
This data set gives the abundance of 32 mollusk species in 163 samples. 
For each sample, 4 informations are known : the sampling sites, the seasons, 
the sampler types and the time of exposure. 
}
\usage{data(mollusc)}
\format{
    \code{mollusc} is a list of 2 objects.
    \describe{
    \item{fau}{is a data frame with 163 samples and 32 mollusk species (abundance).}
    \item{plan}{contains the 163 samples and 4 variables.}
    }
}
\source{
 Richardot-Coulet, M., Chessel D. and Bournaud M. (1986)
 Typological value of the benthos of old beds of a large river. Methodological approach.
 \emph{Archiv fùr Hydrobiologie}, \bold{107}, 363--383.
}
\examples{
data(mollusc)
coa1 <- dudi.coa(log(mollusc$fau + 1), scannf = FALSE, nf = 3)

if(adegraphicsLoaded()) {
  g1 <- s.class(coa1$li, mollusc$plan$site, ellipseSize = 0, starSize = 0, chullSize = 1, 
    xax = 2, yax = 3, plot = FALSE)
  g2 <- s.class(coa1$li, mollusc$plan$season, ellipseSize = 0, starSize = 0, chullSize = 1, 
    xax = 2, yax = 3, plot = FALSE)
  g3 <- s.class(coa1$li, mollusc$plan$method, ellipseSize = 0, starSize = 0, chullSize = 1, 
    xax = 2, yax = 3, plot = FALSE)
  g4 <- s.class(coa1$li, mollusc$plan$duration, ellipseSize = 0, starSize = 0, chullSize = 1, 
    xax = 2, yax = 3, plot = FALSE)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  
} else {
  par(mfrow = c(2, 2))
  s.chull(coa1$li, mollusc$plan$site, 2, 3, opt = 1, cpoi = 1)
  s.chull(coa1$li, mollusc$plan$season, 2, 3, opt = 1, cpoi = 1)
  s.chull(coa1$li, mollusc$plan$method, 2, 3, opt = 1, cpoi = 1)
  s.chull(coa1$li, mollusc$plan$duration, 2, 3, opt = 1, cpoi = 1)
  par(mfrow = c(1, 1))
}}
\keyword{datasets}
