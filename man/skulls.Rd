\name{skulls}
\alias{skulls}
\docType{data}
\title{Morphometric Evolution}
\description{
This data set gives four anthropometric measures of 30 egyptean 
skulls belonging to five different historical periods. 
}
\usage{data(skulls)}
\format{
The \code{skulls} data frame has 150 rows and 4 columns.
The measurements are made on 5 groups and 30 Egyptian skulls. The groups are defined as follows :\cr
1 - the early predynastic period (circa 4000 BC)\cr
2 - the late predynastic period (circa 3300 BC)\cr
3 - the 12th and 13th dynasties (circa 1850 BC)\cr
4 - the Ptolemiac period (circa 200 BC)\cr
5 - the Roman period (circa 150 BC)\cr
}
\source{
Thompson, A. and Randall-Maciver, R. (1905) \emph{Ancient races of the Thebaid}, Oxford University Press.
}
\references{
Manly, B.F. (1994) \emph{Multivariate Statistical Methods.\cr
A primer}, Second edition. Chapman & Hall, London. 1--215.\cr
The example is treated pp. 6, 13, 51, 64, 72, 107, 112 et 117.
}
\examples{
data(skulls)
pca1 <- dudi.pca(skulls, scan = FALSE)
fac <- gl(5, 30)
levels(fac) <- c("-4000", "-3300", "-1850", "-200", "+150")
dis.skulls <- discrimin(pca1, fac, scan = FALSE)
plot(dis.skulls, 1, 1)
}
\keyword{datasets}
