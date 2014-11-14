\name{dpcoa}
\alias{dpcoa}
\alias{plot.dpcoa}
\alias{print.dpcoa}
\alias{summary.dpcoa}
\title{Double principal coordinate analysis}
\description{
Performs a double principal coordinate analysis  
}
\usage{
dpcoa(df, dis = NULL, scannf = TRUE, nf = 2, full = FALSE, tol = 1e-07,
RaoDecomp = TRUE)
\method{plot}{dpcoa}(x, xax = 1, yax = 2, \dots)
\method{print}{dpcoa} (x, \dots)
\method{summary}{dpcoa} (object, \dots)
}
\arguments{
  \item{df}{a data frame with samples as rows and categories
    (i.e. species) as columns and abundance or presence-absence as
    entries. Previous releases of \pkg{ade4} (<=1.6-2) considered the
    transposed matrix as argument.}
  \item{dis}{an object of class \code{dist} containing the distances between the categories.}
  \item{scannf}{a logical value indicating whether the eigenvalues bar
    plot should be displayed}
  \item{RaoDecomp}{a logical value indicating whether Rao diversity
    decomposition should be performed}
  \item{nf}{if scannf is FALSE, an integer indicating the number of kept axes}
  \item{full}{a logical value indicating whether all non null eigenvalues should be kept}
  \item{tol}{a tolerance threshold for null eigenvalues (a value less than tol times the first one is considered as null)}
  \item{x, object}{an object of class \code{dpcoa}}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{\dots}{\code{\dots} further arguments passed to or from other methods}
}
\value{
Returns a list of class \code{dpcoa} containing:
  \item{call}{call}
  \item{nf}{a numeric value indicating the number of kept axes}
  \item{dw}{a numeric vector containing the weights of the elements (was
    \code{w1} in previous releases of \pkg{ade4})}
  \item{lw}{a numeric vector containing the weights of the samples (was
    \code{w2} in previous releases of \pkg{ade4})}
  \item{eig}{a numeric vector with all the eigenvalues}
  \item{RaoDiv}{a numeric vector containing diversities within samples}
  \item{RaoDis}{an object of class \code{dist} containing the dissimilarities between samples}
  \item{RaoDecodiv}{a data frame with the decomposition of the diversity}
  \item{dls}{a data frame with the coordinates of the elements (was
    \code{l1} in previous releases of \pkg{ade4})}
  \item{li}{a data frame with the coordinates of the samples (was
    \code{l2} in previous releases of \pkg{ade4})}
  \item{c1}{a data frame with the scores of the principal axes of the elements}
}

\references{
  Pavoine, S., Dufour, A.B. and Chessel, D. (2004) From dissimilarities among species to dissimilarities among communities:
  a double principal coordinate analysis. \emph{Journal of Theoretical Biology}, \bold{228}, 523--537.
}
\author{Daniel Chessel  \cr
Sandrine Pavoine \email{pavoine@mnhn.fr} \cr
Stephane Dray \email{stephane.dray@univ-lyon1.fr}
}
\examples{
data(humDNAm)
dpcoahum <- dpcoa(data.frame(t(humDNAm$samples)), sqrt(humDNAm$distances), scan = FALSE, nf = 2)
dpcoahum
if(adegraphicsLoaded()) {
  g1 <- plot(dpcoahum)
} else {
  plot(dpcoahum)
}
  
\dontrun{
data(ecomor)
dtaxo <- dist.taxo(ecomor$taxo)
dpcoaeco <- dpcoa(data.frame(t(ecomor$habitat)), dtaxo, scan = FALSE, nf = 2)
dpcoaeco

if(adegraphicsLoaded()) {
  g1 <- plot(dpcoaeco)
} else {
  plot(dpcoaeco)
}
}}
\keyword{multivariate}
