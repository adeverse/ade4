\encoding{latin1}
\name{pcaiv}
\alias{pcaiv}
\alias{plot.pcaiv}
\alias{print.pcaiv}
\title{Principal component analysis with respect to instrumental variables}
\description{
performs a principal component analysis with respect to instrumental variables. 
}
\usage{
pcaiv(dudi, df, scannf = TRUE, nf = 2)
\method{plot}{pcaiv}(x, xax = 1, yax = 2, \dots) 
\method{print}{pcaiv}(x, \dots) 
}
\arguments{
  \item{dudi}{a duality diagram, object of class \code{dudi}}
  \item{df}{a data frame with the same rows}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \cr
  \item{x}{an object of class \code{pcaiv}}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns an object of class \code{pcaiv}, sub-class of class \code{dudi}
  \item{rank}{an integer indicating the rank of the studied matrix}
  \item{nf}{an integer indicating the number of kept axes}
  \item{eig}{a vector with the all eigenvalues}
  \item{lw}{a numeric vector with the row weigths (from \code{dudi})}
  \item{cw}{a numeric vector with the column weigths (from \code{dudi})}
  \item{Y}{a data frame with the dependant variables}
  \item{X}{a data frame with the explanatory variables}
  \item{tab}{a data frame with the modified array (projected variables)}
  \item{c1}{a data frame with the Pseudo Principal Axes (PPA)}
  \item{as}{a data frame with the Principal axes of \code{dudi$tab} on PPA}
  \item{ls}{a data frame with the projections of lines of \code{dudi$tab} on PPA}
  \item{li}{a data frame \code{dudi$ls} with the predicted values by X}
  \item{fa}{a data frame with the loadings (Constraint Principal Components as linear combinations of X}
  \item{l1}{data frame with the Constraint Principal Components (CPC)}
  \item{co}{a data frame with the inner products between the CPC and Y}
  \item{cor}{a data frame with the correlations between the CPC and X }
}
\references{
Rao, C. R. (1964) The use and interpretation of principal component analysis in applied research. \emph{Sankhya}, \bold{A 26}, 329--359.\cr\cr
Obadia, J. (1978) L'analyse en composantes explicatives. \emph{Revue de Statistique Appliquée}, \bold{24}, 5--28.\cr\cr
Lebreton, J. D., Sabatier, R., Banco G. and  Bacou A. M. (1991) 
Principal component and correspondence analyses with respect to instrumental variables : 
an overview of their role in studies of structure-activity and species- environment relationships. 
In J. Devillers and W. Karcher, editors. \emph{Applied Multivariate Analysis in SAR and Environmental Studies}, 
Kluwer Academic Publishers, 85--114.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(rhone)
pca1 <- dudi.pca(rhone$tab, scan = FALSE, nf = 3)
iv1 <- pcaiv(pca1, rhone$disch, scan = FALSE)
iv1
# iner inercum inerC inercumC ratio R2    lambda
# 6.27 6.27    5.52  5.52     0.879 0.671 3.7   
# 4.14 10.4    4.74  10.3     0.984 0.747 3.54  
plot(iv1)
}
\keyword{multivariate}
