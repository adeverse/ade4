\name{sepan}
\alias{sepan}
\alias{plot.sepan}
\alias{print.sepan}
\alias{summary.sepan}
\title{Separated Analyses in a K-tables}
\description{
performs K separated multivariate analyses of an object of class \code{ktab} 
containing K tables. 
}
\usage{
sepan(X, nf = 2)
plot.sepan (x, mfrow = NULL, csub = 2, \dots)
summary.sepan (object, \dots)
print.sepan (x, \dots)
}
\arguments{
  \item{X}{an object of class 'ktab'}
  \item{nf}{an integer indicating the number of kept axes for each separated analysis}  
  \item{x, object}{an object of class 'sepan'}
  \item{mfrow}{a vector of the form "c(nr,nc)", otherwise computed by a special own function \code{n2mfrow}}
  \item{csub}{a character size for the sub-titles, used with \code{par("cex")*csub}}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns a list of class 'sepan' containing :
  \item{call}{a call order}
  \item{tab.names}{a vector of characters with the names of tables}
  \item{blo}{a numeric vector with the numbers of columns for each table}
  \item{rank}{a numeric vector with the rank of the studied matrix for each table}
  \item{Eig}{a numeric vector with all the eigenvalues}
  \item{Li}{a data frame with the row coordinates}
  \item{L1}{a data frame with the row normed scores}
  \item{Co}{a data frame with the column coordinates}
  \item{C1}{a data frame with the column normed coordinates}
  \item{TL}{a data frame with the factors for Li L1}
  \item{TC}{a data frame with the factors for Co C1}
}
\details{
The function plot on a 'sepan' object allows to compare inertias and structures between arrays.
In black, the eigenvalues of kept axes in the object 'sepan'.
}
\examples{
data(escopage)
w <- data.frame(scale(escopage$tab))
w <- ktab.data.frame(w, escopage$blo, tabnames = escopage$tab.names)
sep1 <- sepan(w)
sep1
summary(sep1)
plot(sep1)
}
\keyword{multivariate}
