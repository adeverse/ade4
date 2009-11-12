\name{betweencoinertia}
\alias{betweencoinertia}
\alias{print.betcoi}
\alias{plot.betcoi}
\title{Between-class coinertia analysis}
\description{Performs a between-class analysis after a coinertia analysis}
\usage{
betweencoinertia(obj, fac, scannf = TRUE, nf = 2)
\method{plot}{betcoi}(x, xax = 1, yax = 2, ...)
\method{print}{betcoi}(x, ...)
}

\arguments{
  \item{obj}{a coinertia analysis (object of class \link{coinertia})
    obtained by the function \link{coinertia}}
  \item{fac}{a factor partitioning the rows in classes}
  \item{scannf}{a logical value indicating whether the eigenvalues barplot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{xax}{the axis number to be plotted for the x-axis}
  \item{yax}{the axis number to be plotted for the y-axis}
  \item{x}{an object of class \code{betcoi}}
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
\author{
Stephane Dray \email{dray@biomserv.univ-lyon1.fr} and Jean Thioulouse \email{jean.thioulouse@univ-lyon1.fr}
}

\seealso{\code{\link{coinertia}}, \code{\link{between}}}
\examples{
data(meaudret)
pca1 <- dudi.pca(meaudret$mil, scan = FALSE, nf = 4)
pca2 <- dudi.pca(meaudret$fau, scal = FALSE, scan = FALSE, nf = 4)
   
bet1 <- between(pca1, meaudret$plan$sta, scan = FALSE, nf = 2)
bet2 <- between(pca2, meaudret$plan$sta, scan = FALSE, nf = 2)
coib <- coinertia(bet1, bet2, scannf = FALSE)

coi <- coinertia(pca1,pca2,scannf = FALSE,nf = 3)
coi.b <- betweencoinertia(coi,meaudret$plan$sta, scannf = FALSE)
## coib and coi.b are equivalent

plot(coi.b)
}

\keyword{multivariate}

