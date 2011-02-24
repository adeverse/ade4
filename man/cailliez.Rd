\encoding{latin1}
\name{cailliez}
\alias{cailliez}
\title{Transformation to make Euclidean a distance matrix}
\description{
This function computes the smallest positive constant that makes Euclidean a distance matrix
and applies it. 
}
\usage{
cailliez(distmat, print = FALSE, tol = 1e-07, cor.zero = TRUE)
}
\arguments{
  \item{distmat}{an object of class \code{dist}}
  \item{print}{if TRUE, prints the eigenvalues of the matrix}
  \item{tol}{a tolerance threshold for zero}
  \item{cor.zero}{if TRUE, zero distances are not modified}
}
\value{
an object of class \code{dist} containing a Euclidean distance matrix.
}
\references{
Cailliez, F. (1983) The analytical solution of the additive constant problem. \emph{Psychometrika}, \bold{48}, 305--310.\cr

Legendre, P. and Anderson, M.J. (1999) Distance-based redundancy analysis: testing multispecies responses in multifactorial ecological experiments. \emph{Ecological Monographs}, \bold{69}, 1--24.\cr

Legendre, P., and Legendre, L. (1998) \emph{Numerical ecology}, 2nd English edition edition. Elsevier Science BV, Amsterdam.\cr

From the DistPCoa program of P. Legendre et M.J. Anderson\cr
\url{http://www.fas.umontreal.ca/BIOL/Casgrain/en/labo/distpcoa.html}
}
\author{
Daniel Chessel  \cr
Stéphane Dray \email{dray@biomserv.univ-lyon1.fr}
}
\examples{
data(capitales)
d0 <- as.dist(capitales$df)
is.euclid(d0) # FALSE
d1 <- cailliez(d0, TRUE)
# Cailliez constant = 2429.87867 
is.euclid(d1) # TRUE
plot(d0, d1)
abline(lm(unclass(d1)~unclass(d0)))
print(coefficients(lm(unclass(d1)~unclass(d0))), dig = 8) # d1 = d + Cte
is.euclid(d0 + 2428) # FALSE
is.euclid(d0 + 2430) # TRUE the smallest constant
}
\keyword{array}
