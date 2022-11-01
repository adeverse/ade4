\name{wca.coinertia}

\alias{wca.coinertia}

\title{Within-class coinertia analysis}

\description{
Performs a within-class analysis after a coinertia analysis
}

\usage{
\method{wca}{coinertia}(x, fac, scannf = TRUE, nf = 2, \dots) 
}

\arguments{
  \item{x}{a coinertia analysis (object of class \link{coinertia})
    obtained by the function \link{coinertia}}
  \item{fac}{a factor partitioning the rows in classes}
  \item{scannf}{a logical value indicating whether the eigenvalues barplot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{\dots}{further arguments passed to or from other methods}
}

\value{
  An object of the class \code{witcoi}. Outputs are described by the
  \code{print} function
}

\details{
  This analysis is equivalent to do a within-class analysis on each
  initial dudi, and a coinertia analysis on the two within
  analyses. This function returns additional outputs for the interpretation. 
}

\references{
Franquet E., Doledec S., and Chessel D. (1995) Using multivariate analyses for 
separating spatial and temporal effects within species-environment relationships. 
\emph{Hydrobiologia}, \bold{300}, 425--431.
}

\note{
To avoid conflict names with the \code{base:::within} function, the
function \code{within} is now deprecated and removed. To be
consistent, the \code{withincoinertia} function is also deprecated and
is replaced by the method \code{wca.coinertia} of the generic \code{wca} function. 
}

\author{
Stéphane Dray \email{stephane.dray@univ-lyon1.fr} and Jean Thioulouse \email{jean.thioulouse@univ-lyon1.fr}
}

\seealso{\code{\link{coinertia}}, \code{\link{wca}}
}

\examples{
data(meaudret)
pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 4)
pca2 <- dudi.pca(meaudret$spe, scal = FALSE, scan = FALSE, nf = 4)
   
wit1 <- wca(pca1, meaudret$design$site, scan = FALSE, nf = 2)
wit2 <- wca(pca2, meaudret$design$site, scan = FALSE, nf = 2)
coiw <- coinertia(wit1, wit2, scannf = FALSE)

coi <- coinertia(pca1, pca2, scannf = FALSE, nf = 3)
coi.w <- wca(coi, meaudret$design$site, scannf = FALSE)
## coiw and coi.w are equivalent

plot(coi.w)
}

\keyword{multivariate}
