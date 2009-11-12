\name{withincoinertia}
\alias{withincoinertia}
\alias{plot.witcoi}
\alias{print.witcoi}
\title{Within-class coinertia analysis}
\description{
Performs a within-class analysis after a coinertia analysis
}
\usage{
withincoinertia(obj, fac, scannf = TRUE, nf = 2)
\method{plot}{witcoi}(x, xax = 1, yax = 2, ...)
\method{print}{witcoi}(x, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{obj}{a coinertia analysis (object of class \link{coinertia})
    obtained by the function \link{coinertia}}
  \item{fac}{a factor partitioning the rows in classes}
  \item{scannf}{a logical value indicating whether the eigenvalues barplot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{xax}{the axis number to be plotted for the x-axis}
  \item{yax}{the axis number to be plotted for the y-axis}
  \item{x}{an object of class \code{witcoi}}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
  This analysis is equivalent to do a within-class analysis on each
  initial dudi, and a coinertia analysis on the two within
  analyses. This function returns additional outputs for the interpretation. 
}
\value{
  An object of the class \code{witcoi}. Outputs are described by the
  \code{print} function
}
\references{
Franquet E., Doledec S., and Chessel D. (1995) Using multivariate analyses for separating spatial and temporal effects within species-environment relationships. \emph{Hydrobiologia}, \bold{300}, 425--431.
}
\author{
Stephane Dray \email{dray@biomserv.univ-lyon1.fr} and Jean Thioulouse \email{jean.thioulouse@univ-lyon1.fr}
}
\seealso{\code{\link{coinertia}}, \code{\link{within}}
}
\examples{
data(meaudret)
pca1 <- dudi.pca(meaudret$mil, scan = FALSE, nf = 4)
pca2 <- dudi.pca(meaudret$fau, scal = FALSE, scan = FALSE, nf = 4)
   
wit1 <- within(pca1, meaudret$plan$sta, scan = FALSE, nf = 2)
wit2 <- within(pca2, meaudret$plan$sta, scan = FALSE, nf = 2)
coiw <- coinertia(wit1, wit2, scannf = FALSE)

coi <- coinertia(pca1,pca2,scannf = FALSE,nf=3)
coi.w <- withincoinertia(coi,meaudret$plan$sta, scannf = FALSE)
## coiw and coi.w are equivalent

plot(coi.w)
}

\keyword{multivariate}

