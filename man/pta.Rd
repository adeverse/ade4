\name{pta}
\alias{pta}
\alias{print.pta}
\alias{plot.pta}
\title{Partial Triadic Analysis of a K-tables}
\description{
performs a partial triadic analysis of a K-tables, 
using an object of class \code{ktab}. 
}
\usage{
pta(X, scannf = TRUE, nf = 2)
\method{plot}{pta}(x, xax = 1, yax = 2, option = 1:4, \dots)
\method{print}{pta}(x, \dots)
}
\arguments{
  \item{X}{an object of class \code{ktab} where the arrays have 1) the same dimensions 2) the same names for columns 3) the same column weightings}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  
  \item{x}{an object of class 'pta'}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{option}{an integer between 1 and 4, otherwise the 4 components of the plot are displayed}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns a list of class 'pta', sub-class of  'dudi' containing :
  \item{RV}{a matrix with the all RV coefficients}
  \item{RV.eig}{a numeric vector with the all eigenvalues (interstructure)}
  \item{RV.coo}{a data frame with the scores of the arrays}
  \item{tab.names}{a vector of characters with the array names}
  \item{nf}{an integer indicating the number of kept axes}
  \item{rank}{an integer indicating the rank of the studied matrix}
  \item{tabw}{a numeric vector with the array weights}
  \item{cw}{a numeric vector with the column weights}
  \item{lw}{a numeric vector with the row weights}
  \item{eig}{a numeric vector with the all eigenvalues (compromis)}
  \item{cos2}{a numeric vector with the \eqn{\cos^2}{cos²} between compromise and arrays} 
  \item{tab}{a data frame with the modified array}
  \item{li}{a data frame with the row coordinates}
  \item{l1}{a data frame with the row normed scores}
  \item{co}{a data frame with the column coordinates}
  \item{c1}{a data frame with the column normed scores}
  \item{Tli}{a data frame with the row coordinates (each table)}
  \item{Tco}{a data frame with the column coordinates (each table)}
  \item{Tcomp}{a data frame with the principal components (each table)}
  \item{Tax}{a data frame with the principal axes (each table)}
  \item{TL}{a data frame with the factors for Tli}
  \item{TC}{a data frame with the factors for Tco}
  \item{T4}{a data frame with the factors for Tax and Tcomp}
}
\references{
Blanc, L., Chessel, D. and Dolédec, S. (1998) Etude de la stabilité temporelle des structures spatiales par Analyse d'une série de tableaux faunistiques totalement appariés. \emph{Bulletin Français de la Pêche et de la Pisciculture}, \bold{348}, 1--21.\cr\cr
Thioulouse, J., and D. Chessel. 1987. Les analyses multi-tableaux en écologie factorielle. I De la typologie d'état à la typologie de fonctionnement par l'analyse triadique. \emph{Acta Oecologica, Oecologia Generalis}, \bold{8}, 463--480.
}
\author{
Pierre Bady \email{pierre.bady@univ-lyon1.fr}\cr
Anne-Béatrice Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
}
\examples{
data(meaudret)
wit1 <- withinpca(meaudret$env, meaudret$design$season, scan = FALSE, scal = "partial")
kta1 <- ktab.within(wit1, colnames = rep(c("S1", "S2", "S3", "S4", "S5"), 4))
kta2 <- t(kta1)
pta1 <- pta(kta2, scann = FALSE)
pta1
plot(pta1)
}
\keyword{multivariate}
