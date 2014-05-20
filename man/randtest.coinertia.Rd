\encoding{latin1}
\name{randtest.coinertia}
\alias{randtest.coinertia}
\title{Monte-Carlo test on a Co-inertia analysis (in C).}
\description{
Performs a Monte-Carlo test on a Co-inertia analysis. 
}
\usage{
\method{randtest}{coinertia}(xtest, nrepet = 999, fixed=0, \dots)
}
\arguments{
  \item{xtest}{an object of class \code{coinertia}}
  \item{nrepet}{the number of permutations}
  \item{fixed}{when non uniform row weights are used in the coinertia analysis,
this parameter must be the number of the table that should be kept fixed in the permutations}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
a list of the class \code{randtest}
}
\references{
Dolédec, S. and Chessel, D. (1994) Co-inertia analysis: an alternative method for
studying species-environment relationships. \emph{Freshwater Biology}, \bold{31}, 277--294.
}
\author{Jean Thioulouse \email{Jean.Thioulouse@univ-lyon1.fr} modified by Stephane Dray \email{stephane.dray@univ-lyon1.fr}}
\note{A testing procedure based on the total coinertia of the analysis
  is available by the function \code{randtest.coinertia}. The function
  allows to deal with various analyses for the two tables. The test is
  based on random permutations of the rows of the two tables. If the row
  weights are not uniform, mean and variances are recomputed for each
  permutation (PCA); for MCA, tables are recentred and column weights are recomputed. If weights are computed using the data contained in one
  table (e.g. COA), you must fix this table and permute only the rows of
  the other table. The case of decentred PCA (PCA where centers are
  entered by the user) is not yet implemented. If you want to use the
  testing procedure for this case, you must firstly center the table and then perform a
  non-centered PCA on the modified table. The case where one table is
  treated by hill-smith analysis (mix of quantitative and qualitative
  variables) will be soon implemented.}

\examples{
data(doubs)
dudi1 <- dudi.pca(doubs$env, scale = TRUE, scan = FALSE, nf = 3)
dudi2 <- dudi.pca(doubs$fish, scale = FALSE, scan = FALSE, nf = 2)
coin1 <- coinertia(dudi1,dudi2, scan = FALSE, nf = 2)
plot(randtest(coin1))
 }
\keyword{multivariate}
\keyword{nonparametric}
