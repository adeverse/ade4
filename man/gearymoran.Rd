\encoding{latin1}
\name{gearymoran}
\alias{gearymoran}
\title{Moran's I and Geary'c randomization tests for spatial and phylogenetic autocorrelation}
\description{
This function performs Moran's I test using phylogenetic and spatial link matrix (binary or general). It uses neighbouring weights so Moran's I and Geary's c randomization tests are equivalent.
}
\usage{
gearymoran(bilis, X, nrepet = 999, alter=c("greater", "less", "two-sided"))
}
\arguments{
  \item{bilis}{: a \emph{n} by \emph{n} link matrix where \emph{n} is the row number of X}
  \item{X}{: a data frame with continuous variables}
  \item{nrepet}{: number of random vectors for the randomization test}
  \item{alter}{a character string specifying the alternative hypothesis,
  must be one of "greater" (default), "less" or "two-sided"}
}
\details{
\code{bilis} is a squared symmetric matrix which terms are all positive or null. 

\code{bilis} is firstly transformed in frequency matrix A by dividing it by the total sum of data matrix :  
\deqn{a_{ij} = \frac{bilis_{ij}}{\sum_{i=1}^{n}\sum_{j=1}^{n}bilis_{ij}}}{a_ij = bilis_ij / (sum_i sum_j bilis_ij)} 
The neighbouring weights is defined by the matrix \eqn{D = diag(d_1,d_2, \ldots)} where \eqn{d_i = \sum_{j=1}^{n}bilis_{ij}}{d_i = sum_j bilis_ij}.
For each vector x of the data frame X, the test is based on the Moran statistic \eqn{x^{t}Ax}{t(x)Ax} where x is D-centred. 
}
\value{
Returns an object of class \code{krandtest} (randomization tests).
}
\references{
Cliff, A. D. and Ord, J. K. (1973) \emph{Spatial autocorrelation}, Pion, London.

Thioulouse, J., Chessel, D. and Champely, S. (1995) Multivariate analysis of spatial patterns: a unified approach to local and global structures. 
\emph{Environmental and Ecological Statistics}, \bold{2}, 1--14.
}
\author{Sébastien Ollier \email{sebastien.ollier@u-psud.fr} \cr
Daniel Chessel 
}
\seealso{\code{\link[spdep]{moran.test}} and \code{\link[spdep]{geary.test}} for classical versions of Moran's test and Geary's one}
\examples{
# a spatial example
data(mafragh)
tab0 <- (as.data.frame(scalewt(mafragh$mil)))
bilis0 <- neig2mat(mafragh$neig)
gm0 <- gearymoran(bilis0, tab0, 999)
gm0
plot(gm0, nclass = 20)

\dontrun{
# a phylogenetic example
data(mjrochet)
mjr.phy <- newick2phylog(mjrochet$tre)
mjr.tab <- log(mjrochet$tab)
gearymoran(mjr.phy$Amat, mjr.tab)
gearymoran(mjr.phy$Wmat, mjr.tab)
if(adegraphicsLoaded()) {
  g1 <- table.value(mjr.phy$Wmat, ppoints.cex = 0.35, nclass = 5,
axis.text = list(cex = 0), plot = F)
  g2 <- table.value(mjr.phy$Amat, ppoints.cex = 0.35, nclass = 5,
axis.text = list(cex = 0), plot = F)
  G <- cbindADEg(g1, g2, plot = TRUE)
  
} else {
  par(mfrow = c(1,2))
  table.value(mjr.phy$Wmat, csi = 0.25, clabel.r = 0)
  table.value(mjr.phy$Amat, csi = 0.35, clabel.r = 0)
  par(mfrow = c(1,1))
}
}}
\keyword{spatial}
\keyword{ts}
