\name{statis}
\alias{statis}
\alias{print.statis}
\alias{plot.statis}
\title{STATIS, a method for analysing K-tables}
\description{
performs a STATIS analysis of a \code{ktab} object. 
}
\usage{
statis(X, scannf = TRUE, nf = 3, tol = 1e-07)
\method{plot}{statis}(x, xax = 1, yax = 2, option = 1:4, \dots) 
\method{print}{statis}(x, \dots) 
}
\arguments{
  \item{X}{an object of class 'ktab'}
  \item{scannf}{a logical value indicating whether the number of kept axes for the compromise should be asked}
  \item{nf}{if \code{scannf} FALSE, an integer indicating the number of kept axes for the compromise}
  \item{tol}{a tolerance threshold to test whether the distance matrix is Euclidean : an eigenvalue is considered positive if it is larger than \code{-tol*lambda1} where \code{lambda1} is the largest eigenvalue}
  \item{x}{an object of class 'statis'}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{option}{an integer between 1 and 4, otherwise the 4 components of the plot are dispayed}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
\code{statis} returns a list of class 'statis' containing :
  \item{$RV}{a matrix with the all RV coefficients}
  \item{RV.eig}{a numeric vector with all the eigenvalues}
  \item{RV.coo}{a data frame with the array scores}
  \item{tab.names}{a vector of characters with the names of the arrays}
  \item{$RV.tabw}{a numeric vector with the array weigths}
  \item{nf}{an integer indicating the number of kept axes}
  \item{rank}{an integer indicating the rank of the studied matrix}
  \item{C.li}{a data frame with the row coordinates}
  \item{C.Co}{a data frame with the column coordinates}
  \item{C.T4}{a data frame with the principal vectors (for each table)}
  \item{TL}{a data frame with the factors (not used)}
  \item{TC}{a data frame with the factors for Co}
  \item{T4}{a data frame with the factors for T4}
}
\references{
Lavit, C. (1988) \emph{Analyse conjointe de tableaux quantitatifs}, Masson, Paris.\cr\cr
Lavit, C., Escoufier, Y., Sabatier, R. and Traissac, P. (1994) The ACT (Statis method). \emph{Computational Statistics and Data Analysis}, \bold{18}, 97--119.
}
\author{
Daniel Chessel 
}
\examples{
data(jv73)
kta1 <- ktab.within(within.pca(jv73$morpho, jv73$fac.riv, scann = FALSE))
statis1 <- statis(kta1, scann = FALSE)
plot(statis1)

dudi1 <- dudi.pca(jv73$poi, scann = FALSE, scal = FALSE)
wit1 <- within(dudi1, jv73$fac.riv, scann = FALSE)
kta3 <- ktab.within(wit1)
data(jv73)
statis3 <- statis(kta3, scann = FALSE)
plot(statis3)

s.arrow(statis3$C.li, cgrid = 0)

kplot(statis3, traj = TRUE, arrow = FALSE, unique = TRUE, 
    clab = 0, csub = 3, cpoi = 3)
statis3
}
\keyword{multivariate}
