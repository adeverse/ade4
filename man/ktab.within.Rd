\name{ktab.within}
\alias{ktab.within}
\title{Process to go from a Within Analysis to a K-tables}
\description{
performs the process to go from a Within Analysis to a K-tables. 
}
\usage{
ktab.within(dudiwit, rownames = NULL, colnames = NULL, tabnames = NULL)
}
\arguments{
  \item{dudiwit}{an objet of class \code{within}}
  \item{rownames}{the row names of the K-tables (otherwise the row names of \code{dudiwit$tab})}
  \item{colnames}{the column names of the K-tables (otherwise the column names of \code{dudiwit$tab})}
  \item{tabnames}{the names of the arrays of the K-tables (otherwise the levels of the factor which defines the within-classes)}
}
\value{
a list of class \code{ktab}. See \code{\link{ktab}}
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\examples{
data(bacteria)
w1 <- data.frame(t(bacteria$espcodon))
dudi1 <- dudi.coa(w1, scann = FALSE, nf = 4)
wit1 <- within(dudi1, bacteria$code, scannf = FALSE)
kta1 <- ktab.within(wit1)
plot(statis(kta1, scann = FALSE))

kta2 <- kta1[kta1$blo>3]
kplot(mfa(kta2, scann = FALSE))
}
\keyword{multivariate}
