\name{rlq}
\alias{rlq}
\alias{print.rlq}
\alias{plot.rlq}
\alias{summary.rlq}
\alias{as.coinertia}
\alias{randtest.rlq}
\title{RLQ analysis }
\description{
RLQ analysis performs a double inertia analysis of two arrays (R and Q) with a link expressed by a contingency table (L).
The rows of L correspond to the rows of R and the columns of Q correspond to the rows of Q.
RLQ analysis is an extension of coinertia analysis (see as.coinertia function).
}
\usage{
rlq(dudiR, dudiL, dudiQ, scannf = TRUE, nf = 2)
print.rlq(x, ...)
plot.rlq(x, xax = 1, yax = 2, ...)
summary.rlq(object, ...)
as.coinertia (dudiRLQ, fixed="R")
randtest.rlq(xtest,nrepet = 999, ...)
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
  \item{dudiRLQ}{ an rlq object }
  \item{object}{ an rlq object }
  \item{fixed}{ "R" indicates that dudiR is not modified, otherwise "Q" }
  \item{xtest}{ an rlq object }
  \item{nrepet}{ the number of permutations }
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
}
\author{ Stephane Dray \email{dray@biomserv.univ-lyon1.fr}}

\section{WARNING }{
IMPORTANT : row weights for \code{dudiR} and \code{dudiQ} must be taken from \code{dudiL}.
}
\note{\code{as.coinertia} transforms a \code{rlq} object into a \code{coinertia} object but user must specify which \code{dudi} is fixed and not modified.} 
\seealso{ \code{\link{coinertia}} }
\examples{
data(aviurba)
   coa1 <- dudi.coa(aviurba$fau, scannf = FALSE, nf = 2)
   dudimil <- dudi.hillsmith(aviurba$mil, scannf = FALSE, nf = 2, row.w = coa1$lw)
   duditrait <- dudi.hillsmith(aviurba$traits, scannf = FALSE, nf = 2, row.w = coa1$cw)
   rlq1 <- rlq(dudimil, coa1, duditrait, scannf = FALSE, nf = 2)
   plot(rlq1)
   summary(rlq1)
   randtest.rlq(rlq1)
}
\keyword{ multivariate }
\keyword{ spatial }

