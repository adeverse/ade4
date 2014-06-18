\name{wca.rlq}
\alias{wca.rlq}
\alias{plot.witrlq}
\alias{print.witrlq}

\title{
Within-Class RLQ analysis
}
\description{
Performs a particular RLQ analysis where a partition of sites (rows of
R) is taken into account. The within-class RLQ analysis search for
linear combinations of traits and environmental variables of maximal covariance.
}
\usage{
\method{wca}{rlq}(x, fac, scannf = TRUE, nf = 2, ...)
\method{plot}{witrlq}(x, xax = 1, yax = 2, ...)
\method{print}{witrlq}(x, ...)
}

\arguments{
   \item{x}{an object of class rlq (created by the \code{rlq} function)
   for the \code{wca.rlq} function. An object of class \code{witrlq} for
   the \code{print} and \code{plot} functions}
  \item{fac}{a factor partitioning the rows of R}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}

\value{
 The \code{wca.rlq} function returns an object of class 'betrlq'
  (sub-class of 'dudi'). See the outputs of the \code{print} function
  for more details.
}
\references{
Wesuls, D., Oldeland, J. and Dray, S. (2012) Disentangling plant trait
responses to livestock grazing from spatio-temporal variation: the
partial RLQ approach. \emph{Journal of Vegetation Science}, \bold{23}, 98--113.
}
\author{
Stephane Dray \email{stephane.dray@univ-lyon1.fr}
}

\seealso{
  \code{\link{rlq}}, \code{\link{wca}}, \code{\link{wca.rlq}}
}
\examples{
data(piosphere)
afcL <- dudi.coa(log(piosphere$veg + 1), scannf = FALSE)
acpR <- dudi.pca(piosphere$env, scannf = FALSE, row.w = afcL$lw)
acpQ <- dudi.hillsmith(piosphere$traits, scannf = FALSE, row.w = afcL$cw)
rlq1 <- rlq(acpR, afcL, acpQ, scannf = FALSE)

wrlq1 <- wca(rlq1, fac = piosphere$habitat, scannf = FALSE)
wrlq1
plot(wrlq1)
}

\keyword{multivariate}

