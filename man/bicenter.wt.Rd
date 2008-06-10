\name{bicenter.wt}
\alias{bicenter.wt}
\title{Double Weighted Centring}
\description{
This function creates a doubly centred matrix. 
}
\usage{
bicenter.wt(X, row.wt = rep(1, nrow(X)), col.wt = rep(1, ncol(X)))
}
\arguments{
  \item{X}{a matrix with n rows and p columns}
  \item{row.wt}{a vector of positive or null weights of length n}
  \item{col.wt}{a vector of positive or null weights of length p}
}
\value{
returns a doubly centred matrix
}
\author{
Daniel Chessel 
}
\examples{
w <- matrix(1:6, 3, 2)
bicenter.wt(w, c(0.2,0.6,0.2), c(0.3,0.7))

w <- matrix(1:20, 5, 4)
sum(bicenter.wt(w, runif(5), runif(4))^2)
}
\keyword{utilities}
