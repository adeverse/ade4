\name{RV.randtest}
\alias{RV.randtest}
\title{Monte-Carlo Test on the sum of eigenvalues of a co-inertia analysis (in C++ with Rcpp).}
\description{
performs a Monte-Carlo Test on the sum of eigenvalues of a co-inertia analysis. 
}
\usage{
RV.randtest(df1, df2, nrepet = 999, ...)
}
\arguments{
  \item{df1, df2}{two data frames with the same rows}
  \item{nrepet}{the number of permutations}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns a list of class 'randtest'
}
\references{
Heo, M. & Gabriel, K.R. (1997) A permutation test of association between configurations by means of the RV coefficient. 
Communications in Statistics - Simulation and Computation, \bold{27}, 843-856.
}
\author{Daniel Chessel and Jean Thioulouse}
\examples{
data(doubs)
pca1 <- dudi.pca(doubs$env, scal = TRUE, scann = FALSE)
pca2 <- dudi.pca(doubs$fish, scal = FALSE, scann = FALSE)
rv1 <- RV.randtest(pca1$tab, pca2$tab, 99)
rv1
plot(rv1)
}
\keyword{multivariate}
\keyword{nonparametric}
