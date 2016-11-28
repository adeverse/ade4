\name{rlq}
\alias{rlq}
\alias{print.rlq}
\alias{plot.rlq}
\alias{summary.rlq}
\alias{randtest.rlq}
\title{RLQ analysis }
\description{
RLQ analysis performs a double inertia analysis of two arrays (R and Q) with a link expressed by a contingency table (L).
The rows of L correspond to the rows of R and the columns of L correspond to the rows of Q.
}
\usage{
rlq(dudiR, dudiL, dudiQ, scannf = TRUE, nf = 2)
\method{print}{rlq}(x, ...)
\method{plot}{rlq}(x, xax = 1, yax = 2, ...)
\method{summary}{rlq}(object, ...)
\method{randtest}{rlq}(xtest,nrepet = 999, modeltype = 6,...)
}

\arguments{
  \item{dudiR}{ a duality diagram providing from one of the functions dudi.hillsmith, dudi.pca, \dots }
  \item{dudiL}{ a duality diagram of the function dudi.coa }
  \item{dudiQ}{ a duality diagram providing from one of the functions dudi.hillsmith, dudi.pca, \dots }
  \item{scannf}{ a logical value indicating whether the eigenvalues bar plot should be displayed }
  \item{nf}{ if scannf FALSE, an integer indicating the number of kept axes }
  \item{x}{ an rlq object }
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{object}{ an rlq object }
  \item{xtest}{ an rlq object }
  \item{nrepet}{ the number of permutations }
  \item{modeltype}{the model used to permute data(2: permute rows of R,
    4: permute rows of Q, 5: permute both, 6: sequential approach, see
    ter Braak et al. 2012)}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
  Returns a list of class 'dudi', sub-class 'rlq' containing:
  \item{call}{call}
  \item{rank}{rank}
  \item{nf}{a numeric value indicating the number of kept axes}
  \item{RV}{a numeric value, the RV coefficient}
  \item{eig}{a numeric vector with all the eigenvalues}
  \item{lw}{a numeric vector with the rows weigths (crossed array)}
  \item{cw}{a numeric vector with the columns weigths (crossed array)}
  \item{tab}{a crossed array (CA)} 
  \item{li}{R col = CA row: coordinates}
  \item{l1}{R col = CA row: normed scores}
  \item{co}{Q col = CA column: coordinates}
  \item{c1}{Q col = CA column: normed scores}
  \item{lR}{the row coordinates (R)}
  \item{mR}{the normed row scores (R)}
  \item{lQ}{the row coordinates (Q)}
  \item{mQ}{the normed row scores (Q)}
  \item{aR}{the axis onto co-inertia axis (R)}
  \item{aQ}{the axis onto co-inertia axis (Q)}
}
\references{ 
Doledec, S., Chessel, D., ter Braak, C.J.F. and Champely, S. (1996) 
Matching species traits to environmental variables: a new three-table ordination method. \emph{Environmental and Ecological Statistics}, 
\bold{3}, 143--166.

Dray, S., Pettorelli, N., Chessel, D. (2002) Matching data sets from two different spatial samplings. 
\emph{Journal of Vegetation Science}, \bold{13}, 867--874.

Dray, S. and Legendre, P. (2008) 
Testing the species traits-environment relationships: the fourth-corner
problem revisited. \emph{Ecology},
\bold{89}, 3400--3412.

ter Braak, C., Cormont, A., Dray, S. (2012) Improved testing of species
traits-environment relationships in the fourth corner problem.
\emph{Ecology}, \bold{93}, 1525--1526.

}
\author{Stéphane Dray \email{stephane.dray@univ-lyon1.fr}}

\section{WARNING }{
IMPORTANT : row weights for \code{dudiR} and \code{dudiQ} must be taken from \code{dudiL}.
}
\note{A testing procedure based on the total coinertia of the RLQ
  analysis is available by the function \code{randtest.rlq}. The
  function allows to deal with various analyses for tables R and Q. Means and variances are recomputed for each
  permutation (PCA); for MCA, tables are recentred and column weights are recomputed.The
  case of decentred PCA (PCA where centers are entered by the user) for
  R or Q is not yet implemented. If you want to use the testing
  procedure for this case, you must firstly center the table and then perform a non-centered PCA on the modified table.} 
\seealso{ \code{\link{coinertia}},   \code{\link{fourthcorner}}}
\examples{
   data(aviurba)
   coa1 <- dudi.coa(aviurba$fau, scannf = FALSE, nf = 2)
   dudimil <- dudi.hillsmith(aviurba$mil, scannf = FALSE, nf = 2, row.w = coa1$lw)
   duditrait <- dudi.hillsmith(aviurba$traits, scannf = FALSE, nf = 2, row.w = coa1$cw)
   rlq1 <- rlq(dudimil, coa1, duditrait, scannf = FALSE, nf = 2)
   plot(rlq1)
   summary(rlq1)
   randtest(rlq1)
   fourthcorner.rlq(rlq1,type="Q.axes")
   fourthcorner.rlq(rlq1,type="R.axes")

}
\keyword{ multivariate }
\keyword{ spatial }

