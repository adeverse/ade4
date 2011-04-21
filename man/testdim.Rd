\name{testdim}
\alias{testdim}
\alias{testdim.pca}
\title{ Function to perform a test of dimensionality}
\description{
This functions allow to test for the number of axes in multivariate analysis. The
procedure is only implemented for principal component analysis on
correlation matrix. The procedure is based on the computation of the RV coefficient.
}
\usage{
testdim(dudi, ...)
\method{testdim}{pca}(dudi, nrepet = 99, nbax = dudi$rank, alpha = 0.05, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dudi}{ a duality diagram (an object of class \code{dudi})}
  \item{nrepet}{ the number of repetitions for the permutation procedure}
  \item{nbax}{ the number of axes to be tested, by default all axes}
  \item{alpha}{ the significance level}
  \item{\dots}{ other arguments}

}

\value{
  An object of the class \code{krandtest}. It contains also:
  \item{nb}{The estimated number of axes to keep}
  \item{nb.cor}{The number of axes to keep estimated using a sequential Bonferroni
  procedure}
}
\references{
  Dray, S. (2007) On the number of principal components: A test of
  dimensionality based on measurements of similarity between
  matrices. \emph{Computational Statistics and Data Analysis}, in press.
}
\author{ Stephane Dray \email{dray@biomserv.univ-lyon1.fr}}
\seealso{\code{\link{dudi.pca}}, \code{\link{RV.rtest}} }
\examples{
tab <- data.frame(matrix(rnorm(200),20,10))
pca1 <- dudi.pca(tab,scannf=FALSE)
test1 <- testdim(pca1)
test1
test1$nb
test1$nb.cor
data(doubs)
pca2 <- dudi.pca(doubs$env,scannf=FALSE)
test2 <- testdim(pca2)
test2
test2$nb
test2$nb.cor
}
\keyword{ multivariate }

