\name{quasieuclid}
\alias{quasieuclid}
\title{Transformation of a distance matrice to an Euclidean one}
\description{
transforms a distance matrix in an Euclidean one. 
}
\usage{
quasieuclid(distmat)
}
\arguments{
  \item{distmat}{an object of class 'dist'}
}
\details{
 The function creates a distance matrice with the positive eigenvalues of the Euclidean representation. \cr 
 Only for Euclidean distances which are not Euclidean for numeric approximations (for examples, in papers as the following example).
}
\value{
object of class 'dist' containing an Euclidean distance matrice
}
\examples{
data(yanomama)
geo <- as.dist(yanomama$geo)
is.euclid(geo) # FALSE
geo1 <- quasieuclid(geo)
is.euclid(geo1) # TRUE
par(mfrow = c(2,2))
lapply(yanomama, function(x) plot(as.dist(x), quasieuclid(as.dist(x))))
}
\keyword{array}
