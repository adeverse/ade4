\name{dpcaiv}
\alias{dpcaiv}
\alias{plot.dpcaiv}
\alias{print.dpcaiv}
\alias{summary.dpcaiv}
\alias{randtest.dpcaiv}
\alias{dvaripart}
\alias{print.dvaripart}

\title{Double principal component analysis with respect to instrumental variables}
\description{
It includes double redundancy analysis (RDA, if \code{dudi} argument is created with 
\code{dudi.pca}) and double canonical correspondence analysis (CCA, if \code{dudi} 
argument is created with \code{dudi.coa}) as special cases. The function \code{dvaripart} 
computed associated double (by row and column) variation partitioning.
}
\usage{
dpcaiv(dudi, dfR = NULL, dfQ = NULL, scannf = TRUE, nf = 2)
\method{plot}{dpcaiv}(x, xax = 1, yax = 2, \dots) 
\method{print}{dpcaiv}(x, \dots)
\method{summary}{dpcaiv}(object, \dots) 
\method{randtest}{dpcaiv}(xtest, nrepet = 99, \dots)
dvaripart(Y, dfR, dfQ, nrepet = 999, scale = FALSE, \dots)
\method{print}{dvaripart}(x, \dots)
}
\arguments{
  \item{dudi}{a duality diagram, object of class \code{dudi}}
  \item{Y}{a duality diagram, object of class \code{dudi} or a response \code{data.frame}}
  \item{dfR}{a data frame with external variables relative to rows of the 
  \code{dudi} object}
  \item{dfQ}{a data frame with external variables relative to columns of the 
  \code{dudi} object}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \cr
  \item{x, object, xtest}{an object of class \code{dpcaiv} or \code{dvaripart}}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{nrepet}{an integer indicating the number of permutations}
  \item{scale}{If \code{Y} is not a dudi, a \code{logical} indicating if 
  variables should be scaled}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns an object of class \code{dpcaiv}, sub-class of class \code{dudi}
  \item{tab}{a data frame with the modified array (predicted table)}
  \item{cw}{a numeric vector with the column weigths (from \code{dudi})}
  \item{lw}{a numeric vector with the row weigths (from \code{dudi})}
  \item{eig}{a vector with the all eigenvalues}
  \item{rank}{an integer indicating the rank of the studied matrix}
  \item{nf}{an integer indicating the number of kept axes}
  \item{c1}{a data frame with the Constrained Principal Axes (CPA)}
  \item{faQ}{a data frame with the loadings for Q to build the CPA as a linear combination}
  \item{li}{a data frame with the constrained (by R) row score (LC score)}
  \item{lsR}{a data frame with the unconstrained row score (WA score)}  
  \item{l1}{data frame with the Constrained Principal Components (CPC)}  
  \item{faR}{a data frame with the loadings for R to build the CPC as a linear combination}
  \item{co}{a data frame with the constrained (by Q) column score (LC score)}
  \item{lsQ}{a data frame with the unconstrained column score (WA score)}
  
  
  \item{call}{the matched call}
  \item{Y}{a data frame with the dependant variables}
  \item{R}{a data frame with the explanatory variables for rows}
  \item{Q}{a data frame with the explanatory variables for columns}
    
  \item{asR}{a data frame with the Principal axes of \code{dudi$tab} on CPA}
  \item{asQ}{a data frame with the Principal components of \code{dudi$tab} on CPC}
  \item{corR}{a data frame with the correlations between the CPC and R }
  \item{corQ}{a data frame with the correlations between the CPA and Q }
}
\references{
Rao, C. R. (1964) The use and interpretation of principal component analysis in applied research. \emph{Sankhya}, \bold{A 26}, 329--359.\cr\cr
Obadia, J. (1978) L'analyse en composantes explicatives. \emph{Revue de Statistique Appliquee}, \bold{24}, 5--28.\cr\cr
Lebreton, J. D., Sabatier, R., Banco G. and  Bacou A. M. (1991) 
Principal component and correspondence analyses with respect to instrumental variables : 
an overview of their role in studies of structure-activity and species- environment relationships. 
In J. Devillers and W. Karcher, editors. \emph{Applied Multivariate Analysis in SAR and Environmental Studies}, 
Kluwer Academic Publishers, 85--114.

Ter Braak, C. J. F. (1986) Canonical correspondence analysis : a new eigenvector technique for multivariate direct gradient analysis. \emph{Ecology}, \bold{67}, 1167--1179.\cr\cr
Ter Braak, C. J. F. (1987) The analysis of vegetation-environment relationships by canonical correspondence analysis. \emph{Vegetatio}, \bold{69}, 69--77.\cr\cr
Chessel, D., Lebreton J. D. and Yoccoz N. (1987) Propriétés de l'analyse canonique des correspondances. Une utilisation en hydrobiologie. \emph{Revue de Statistique Appliquée}, \bold{35}, 55--72.\cr\cr
}
\author{
Stéphane Dray \email{stephane.dray@univ-lyon1.fr}\cr
Lisa Nicvert}
\examples{
# example of a double canonical correspondence analysis
data(aviurba)
coa <- dudi.coa(aviurba$fau, scannf = FALSE)
dcca <- dpcaiv(coa, aviurba$mil, aviurba$trait, scannf = FALSE)
dcca
summary(dcca)
plot(dcca)
randtest(dcca)
dvaripart(coa, aviurba$mil, aviurba$trait, nrepet = 99)
}
\keyword{multivariate}
