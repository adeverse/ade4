\name{randboot.multiblock}
\alias{randboot.multiblock}
\title{Bootstraped simulations for multiblock methods}
\description{Function to perform bootstraped simulations for multiblock
  principal component analysis with instrumental variables or multiblock
  partial least squares, in order to get confidence intervals for some parameters, \emph{i.e.}, regression coefficients, variable and block importances}
\usage{
\method{randboot}{multiblock}(object, nrepet = 199, optdim, ...)
}

\arguments{
  \item{object}{an object of class multiblock created by \code{\link{mbpls}}
    or \code{\link{mbpcaiv}}}
  \item{nrepet}{integer indicating the number of repetitions}
  \item{optdim}{integer indicating the optimal number of dimensions, \emph{i.e.}, the optimal number of global components to be introduced in the model}
  \item{\dots}{other arguments to be passed to methods}
}

\value{A list containing objects of class \code{krandboot}}

\references{Carpenter, J. \& Bithell, J. (2000) Bootstrap confidence intervals: when, which, what? A practical guide for medical statisticians.\emph{Statistics in medicine}, 19, 1141-1164}
\author{St\'ephanie Bougeard (\email{stephanie.bougeard@anses.fr}) and St\'ephane Dray (\email{stephane.dray@univ-lyon1.fr})}

\seealso{\code{\link{mbpcaiv}}, \code{\link{mbpls}},
  \code{\link{testdim.multiblock}}, \code{\link{as.krandboot}}}
\examples{
data(chickenk)
Mortality <- chickenk[[1]]
dudiY.chick <- dudi.pca(Mortality, center = TRUE, scale = TRUE, scannf =
FALSE)
ktabX.chick <- ktab.list.df(chickenk[2:5])
resmbpcaiv.chick <- mbpcaiv(dudiY.chick, ktabX.chick, scale = TRUE,
option = "uniform", scannf = FALSE, nf = 4)
## nrepet should be higher for a real analysis
test <- randboot(resmbpcaiv.chick, optdim = 4, nrepet = 10)
test
if(adegraphicsLoaded())
plot(test$bipc) 
}

\keyword{multivariate}
