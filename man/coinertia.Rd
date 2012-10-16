\encoding{latin1}
\name{coinertia}
\alias{coinertia}
\alias{print.coinertia}
\alias{plot.coinertia}
\alias{summary.coinertia}
\title{Coinertia Analysis}
\description{
The coinertia analysis performs a double inertia analysis of two tables. 
}
\usage{
coinertia(dudiX, dudiY, scannf = TRUE, nf = 2)
\method{plot}{coinertia} (x, xax = 1, yax = 2, \dots) 
\method{print}{coinertia} (x, \dots) 
\method{summary}{coinertia} (object, \dots) 
}
\arguments{
  \item{dudiX}{a duality diagram providing from one of the functions dudi.coa, dudi.pca, \dots}
  \item{dudiY}{a duality diagram providing from one of the functions dudi.coa, dudi.pca, \dots}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \cr
  \item{x, object}{an object of class 'coinertia'}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
Returns a list of class 'coinertia', sub-class 'dudi' containing:
  \item{call}{call}
  \item{rank}{rank}
  \item{nf}{a numeric value indicating the number of kept axes}
  \item{RV}{a numeric value, the RV coefficient}
  \item{eig}{a numeric vector with all the eigenvalues}
  \item{lw}{a numeric vector with the rows weigths (crossed table)}
  \item{cw}{a numeric vector with the columns weigths (crossed table)}
  \item{tab}{a crossed table (CT)} 
  \item{li}{Y CT row scores (cols of dudiY)}
  \item{l1}{Principal components (loadings for cols of dudiY)}
  \item{co}{CT col scores (cols of dudiX)}
  \item{c1}{Principal axes (cols of dudiX)}
  \item{lX}{Row scores (rows of dudiX)}
  \item{mX}{Normed row scores (rows of dudiX)}
  \item{lY}{Row scores (rows of dudiY)}
  \item{mY}{Normed row scores (rows of dudiY)}
  \item{aX}{Correlations between dudiX axes and coinertia axes}
  \item{aY}{Correlations between dudiY axes and coinertia axes}
}
\references{
Dolédec, S. and Chessel, D. (1994) Co-inertia analysis: an alternative method for studying species-environment relationships. 
\emph{Freshwater Biology}, \bold{31}, 277--294.\cr

Dray, S., Chessel, D. and J. Thioulouse (2003) Co-inertia analysis and the linking of the ecological data tables.
\emph{Ecology}, \bold{84}, 11, 3078--3089.
}
\section{WARNING }{
IMPORTANT : \code{dudi1} and \code{dudi2} must have identical row weights.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(doubs)
dudi1 <- dudi.pca(doubs$env, scale = TRUE, scan = FALSE, nf = 3)
dudi2 <- dudi.pca(doubs$fish, scale = FALSE, scan = FALSE, nf = 2)
coin1 <- coinertia(dudi1,dudi2, scan = FALSE, nf = 2)
s.arrow(coin1$l1, clab = 0.7)

s.arrow(coin1$c1, clab = 0.7)

par(mfrow = c(1,2))
s.corcircle(coin1$aX)
s.corcircle(coin1$aY)
par(mfrow = c(1,1))
 
coin1
summary(coin1)
plot(coin1)
}
\keyword{multivariate}
