\name{RVintra.randtest}
\alias{RVintra.randtest}
\title{Monte-Carlo Test on the sum of eigenvalues of a within-class co-inertia analysis (in C++ with Rcpp).}
\description{
performs a Monte-Carlo Test on the sum of eigenvalues of a within-class co-inertia analysis. 
}
\usage{
RVintra.randtest(df1, df2, fac, nrepet = 999, ...)
}
\arguments{
  \item{df1, df2}{two data frames with the same rows}
  \item{fac}{the factor defining classes}
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
data(meaudret)
pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 4)
pca2 <- dudi.pca(meaudret$spe, scal = FALSE, scan = FALSE, nf = 4)
wit1 <- wca(pca1, meaudret$design$season, scan = FALSE, nf = 2)
wit2 <- wca(pca2, meaudret$design$season, scan = FALSE, nf = 2)
coiw <- coinertia(wit1, wit2, scann = FALSE)
rv1 <- RVintra.randtest(pca1$tab, pca2$tab, meaudret$design$season, nrep=999)
rv1
plot(rv1)
}
\keyword{multivariate}
\keyword{nonparametric}
