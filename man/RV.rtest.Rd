\name{RV.rtest}
\alias{RV.rtest}
\title{Monte-Carlo Test on the sum of eigenvalues of a co-inertia analysis (in R).}
\description{
performs a Monte-Carlo Test on the sum of eigenvalues of a co-inertia analysis. 
}
\usage{
RV.rtest(df1, df2, nrepet = 999)
}
\arguments{
  \item{df1, df2}{two data frame with the same rows}
  \item{nrepet}{the number of permutations}
}
\value{
returns a list of class 'rtest'
}
\references{
Heo, M. & Gabriel, K.R. (1997) A permutation test of association between configurations by means of the RV coefficient. Communications in Statistics - Simulation and Computation : 27, 843-856.
}
\examples{
data(doubs)
pca1 <- dudi.pca(doubs$mil, scal = TRUE, scann = FALSE)
pca2 <- dudi.pca(doubs$poi, scal = FALSE, scann = FALSE)
rv1 <- RV.rtest(pca1$tab, pca2$tab, 99)
rv1
plot(rv1)
}
\keyword{multivariate}
\keyword{nonparametric}
