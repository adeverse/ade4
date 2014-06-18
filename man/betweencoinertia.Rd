\name{bca.coinertia}
\alias{betweencoinertia}
\alias{bca.coinertia}
\title{Between-class coinertia analysis}
\description{Performs a between-class analysis after a coinertia analysis}
\usage{
betweencoinertia(obj, fac, scannf = TRUE, nf = 2)
\method{bca}{coinertia}(x, fac, scannf = TRUE, nf = 2, \dots) 
}

\arguments{
  \item{obj}{a coinertia analysis (object of class \link{coinertia})
    obtained by the function \link{coinertia}}
  \item{x}{a coinertia analysis (object of class \link{coinertia})
    obtained by the function \link{coinertia}}
  \item{fac}{a factor partitioning the rows in classes}
  \item{scannf}{a logical value indicating whether the eigenvalues barplot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
  This analysis is equivalent to do a between-class analysis on each
  initial dudi, and a coinertia analysis on the two between analyses. This function returns additional outputs for the interpretation.
}
\value{
  An object of the class \code{betcoi}. Outputs are described by the
  \code{print} function
}
\references{
Franquet E., Doledec S., and Chessel D. (1995) Using multivariate analyses for separating spatial and temporal effects within species-environment relationships. \emph{Hydrobiologia}, \bold{300}, 425--431.
}

\note{
To avoid conflict names with the \code{base:::within} function, the
function \code{within} is now deprecated and will be removed. To be
consistent, the \code{betweencoinertia} function is also deprecated and
is replaced by the method \code{bca.coinertia} of the new generic \code{bca} function. 
}

\author{
Stephane Dray \email{stephane.dray@univ-lyon1.fr} and Jean Thioulouse \email{jean.thioulouse@univ-lyon1.fr}
}

\seealso{\code{\link{coinertia}}, \code{\link{between}}}
\examples{
data(meaudret)
pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 4)
pca2 <- dudi.pca(meaudret$spe, scal = FALSE, scan = FALSE, nf = 4)
   
bet1 <- bca(pca1, meaudret$design$site, scan = FALSE, nf = 2)
bet2 <- bca(pca2, meaudret$design$site, scan = FALSE, nf = 2)
coib <- coinertia(bet1, bet2, scannf = FALSE)

coi <- coinertia(pca1, pca2, scannf = FALSE, nf = 3)
coi.b <- bca(coi,meaudret$design$site, scannf = FALSE)
## coib and coi.b are equivalent

plot(coi.b)
}

\keyword{multivariate}

