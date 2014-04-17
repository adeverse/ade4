\name{mbpcaiv}
\alias{mbpcaiv}

\title{Multiblock principal component analysis with instrumental variables}
\description{Function to perform a multiblock redundancy analysis of several explanatory blocks \eqn{(X_1, \dots, X_k)}, defined as an object of class \code{ktab}, to explain a dependent dataset $Y$, defined as an object of class \code{dudi}}
\usage{
mbpcaiv(dudiY, ktabX, scale = TRUE, option = c("uniform", "none"), scannf = TRUE, nf = 2)
}

\arguments{
  \item{dudiY}{an object of class \code{dudi} containing the dependent variables}
  \item{ktabX}{an object of class \code{ktab}  containing the blocks of
    explanatory variables}
\item{scale}{logical value indicating whether the explanatory variables
  should be standardized}
\item{option}{an option for the block weighting:
  \option{uniform}{the block weight is equal to $1/K$ for \eqn{(X_1, \dots, X_K)} and to $1$ for $X$ and $Y$}
  \option{none}{the block weight is equal to the block inertia}}
\item{scannf}{logical value indicating whether the eigenvalues bar plot should be displayed}
\item{nf}{integer indicating the number of kept dimensions}
}


\value{A list containing the following components is returned:
\item{call}{the matching call}
\item{tabY}{data frame of dependent variables centered, eventually scaled (if \option{scale=TRUE}) and weighted (if \option{option="uniform"})}
\item{tabX}{data frame of explanatory variables centered, eventually scaled (if \option{scale=TRUE}) and weighted (if \option{option="uniform"})}
\item{TL, TC}{data frame useful to manage graphical outputs}
\item{nf}{numeric value indicating the number of kept dimensions}
\item{lw}{numeric vector of row weights}
\item{X.cw}{numeric vector of column weighs for the explanalatory dataset}
\item{blo}{vector of the numbers of variables in each explanatory dataset}
\item{rank}{maximum rank of the analysis}
\item{eig}{numeric vector containing the eigenvalues}
\item{lX}{matrix of the global components associated with the whole explanatory dataset (scores of the individuals)}
\item{lY}{matrix of the components associated with the dependent dataset}
\item{Yc1}{matrix of the variable loadings associated with the dependent dataset}
\item{Tli}{matrix containing the partial components associated with each explanatory dataset}
\item{Tl1}{matrix containing the normalized partial components associated with each explanatory dataset}
\item{Tfa}{matrix containing the partial loadings associated with each explanatory dataset}
\item{cov2}{squared covariance between lY and Tl1}
\item{Yco}{matrix of the regression coefficients of the dependent dataset onto the global components}
\item{faX}{matrix of the regression coefficients of the whole explanatory dataset onto the global components}
\item{XYcoef}{list of matrices of the regression coefficients of the whole explanatory dataset onto the dependent dataset}
\item{bip}{block importances for a given dimension}
\item{bipc}{cumulated block importances for a given number of dimensions}
\item{vip}{variable importances for a given dimension}
\item{vipc}{cumulated variable importances for a given number of dimensions}
}
\references{Bougeard, S., Qannari, E.M. \& Rose, N. (2011) Multiblock Redundancy Analysis: interpretation tools and application in epidemiology. \emph{Journal of Chemometrics}, 23, 1-9}
\author{St\'ephanie Bougeard (\email{stephanie.bougeard@anses.fr}) and St\'ephane Dray (\email{stephane.dray@univ-lyon1.fr})}

\seealso{\code{\link{mbpls}}, \code{\link{testdim.multiblock}}, \code{\link{randboot.multiblock}}}
\examples{
data(chickenk)
Mortality <- chickenk[[1]]
dudiY.chick <- dudi.pca(Mortality, center = TRUE, scale = TRUE, scannf =
FALSE)
ktabX.chick <- ktab.list.df(chickenk[2:5])
resmbpcaiv.chick <- mbpcaiv(dudiY.chick, ktabX.chick, scale = TRUE,
option = "uniform", scannf = FALSE)
summary(resmbpcaiv.chick)
if(adegraphicsLoaded())
plot(resmbpcaiv.chick)
}


\keyword{multivariate}

