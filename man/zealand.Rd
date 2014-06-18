\name{zealand}
\alias{zealand}
\docType{data}
\title{Road distances in New-Zealand}
\description{
  This data set gives the road distances between 13 towns
  in New-Zealand.
}
\usage{data(zealand)}
\format{
    \code{zealand} is a list of 3 components:
\describe{
    \item{road}{is a data frame with 13 rows (New Zealand towns) and 13 columns (New Zealand towns)
    containing the road distances between these towns.}
    \item{xy}{is a data frame containing the coordinates of the 13 towns. }
    \item{neig}{is a object of class 'neig', a neighbour graph to visualize the map shape.}
}}
\source{
 Manly, B.F. (1994) \emph{ Multivariate Statistical Methods. A primer.}, Second edition, Chapman and Hall, London, 1--215, page 172.
}
\examples{
data(zealand)
d0 <- as.dist(as.matrix(zealand$road))
d1 <- cailliez (d0)
d2 <- lingoes(d0)

if(adegraphicsLoaded()) {
  G1 <- s.label(zealand$xy, lab = as.character(1:13), nb = zealand$nb)
  
  g1 <- s.label(cmdscale(dist(zealand$xy)), lab = as.character(1:13), nb = zealand$nb, 
    psub.text = "Distance canonique", plot = F)
  g2 <- s.label(cmdscale(d0), lab = as.character(1:13), nb = zealand$nb, 
    psub.text = "Distance routiere", plot = F)
  g3 <- s.label(cmdscale(d1), lab = as.character(1:13), nb = zealand$nb, 
    psub.text = "Distance routiere / Cailliez", plot = F)
  g4 <- s.label(cmdscale(d2), lab = as.character(1:13), nb = zealand$nb, 
    psub.text = "Distance routiere / Lingoes", plot = F)
  G2 <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))

} else {
  s.label(zealand$xy, lab = as.character(1:13), neig = zealand$neig)
  par(mfrow = c(2, 2))
  s.label(cmdscale(dist(zealand$xy)), lab = as.character(1:13), 
    neig = zealand$neig, sub = "Distance canonique", csub = 2)
  s.label(cmdscale(d0), lab = as.character(1:13), neig = zealand$neig, 
    sub = "Distance routiere", csub = 2)
  s.label(cmdscale(d1), lab = as.character(1:13), neig = zealand$neig, 
    sub = "Distance routiere / Cailliez", csub = 2)
  s.label(cmdscale(d2), lab = as.character(1:13), neig = zealand$neig, 
    sub = "Distance routiere / Lingoes", csub = 2)
}}
\keyword{datasets}
