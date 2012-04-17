\name{bca.rlq}
\alias{bca.rlq}
\alias{plot.betrlq}
\alias{print.betrlq}
\title{
Between-Class RLQ analysis
}
\description{
Performs a particular RLQ analysis where a partition of sites (rows of
R) is taken into account. The between-class RLQ analysis search for
linear combinations of traits and environmental variables maximizing the
covariances between the traits and the average environmental conditions of classes.
}
\usage{
\method{bca}{rlq}(x, fac, scannf = TRUE, nf = 2, ...)
\method{plot}{betrlq}(x, xax = 1, yax = 2, ...)
\method{print}{betrlq}(x, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{an object of class rlq (created by the \code{rlq} function)
   for the \code{bca.rlq} function. An object of class \code{betrlq} for
   the \code{print} and \code{plot} functions}
  \item{fac}{a factor partitioning the rows of R}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}

\value{
  The \code{bca.rlq} function returns an object of class 'betrlq'
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

\seealso{\code{\link{rlq}}, \code{\link{bca}}, \code{\link{wca.rlq}}
}

\examples{
data(piosphere)
afcL <- dudi.coa(log(piosphere$veg + 1), scannf = FALSE)
acpR <- dudi.pca(piosphere$env, scannf = FALSE, row.w = afcL$lw)
acpQ <- dudi.hillsmith(piosphere$traits, scannf = FALSE, row.w =
  afcL$cw)
rlq1 <- rlq(acpR, afcL, acpQ, scannf = FALSE)

brlq1 <- bca(rlq1, fac = piosphere$habitat, scannf = FALSE)
brlq1
plot(brlq1)
}

\keyword{  multivariate }

