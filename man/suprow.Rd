\name{suprow}
\alias{suprow}
\alias{suprow.coa}
\alias{suprow.pca}
\alias{suprow.dudi}
\alias{predict.dudi}
\alias{suprow.acm}
\alias{suprow.mix}
\title{Projections of Supplementary Rows}
\description{
This function performs a projection of supplementary rows (i.e. supplementary individuals). 
}
\usage{ 
\method{suprow}{coa}(x, Xsup, \dots) 
\method{suprow}{dudi}(x, Xsup, \dots) 
\method{predict}{dudi}(object, newdata, \dots) 
\method{suprow}{pca}(x, Xsup, \dots)
\method{suprow}{acm}(x, Xsup, \dots) 
\method{suprow}{mix}(x, Xsup, \dots) 
}
\arguments{
  \item{x, object}{an object of class \code{dudi}}
  \item{Xsup, newdata}{an array with the supplementary rows}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
If \code{suprow.dudi} is used, the column vectors of Xsup are projected without prior modifications onto the principal components of dudi with the scalar product associated to the row weightings of dudi.
}
\value{
\code{predict} returns a data frame containing the coordinates of the supplementary rows. \code{suprow} returns a list with the transformed table \code{Xsup} in \code{tabsup} and the coordinates of the supplementary rows in \code{lisup}.
}
\references{
Gower, J. C. (1967) Multivariate analysis and multivariate geometry. \emph{The statistician}, \bold{17}, 13--28.
}
\author{
Daniel Chessel \cr
Anne-Béatrice Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
}
\examples{
data(euro123)
par(mfrow = c(2, 2))
w <- euro123[[2]]
dudi1 <- dudi.pca(w, scal = FALSE, scan = FALSE)

if(adegraphicsLoaded()) {
  g11 <- s.arrow(dudi1$c1, psub.text = "Classical", psub.posi = "bottomright", plot = FALSE)
  g12 <- s.label(suprow(dudi1, w)$tabsup, plab.cex = 0.75, plot = FALSE)
  g1 <- superpose(g11, g12)
  
  g21 <- s.arrow(dudi1$c1, psub.text = "Without centring", psub.posi = "bottomright", plot = FALSE)
  g22 <- s.label(suprow(dudi1, w)$tabsup, plab.cex = 0.75, plot = FALSE)
  g2 <- superpose(g21, g22) 
  
  g3 <- triangle.label(w, plab.cex = 0.75, label = row.names(w), adjust = FALSE, plot = FALSE)
  g4 <- triangle.label(w, plab.cex = 0.75, label = row.names(w), adjust = TRUE, plot = FALSE)
  
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  
} else {
  s.arrow(dudi1$c1, sub = "Classical", possub = "bottomright", csub = 2.5)
  s.label(suprow(dudi1, w), add.plot = TRUE, clab = 0.75)
  
  s.arrow(dudi1$c1, sub = "Without centring", possub = "bottomright", csub = 2.5)
  s.label(suprow(dudi1, w), clab = 0.75, add.plot = TRUE)
  
  triangle.plot(w, clab = 0.75, label = row.names(w), scal = FALSE)
  triangle.plot(w, clab = 0.75, label = row.names(w), scal = TRUE)
}

data(rpjdl)
rpjdl.coa <- dudi.coa(rpjdl$fau, scann = FALSE, nf = 4)
rpjdl.coa$li[1:3, ]
suprow(rpjdl.coa,rpjdl$fau[1:3, ])$lisup  #the same

data(deug)
deug.dudi <- dudi.pca(df = deug$tab, center = deug$cent, scale = FALSE, scannf = FALSE)
suprow(deug.dudi, deug$tab[1:3, ])$lisup  #the supplementary individuals are centered
deug.dudi$li[1:3, ]  # the same
}
\keyword{multivariate}
