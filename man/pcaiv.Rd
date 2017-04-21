\name{pcaiv}
\alias{pcaiv}
\alias{plot.pcaiv}
\alias{print.pcaiv}
\alias{summary.pcaiv}
\title{Principal component analysis with respect to instrumental variables}
\description{
performs a principal component analysis with respect to instrumental variables. 
}
\usage{
pcaiv(dudi, df, scannf = TRUE, nf = 2)
\method{plot}{pcaiv}(x, xax = 1, yax = 2, \dots) 
\method{print}{pcaiv}(x, \dots)
\method{summary}{pcaiv}(object, \dots) 
}
\arguments{
  \item{dudi}{a duality diagram, object of class \code{dudi}}
  \item{df}{a data frame with the same rows}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \cr
  \item{x, object}{an object of class \code{pcaiv}}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns an object of class \code{pcaiv}, sub-class of class \code{dudi}
  \item{tab}{a data frame with the modified array (projected variables)}
  \item{cw}{a numeric vector with the column weigths (from \code{dudi})}
  \item{lw}{a numeric vector with the row weigths (from \code{dudi})}
  \item{eig}{a vector with the all eigenvalues}
  \item{rank}{an integer indicating the rank of the studied matrix}
  \item{nf}{an integer indicating the number of kept axes}
  \item{c1}{a data frame with the Pseudo Principal Axes (PPA)}
  \item{li}{a data frame \code{dudi$ls} with the predicted values by X}
  \item{co}{a data frame with the inner products between the CPC and Y}
  \item{l1}{data frame with the Constraint Principal Components (CPC)}
  \item{call}{the matched call}
  \item{X}{a data frame with the explanatory variables}
  \item{Y}{a data frame with the dependant variables}
  \item{ls}{a data frame with the projections of lines of \code{dudi$tab} on PPA}
  \item{param}{a table containing information about contributions of the analyses : absolute (1) and cumulative (2) contributions of the decomposition of inertia of the dudi object, absolute (3) and cumulative (4) variances of the projections, the ration (5) between the cumulative variances of the projections (4) and the cumulative contributions (2), the square coefficient of correlation (6) and the eigenvalues of the pcaiv (7)}
  \item{as}{a data frame with the Principal axes of \code{dudi$tab} on PPA}
  \item{fa}{a data frame with the loadings (Constraint Principal Components as linear combinations of X}
  \item{cor}{a data frame with the correlations between the CPC and X }
}
\references{
Rao, C. R. (1964) The use and interpretation of principal component analysis in applied research. \emph{Sankhya}, \bold{A 26}, 329--359.\cr\cr
Obadia, J. (1978) L'analyse en composantes explicatives. \emph{Revue de Statistique Appliquee}, \bold{24}, 5--28.\cr\cr
Lebreton, J. D., Sabatier, R., Banco G. and  Bacou A. M. (1991) 
Principal component and correspondence analyses with respect to instrumental variables : 
an overview of their role in studies of structure-activity and species- environment relationships. 
In J. Devillers and W. Karcher, editors. \emph{Applied Multivariate Analysis in SAR and Environmental Studies}, 
Kluwer Academic Publishers, 85--114.

Ter Braak, C. J. F. (1986) Canonical correspondence analysis : a new eigenvector technique for multivariate direct gradient analysis. \emph{Ecology}, \bold{67}, 1167--1179.\cr\cr
Ter Braak, C. J. F. (1987) The analysis of vegetation-environment relationships by canonical correspondence analysis. \emph{Vegetatio}, \bold{69}, 69--77.\cr\cr
Chessel, D., Lebreton J. D. and Yoccoz N. (1987) Propriétés de l'analyse canonique des correspondances. Une utilisation en hydrobiologie. \emph{Revue de Statistique Appliquée}, \bold{35}, 55--72.\cr\cr
}
\author{
Daniel Chessel \cr
Anne-Béatrice Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}\cr
Stéphane Dray \email{stephane.dray@univ-lyon1.fr}
}
\examples{
# example for the pcaiv
data(rhone)
pca1 <- dudi.pca(rhone$tab, scan = FALSE, nf = 3)
iv1 <- pcaiv(pca1, rhone$disch, scan = FALSE)
summary(iv1)
plot(iv1)

# example for the caiv
data(rpjdl)
millog <- log(rpjdl$mil + 1)
coa1 <- dudi.coa(rpjdl$fau, scann = FALSE)
caiv1 <- pcaiv(coa1, millog, scan = FALSE)

if(adegraphicsLoaded()) {
  G1 <- plot(caiv1)
  
  # analysis with c1 - as - li -ls
  # projections of inertia axes on PCAIV axes
  G2 <- s.corcircle(caiv1$as)
  
  # Species positions
  g31 <- s.label(caiv1$c1, xax = 2, yax = 1, plab.cex = 0.5, xlim = c(-4, 4), plot = FALSE)
  # Sites positions at the weighted mean of present species
  g32 <- s.label(caiv1$ls, xax = 2, yax = 1, plab.cex = 0, plot = FALSE)
  G3 <- superpose(g31, g32, plot = TRUE)
  
  # Prediction of the positions by regression on environmental variables
  G4 <- s.match(caiv1$ls, caiv1$li, xax = 2, yax = 1, plab.cex = 0.5)
  
  # analysis with fa - l1 - co -cor
  # canonical weights giving unit variance combinations
  G5 <- s.arrow(caiv1$fa)
  
  # sites position by environmental variables combinations
  # position of species by averaging
  g61 <- s.label(caiv1$l1, xax = 2, yax = 1, plab.cex = 0, ppoi.cex = 1.5, plot = FALSE)
  g62 <- s.label(caiv1$co, xax = 2, yax = 1, plot = FALSE)
  G6 <- superpose(g61, g62, plot = TRUE)
  
  G7 <- s.distri(caiv1$l1, rpjdl$fau, xax = 2, yax = 1, ellipseSize = 0, starSize = 0.33)
  
  # coherence between weights and correlations
  g81 <- s.corcircle(caiv1$cor, xax = 2, yax = 1, plot = FALSE)
  g82 <- s.arrow(caiv1$fa, xax = 2, yax = 1, plot = FALSE)
  G8 <- cbindADEg(g81, g82, plot = TRUE)

} else {
  plot(caiv1)
  
  # analysis with c1 - as - li -ls
  # projections of inertia axes on PCAIV axes
  s.corcircle(caiv1$as)
  
  # Species positions
  s.label(caiv1$c1, 2, 1, clab = 0.5, xlim = c(-4, 4))
  # Sites positions at the weighted mean of present species
  s.label(caiv1$ls, 2, 1, clab = 0, cpoi = 1, add.p = TRUE)
  
  # Prediction of the positions by regression on environmental variables
  s.match(caiv1$ls, caiv1$li, 2, 1, clab = 0.5)
  
  # analysis with fa - l1 - co -cor
  # canonical weights giving unit variance combinations
  s.arrow(caiv1$fa)
  
  # sites position by environmental variables combinations
  # position of species by averaging
  s.label(caiv1$l1, 2, 1, clab = 0, cpoi = 1.5)
  s.label(caiv1$co, 2, 1, add.plot = TRUE)
  
  s.distri(caiv1$l1, rpjdl$fau, 2, 1, cell = 0, csta = 0.33)
  s.label(caiv1$co, 2, 1, clab = 0.75, add.plot = TRUE)
  
  # coherence between weights and correlations
  par(mfrow = c(1, 2))
  s.corcircle(caiv1$cor, 2, 1)
  s.arrow(caiv1$fa, 2, 1)
  par(mfrow = c(1, 1))
}
}
\keyword{multivariate}
