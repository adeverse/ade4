\encoding{latin1}
\name{dist.quant}
\alias{dist.quant}
\title{Computation of Distance Matrices on Quantitative Variables}
\description{
computes on quantitative variables, some distance matrices as canonical, Joreskog and Mahalanobis. 
}
\usage{
dist.quant(df, method = NULL, diag = FALSE, upper = FALSE, 
    tol = 1e-07)
}
\arguments{
  \item{df}{a data frame containing only quantitative variables}
  \item{method}{an integer between 1 and 3. If NULL the choice is made with a console message. See details}
  \item{diag}{a logical value indicating whether the diagonal of the distance matrix should be printed by `print.dist'}
  \item{upper}{a logical value indicating whether the upper triangle of the distance matrix should be printed by `print.dist'}
  \item{tol}{used in case 3 of \code{method} as a tolerance threshold for null eigenvalues}
}
\details{
All the distances are of type \eqn{d=\|x-y\|_A =
  \sqrt{(x-y)^{t}A(x-y)}}{d = ||x-y||_A = sqrt((x-y)^t A (x-y))}
\describe{
  \item{1 = Canonical}{A = Identity}
  \item{2 = Joreskog}{\eqn{A=\frac{1}{diag(cov)}}{A = 1 / diag(cov)}}
  \item{3 = Mahalanobis}{A = inv(cov)} 
}
}
\value{
an object of class \code{dist}
}
\author{
Daniel Chessel  \cr
Stéphane Dray \email{dray@biomserv.univ-lyon1.fr}
}
\examples{
data(ecomor)
par(mfrow = c(2,2))
scatter(dudi.pco(dist.quant(ecomor$morpho,3), scan = FALSE))
scatter(dudi.pco(dist.quant(ecomor$morpho,2), scan = FALSE))
scatter(dudi.pco(dist(scalewt(ecomor$morpho)), scan = FALSE))
scatter(dudi.pco(dist.quant(ecomor$morpho,1), scan = FALSE))
par(mfrow = c(1,1))}
\keyword{array}
\keyword{multivariate}
