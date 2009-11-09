\encoding{latin1}
\name{wgcoia}
\alias{wgcoia}
\title{Within-group coinertia analysis}
\description{
Does a within-groups coinertia analysis. This function uses
within-group analysis (\link{within}) and \link{coinertia}
to do the computations.
}
\usage{
wgcoia(dudiX, dudiY, fac, scannf = TRUE)
}
\arguments{
  \item{dudiX}{a duality diagram, object of class \link{dudi} from one of the functions dudi.coa, dudi.pca, ...}
  \item{dudiY}{a duality diagram, object of class \link{dudi} from one of the functions dudi.coa, dudi.pca, ...}
  \item{fac}{a factor partitioning the rows of dudi$tab in classes}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
}
\details{
This function takes 2 dudi and one factor. It does a within-group analysis on each dudi, and does a coinertia analysis on the two within analyses.
}
\value{
a list of class coinertia, subclass dudi. See \link{coinertia}
}
\references{
Franquet E., Doledec S., and Chessel D. Using multivariate analyses for separating spatial
and temporal effects within species-environment relationships. \emph{Hydrobiologia}, \bold{300}, 425-431.
}
\author{Jean Thioulouse \email{jean.thioulouse@univ-lyon1.fr}}
\examples{
data(meau)
pcamil <- dudi.pca(meau$mil, scannf = FALSE, nf = 2)
pcafau <- dudi.pca(meau$fau, scale = FALSE, scannf = FALSE, nf = 2)
wgcoia1 <- wgcoia(pcamil, pcafau, meau$plan$sta, scannf = FALSE)
plot(wgcoia1)
}
\keyword{multivariate}
