\name{procuste.randtest}
\alias{procuste.randtest}
\title{
    Monte-Carlo Test on the sum of the singular values of a procustean rotation (in C).
}
\description{
performs a Monte-Carlo Test on the sum of the singular values of a procustean rotation. 
}
\usage{
procuste.randtest(df1, df2, nrepet = 999)
}
\arguments{
  \item{df1}{a data frame}
  \item{df2}{a data frame}
  \item{nrepet}{the number of permutations}
}
\value{
returns a list of class \code{randtest}
}
\references{
Jackson, D.A. (1995) PROTEST: a PROcustean randomization TEST of community environment concordance. \emph{Ecosciences}, \bold{2}, 297--303.
}
\author{Jean Thioulouse \email{Jean.Thioulouse@univ-lyon1.fr}}
\examples{
data(doubs)
pca1 <- dudi.pca(doubs$env, scal = TRUE, scann = FALSE)
pca2 <- dudi.pca(doubs$fish, scal = FALSE, scann = FALSE)
protest1 <- procuste.randtest(pca1$tab, pca2$tab, 999)
protest1
plot(protest1,main="PROTEST")
}
\keyword{multivariate}
\keyword{nonparametric}
