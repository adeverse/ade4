\name{mbpls}
\alias{mbpls}

\title{Multiblock partial least squares}
\description{Function to perform a multiblock partial least squares (PLS) of several explanatory blocks \eqn{(X_1, \dots, X_k)} defined as an object of class \code{ktab}, to explain a dependent dataset $Y$ defined as an object of class \code{dudi}}
\usage{
mbpls(dudiY, ktabX, scale = TRUE, option = c("uniform", "none"), scannf = TRUE, nf = 2)
}

\arguments{
  \item{dudiY}{an object of class \code{dudi} containing the dependent variables}
  \item{ktabX}{an object of class \code{ktab}  containing the blocks of
    explanatory variables}
  \item{scale}{logical value indicating whether the explanatory variables
    should be standardized}
  \item{option}{an option for the block weighting. If \code{uniform},
  the block weight is equal to $1/K$ for \eqn{(X_1, \dots, X_K)} and to
  $1$ for $X$ and $Y$. If \code{none}, the block weight is equal to the block inertia}
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
\item{Yc1}{matrix of the variable loadings associated with the dependent
  dataset}
\item{cov2}{squared covariance between lY and TlX}
\item{Tc1}{matrix containing the partial loadings associated with each
  explanatory dataset (unit norm)}
\item{TlX}{matrix containing the partial components associated with each explanatory dataset}
\item{faX}{matrix of the regression coefficients of the whole explanatory dataset onto the global components}
\item{XYcoef}{list of matrices of the regression coefficients of the whole explanatory dataset onto the dependent dataset}
\item{bip}{block importances for a given dimension}
\item{bipc}{cumulated block importances for a given number of dimensions}
\item{vip}{variable importances for a given dimension}
\item{vipc}{cumulated variable importances for a given number of dimensions}
}
\references{Bougeard, S., Qannari, E.M., Lupo, C. and Hanafi, M. (2011). From multiblock partial least squares to multiblock redundancy analysis. A continuum approach. \emph{Informatica}, 22(1), 11-26

Bougeard, S. and Dray S. (2018) Supervised Multiblock Analysis in R with the ade4 Package. \emph{Journal of Statistical Software}, \bold{86} (1), 1-17. \url{http://doi.org/10.18637/jss.v086.i01}}

\author{Stéphanie Bougeard (\email{stephanie.bougeard@anses.fr}) and Stéphane Dray (\email{stephane.dray@univ-lyon1.fr})}

\seealso{\code{\link{mbpls}}, \code{\link{testdim.multiblock}},
  \code{\link{randboot.multiblock}}}

\examples{
data(chickenk)
Mortality <- chickenk[[1]]
dudiY.chick <- dudi.pca(Mortality, center = TRUE, scale = TRUE, scannf =
FALSE)
ktabX.chick <- ktab.list.df(chickenk[2:5])
resmbpls.chick <- mbpls(dudiY.chick, ktabX.chick, scale = TRUE,
option = "uniform", scannf = FALSE)
summary(resmbpls.chick)
if(adegraphicsLoaded())
plot(resmbpls.chick)
}

\keyword{multivariate}
