\name{avimedi}
\alias{avimedi}
\docType{data}
\title{Fauna Table for Constrained Ordinations}
\description{
\code{avimedi} is a list containing the information about 302 sites : \cr
frequencies of 51 bird species ; two factors (habitats and Mediterranean origin). 
}
\usage{data(avimedi)}
\format{
  This list contains the following objects:
  \describe{
    \item{fau}{is a data frame 302 sites - 51 bird species. }
    \item{plan}{is a data frame 302 sites - 2 factors : \code{reg} with two levels Provence (\code{Pr}, 
    South of France) and Corsica (\code{Co}) ;
    \code{str} with six levels describing the vegetation from a very low matorral (1) up to a mature forest of holm oaks (6).}
    \item{nomesp}{is a vector 51 latin names. }
  }
}
\source{
Blondel, J., Chessel, D., & Frochot, B. (1988)
Bird species impoverishment, niche expansion, and density inflation in mediterranean island habitats.
\emph{Ecology}, \bold{69}, 1899--1917.
}
\examples{
\dontrun{
data(avimedi)
coa1 <- dudi.coa(avimedi$fau, scan = FALSE, nf = 3)
bet1 <- bca(coa1, avimedi$plan$str, scan = FALSE)
wit1 <- wca(coa1, avimedi$plan$reg, scan=FALSE)
pcaiv1 <- pcaiv(coa1, avimedi$plan, scan = FALSE)
    
if(adegraphicsLoaded()) {
  g1 <- s.class(coa1$li, avimedi$plan$str:avimedi$plan$reg, 
    psub.text = "Correspondences Analysis", plot = FALSE)
  g2 <- s.class(bet1$ls, avimedi$plan$str, psub.text = "Between Analysis", plot = FALSE)
  g3 <- s.class(wit1$li, avimedi$plan$str, psub.text = "Within Analysis", plot = FALSE)

  g41 <- s.match(pcaiv1$li, pcaiv1$ls, plabels.cex = 0, 
    psub.text = "Canonical Correspondences Analysis", plot = FALSE)
  g42 <- s.class(pcaiv1$li, avimedi$plan$str:avimedi$plan$reg, plot = FALSE)
  g4 <- superpose(g41, g42, plot = FALSE)
  
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))

} else {
  par(mfrow = c(2,2))
  s.class(coa1$li,avimedi$plan$str:avimedi$plan$reg,
      sub = "Correspondences Analysis")
  s.class(bet1$ls, avimedi$plan$str,
      sub = "Between Analysis")
  s.class(wit1$li, avimedi$plan$str,
      sub = "Within Analysis")
  s.match(pcaiv1$li, pcaiv1$ls, clab = 0,
      sub = "Canonical Correspondences Analysis")
  s.class(pcaiv1$li, avimedi$plan$str:avimedi$plan$reg, 
      add.plot = TRUE)
  par(mfrow=c(1,1))
}
}}
\keyword{datasets}
