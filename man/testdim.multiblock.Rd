\name{testdim.multiblock}
\alias{testdim.multiblock}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Selection of the number of dimension by two-fold cross-validation for multiblock methods}
\description{Function to perform a two-fold cross-validation to select the optimal number of dimensions of multiblock methods, \emph{i.e.}, multiblock principal component analysis with instrumental Variables or multiblock partial least squares}
\usage{
\method{testdim}{multiblock}(object, nrepet = 100, quantiles = c(0.25, 0.75), ...)
}

\arguments{
  \item{object}{an object of class multiblock created by \code{\link{mbpls}}
    or \code{\link{mbpcaiv}}}
  \item{nrepet}{integer indicating the number of repetitions}
  \item{quantiles}{a vector indicating the lower and upper quantiles to compute}
  \item{\dots}{other arguments to be passed to methods}
}

\value{An object of class \code{krandxval}}

\references{Stone M. (1974) Cross-validatory choice and assessment of statistical predictions. \emph{Journal of the Royal Statistical Society}, \bold{36}, 111-147.
    
Bougeard, S. and Dray S. (2018) Supervised Multiblock Analysis in R with the ade4 Package. \emph{Journal of Statistical Software}, \bold{86} (1), 1-17. \doi{10.18637/jss.v086.i01}
}

\author{Stéphanie Bougeard (\email{stephanie.bougeard@anses.fr}) and Stéphane Dray (\email{stephane.dray@univ-lyon1.fr})}

\seealso{\code{\link{mbpcaiv}}, \code{\link{mbpls}},
  \code{\link{randboot.multiblock}}, \code{\link{as.krandxval}}}

\examples{
data(chickenk)
Mortality <- chickenk[[1]]
dudiY.chick <- dudi.pca(Mortality, center = TRUE, scale = TRUE, scannf =
FALSE)
ktabX.chick <- ktab.list.df(chickenk[2:5])
resmbpcaiv.chick <- mbpcaiv(dudiY.chick, ktabX.chick, scale = TRUE,
option = "uniform", scannf = FALSE)
## nrepet should be higher for a real analysis
test <- testdim(resmbpcaiv.chick, nrepet = 10)
test
if(adegraphicsLoaded())
plot(test)

}

\keyword{multivariate}
