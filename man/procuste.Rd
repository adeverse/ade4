\name{procuste}
\alias{procuste}
\alias{plot.procuste}
\alias{print.procuste}
\title{Simple Procruste Rotation between two sets of points}
\description{
performs a simple procruste rotation between two sets of points. 
}
\usage{
procuste(df1, df2, scale = TRUE, nf = 4, tol = 1e-07) 
plot.procuste (x, xax = 1, yax = 2, \dots)
print.procuste (x, \dots)
}
\arguments{
  \item{df1, df2}{two data frame with the same rows}
  \item{scale}{a logical value indicating whether a transformation by the Gower's scaling (1971) should be applied}
  \item{nf}{an integer indicating the number of kept axes}
  \item{tol}{a tolerance threshold to test whether the distance matrix is Euclidean : an eigenvalue is considered positive if it is larger than \code{-tol*lambda1} where \code{lambda1} is the largest eigenvalue.}
  \cr
  \item{x}{an objet of class 'procuste'}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns a list of 9 components of the class 'procuste'
  \item{d}{a numeric vector of the singular values}
  \item{rank}{an integer indicating the rank of the crossed matrix}
  \item{nfact}{an integer indicating the number of kept axes}
  \item{tab1}{a data frame with the array 1, possibly scaled}
  \item{tab2}{a data frame with the array 2, possibly scaled}
  \item{rot1}{a data frame with the result of the rotation from array 1 to array 2}
  \item{rot2}{a data frame with the result of the rotation from array 2 to array 1}
  \item{load1}{a data frame with the loadings of array 1}
  \item{load2}{a data frame with the loadings of array 2}
  \item{scor1}{a data frame with the scores of array 1}
  \item{scor2}{a data frame with the scores of array 2}
  \item{call}{a call order of the analysis}
}
\references{
Digby, P. G. N. and Kempton, R. A. (1987) Multivariate Analysis of Ecological Communities. \emph{Population and Community Biology Series}, Chapman and Hall, London.\cr\cr
Gower, J.C. (1971) Statistical methods of comparing different multivariate analyses of the same data. In \emph{Mathematics in the archaeological and historical sciences}, Hodson, F.R, Kendall, D.G. & Tautu, P. (Eds.) University Press, Edinburgh,  138--149.\cr\cr
Schönemann, P.H. (1968) On two-sided Procustes problems. \emph{Psychometrika}, \bold{33}, 19--34.\cr\cr
Torre, F. and Chessel, D. (1994) Co-structure de deux tableaux totalement appariés. \emph{Revue de Statistique Appliquée}, \bold{43}, 109--121.\cr
Dray, S., Chessel, D. and Thioulouse, J.  (2002) Procustean co-inertia analysis for the linking of multivariate datasets. \emph{Ecoscience}, in press
}
\examples{
data(macaca)
par(mfrow = c(2,2))
pro1 <- procuste(macaca$xy1, macaca$xy2, scal = FALSE)
s.match(pro1$tab1, pro1$rot2, clab = 0.7)
s.match(pro1$tab2, pro1$rot1, clab = 0.7)
pro2 <- procuste(macaca$xy1, macaca$xy2)
s.match(pro2$tab1, pro2$rot2, clab = 0.7)
s.match(pro2$tab2, pro2$rot1, clab = 0.7)

data(doubs)
pca1 <- dudi.pca(doubs$mil, scal = TRUE, scann = FALSE)
pca2 <- dudi.pca(doubs$poi, scal = FALSE, scann = FALSE)
pro3 <- procuste(pca1$tab, pca2$tab, nf = 2)
par(mfrow = c(2,2))
s.traject(pro3$scor1, clab = 0)
s.label(pro3$scor1, clab = 0.8, add.p = TRUE)
s.traject(pro3$scor2, clab = 0)
s.label(pro3$scor2, clab = 0.8, add.p = TRUE)
s.arrow(pro3$load1, clab = 0.75)
s.arrow(pro3$load2, clab = 0.75)
plot(pro3)

data(fruits)
plot(procuste(scalewt(fruits$jug), scalewt(fruits$var)))
}
\keyword{multivariate}
