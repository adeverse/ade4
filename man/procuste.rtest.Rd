\name{procuste.rtest}
\alias{procuste.rtest}
\title{
    Monte-Carlo Test on the sum of the singular values of a procustean rotation (in R).
}
\description{
performs a Monte-Carlo Test on the sum of the singular values of a procustean rotation. 
}
\usage{
procuste.rtest(df1, df2, nrepet = 99)
}
\arguments{
  \item{df1}{a data frame}
  \item{df2}{a data frame}
  \item{nrepet}{the number of permutations}
}
\value{
returns a list of class \code{rtest}
}
\references{
Jackson, D.A. (1995) PROTEST: a PROcustean randomization TEST of community environment concordance. \emph{Ecosciences}, \bold{2}, 297--303.
}
\examples{
data(doubs)
pca1 <- dudi.pca(doubs$mil, scal = TRUE, scann = FALSE)
pca2 <- dudi.pca(doubs$poi, scal = FALSE, scann = FALSE)
proc1 <- procuste(pca1$tab, pca2$tab)
protest1 <- procuste.rtest(pca1$tab, pca2$tab, 999)
protest1
plot(protest1)
}
\keyword{multivariate}
\keyword{nonparametric}
