\name{dpcoa}
\alias{dpcoa}
\alias{plot.dpcoa}
\alias{print.dpcoa}
\title{Double principal coordinate analysis}
\description{
Performs a double principal coordinate analysis  
}
\usage{
dpcoa (df, dis = NULL, scannf = TRUE, nf = 2, full = FALSE, tol = 1e-07)
\method{plot}{dpcoa}(x, xax = 1, yax = 2, option = 1:4, csize = 2, \dots)
\method{print}{dpcoa} (x, \dots)
}
\arguments{
  \item{df}{a data frame with elements as rows, samples as columns and abundance or presence-absence as entries}
  \item{dis}{an object of class \code{dist} containing the distances between the elements.}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf is FALSE, an integer indicating the number of kept axes}
  \item{full}{a logical value indicating whether all non null eigenvalues should be kept}
  \item{tol}{a tolerance threshold for null eigenvalues (a value less than tol times the first one is considered as null)}
  \item{x}{an object of class \code{dpcoa}}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{option}{the function \code{plot.dpcoa} produces four graphs, \code{option} allows us to choose only some of them}
  \item{csize}{a size coefficient for symbols}
  \item{\dots}{\code{\dots} further arguments passed to or from other methods}
}
\value{
Returns a list of class \code{dpcoa} containing:
  \item{call}{call}
  \item{nf}{a numeric value indicating the number of kept axes}
  \item{w1}{a numeric vector containing the weights of the elements}
  \item{w2}{a numeric vector containing the weights of the samples}
  \item{eig}{a numeric vector with all the eigenvalues}
  \item{RaoDiv}{a numeric vector containing diversities within samples}
  \item{RaoDis}{an object of class \code{dist} containing the dissimilarities between samples}
  \item{RaoDecodiv}{a data frame with the decomposition of the diversity}
  \item{l1}{a data frame with the coordinates of the elements}
  \item{l2}{a data frame with the coordinates of the samples}
  \item{c1}{a data frame with the scores of the principal axes of the elements}
}
\references{
  Pavoine, S., Dufour, A.B. and Chessel, D. (2004) From dissimilarities among species to dissimilarities among communities:
  a double principal coordinate analysis. \emph{Journal of Theoretical Biology}, \bold{228}, 523--537.
}
\author{Daniel Chessel  \cr
Sandrine Pavoine \email{pavoine@mnhn.fr} \cr
Anne B Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
}
\examples{
data(humDNAm)
dpcoahum <- dpcoa(humDNAm$samples, sqrt(humDNAm$distances), scan = FALSE, nf = 2)
dpcoahum
plot(dpcoahum, csize = 1.5)
\dontrun{
data(ecomor)
dtaxo <- dist.taxo(ecomor$taxo)
dpcoaeco <- dpcoa(ecomor$habitat, dtaxo, scan = FALSE, nf = 2)
dpcoaeco
plot(dpcoaeco, csize = 1.5)}
}
\keyword{multivariate}
