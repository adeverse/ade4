\name{divcmax}
\alias{divcmax}
\title{Maximal value of Rao's diversity coefficient also called 
quadratic entropy}
\description{
For a given dissimilarity matrix, this function calculates the 
maximal value of Rao's diversity coefficient over all frequency 
distribution. It uses an optimization technique based on Rosen's 
projection gradient algorithm and is verified using the 
Kuhn-Tucker conditions.
}
\usage{
divcmax(dis, epsilon, comment)
}
\arguments{
  \item{dis}{an object of class \code{dist} containing distances 
  or dissimilarities among elements.}
  \item{epsilon}{a tolerance threshold : a frequency is non null 
  if it is higher than epsilon.}
  \item{comment}{a logical value indicating whether or not 
  comments on the optimization technique should be printed.}
}
\value{
Returns a list 
  \item{value}{the maximal value of Rao's diversity coefficient.}
  \item{vectors}{a data frame containing four frequency 
  distributions : \code{sim} is a simple distribution which is equal 
  to \eqn{\frac{D1}{1^tD1}}{D1/1^tD1}, \code{pro} is equal to 
  \eqn{\frac{z}{1^tz1}}{z/1^tz1}, where z is the nonnegative 
  eigenvector of the matrix containing the squared dissimilarities 
  among the elements, \code{met} is equal to \eqn{z^2}{z^2}, \code{num} is a
  frequency vector maximizing Rao's diversity coefficient.}
}
\references{
Rao, C.R. (1982) Diversity and dissimilarity coefficients: 
a unified approach. \emph{Theoretical Population Biology}, 
\bold{21}, 24--43.

Gini, C. (1912) Variabilità e mutabilità. 
\emph{Universite di Cagliari III}, Parte II.

Simpson, E.H. (1949) Measurement of diversity. 
\emph{Nature}, \bold{163}, 688.

Champely, S. and Chessel, D. (2002) Measuring biological diversity 
using Euclidean metrics. \emph{Environmental and Ecological Statistics}, 
\bold{9}, 167--177.

Pavoine, S., Ollier, S. and Pontier, D. (2005) 
Measuring diversity from dissimilarities with Rao's quadratic entropy: 
are any dissimilarities suitable? \emph{Theoretical Population Biology},
\bold{67}, 231--239.

}
\author{
Stéphane Champely \email{Stephane.Champely@univ-lyon1.fr} \cr
Sandrine Pavoine \email{pavoine@mnhn.fr}
}
\examples{
data(elec88)

# Dissimilarity matrix.
d0 <- dist(elec88$xy/100)

# Frequency distribution maximizing spatial diversity in France
# according to Rao's quadratic entropy.
France.m <- divcmax(d0)
w0 <- France.m$vectors$num
v0 <- France.m$value
idx <- (1:94) [w0 > 0]

if(!adegraphicsLoaded()) {
  # Smallest circle including all the 94 departments.
  # The squared radius of that circle is the maximal value of the
  # spatial diversity.
  w1 <- elec88$xy[idx, ]/100
  w.c <- apply(w1 * w0[idx], 2, sum)
  plot(elec88$xy[, 1]/100, elec88$xy[, 2]/100, asp=1)
  symbols(w.c[1], w.c[2], circles = sqrt(v0), inches = FALSE, add = TRUE)
  s.value(elec88$xy/100, w0, add.plot = TRUE)
}
}
\keyword{multivariate}
