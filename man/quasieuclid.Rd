\encoding{latin1}
\name{quasieuclid}
\alias{quasieuclid}
\title{Transformation of a distance matrice to a Euclidean one}
\description{
transforms a distance matrix in a Euclidean one. 
}
\usage{
quasieuclid(distmat)
}
\arguments{
  \item{distmat}{an object of class \code{dist}}
}
\details{
 The function creates a distance matrice with the positive eigenvalues of the Euclidean representation. \cr 
 Only for Euclidean distances which are not Euclidean for numeric approximations (for examples, in papers as the following example).
}
\value{
object of class \code{dist} containing a Euclidean distance matrice
}
\author{
Daniel Chessel  \cr
Stéphane Dray \email{dray@biomserv.univ-lyon1.fr}
}
\examples{
data(yanomama)
geo <- as.dist(yanomama$geo)
is.euclid(geo) # FALSE
geo1 <- quasieuclid(geo)
is.euclid(geo1) # TRUE
par(mfrow = c(2,2))
lapply(yanomama, function(x) plot(as.dist(x), quasieuclid(as.dist(x))))

par(mfrow = c(1,1))}
\keyword{array}
