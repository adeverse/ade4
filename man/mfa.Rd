\encoding{latin1}
\name{mfa}
\alias{mfa}
\alias{print.mfa}
\alias{plot.mfa}
\alias{summary.mfa}
\title{Multiple Factorial Analysis}
\description{
performs a multiple factorial analysis, 
using an object of class \code{ktab}. 
}
\usage{
mfa(X, option = c("lambda1", "inertia", "uniform", "internal"), 
    scannf = TRUE, nf = 3)
plot.mfa (x, xax = 1, yax = 2, option.plot = 1:4, \dots) 
print.mfa (x, \dots) 
summary.mfa (object, \dots) 
}
\arguments{
  \item{X}{K-tables, an object of class \code{ktab}}
  \item{option}{a string of characters for the weighting of arrays options :
    \item{\code{lambda1}}{weighting of group k by the inverse of the first eigenvalue of the k analysis}
    \item{\code{inertia}}{weighting of group k by the inverse of the total inertia of the array k}
    \item{\code{uniform}}{uniform weighting of groups}
    \item{\code{internal}}{weighting included in \code{X$tabw}}
  }
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{x, object}{an object of class 'mfa'}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{option.plot}{an integer between 1 and 4, otherwise the 4 components of the plot are displayed}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
  Returns a list including :
  \item{tab}{a data frame with the modified array}
  \item{rank}{a vector of ranks for the analyses}
  \item{eig}{a numeric vector with the all eigenvalues}
  \item{li}{a data frame with the coordinates of rows}
  \item{TL}{a data frame with the factors associated to the rows (indicators of table)}
  \item{co}{a data frame with the coordinates of columns}
  \item{TC}{a data frame with the factors associated to the columns (indicators of table)}
  \item{blo}{a vector indicating the number of variables for each table}
  \item{lisup}{a data frame with the projections of normalized scores of rows for each table}
  \item{cg}{a data frame with the gravity center for the lisup}
  \item{link}{a data frame containing the projected inertia and the links between the arrays and the reference array}
  \item{corli}{a data frame giving the correlations between the \$lisup and the \$li}
}
\references{Escofier, B. and Pagès, J. (1994) Multiple factor analysis (AFMULT package), \emph{Computational Statistics and Data Analysis}, \bold{18}, 121--140.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(friday87)
w1 <- data.frame(scale(friday87$fau, scal = FALSE))
w2 <- ktab.data.frame(w1, friday87$fau.blo, 
    tabnames = friday87$tab.names)
mfa1 <- mfa(w2, scann = FALSE)
mfa1
plot(mfa1)

data(escopage)
w <- data.frame(scale(escopage$tab))
w <- ktab.data.frame(w, escopage$blo, tabnames = escopage$tab.names)
plot(mfa(w, scann = FALSE))
}
\keyword{multivariate}
