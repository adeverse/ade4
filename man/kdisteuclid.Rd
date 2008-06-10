\encoding{latin1}
\name{kdisteuclid}
\alias{kdisteuclid}
\title{ a way to obtain Euclidean distance matrices }
\description{
 a way to obtain Euclidean distance matrices
}
\usage{
kdisteuclid(obj, method = c("lingoes", "cailliez", "quasi"))
}
\arguments{
  \item{obj}{ an object of class \code{kdist} }
  \item{method}{ a method to convert a distance matrix in a Euclidean one }
}
\value{
returns an object of class \code{kdist} with all distances Euclidean. 
}
\references{ 
Gower, J.C. and Legendre, P. (1986) Metric and Euclidean properties of dissimilarity coefficients. \emph{Journal of Classification},  \bold{3}, 5--48.

Cailliez, F. (1983) The analytical solution of the additive constant problem. \emph{Psychometrika},  \bold{48}, 305--310.

Lingoes, J.C. (1971) Somme boundary conditions for a monotone analysis of symmetric matrices. \emph{Psychometrika}, \bold{36}, 195--203.

Legendre, P. and Anderson, M.J. (1999) Distance-based redundancy analysis: testing multispecies responses in multifactorial ecological experiments. \emph{Ecological Monographs}, \bold{69}, 1--24.

Legendre, P., and L. Legendre. (1998) Numerical ecology, 2nd English edition edition. Elsevier Science BV, Amsterdam. 
}
\author{
Daniel Chessel  \cr
Stéphane Dray \email{dray@biomserv.univ-lyon1.fr}
}
\note{ according to the program DistPCoa of P. Legendre and M.J. Anderson\cr
\url{http://www.fas.umontreal.ca/BIOL/Casgrain/en/labo/distpcoa.html}
}
\examples{
w <- c(0.8,0.8,0.377350269,0.8,0.377350269,0.377350269) # see ref.
w <- kdist(w)
w1 <- c(kdisteuclid(kdist(w), "lingoes"), kdisteuclid(kdist(w), "cailliez"),
    kdisteuclid(kdist(w), "quasi"))
print(w, print = TRUE)
print(w1, print = TRUE)

data(eurodist)
par(mfrow = c(1, 3))
eu1 <- kdist(eurodist) # an object of class 'dist'
plot(data.frame(unclass(c(eu1, kdisteuclid(eu1, "quasi")))), asp = 1)
title(main = "Quasi") ; abline(0,1)
plot(data.frame(unclass(c(eu1, kdisteuclid(eu1, "lingoes")))), asp = 1)
title(main = "Lingoes") ; abline(0,1)
plot(data.frame(unclass(c(eu1, kdisteuclid(eu1, "cailliez")))), asp = 1)
title(main = "Cailliez") ; abline(0,1)
}
\keyword{ multivariate }
\keyword{ utilities }
