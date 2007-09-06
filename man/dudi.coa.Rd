\encoding{latin1}
\name{dudi.coa}
\alias{dudi.coa}
\title{Correspondence Analysis}
\description{
performs a correspondence analysis. 
}
\usage{
dudi.coa(df, scannf = TRUE, nf = 2)
}
\arguments{
  \item{df}{a data frame containing positive or null values}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
}
\value{
returns a list of class \code{coa} and \code{dudi} (see \link{dudi}) containing 
  \item{N}{the sum of all the values of the initial table}
}
\references{
Benzécri, J.P. and Coll. (1973) \emph{L'analyse des données. II L'analyse des correspondances}, Bordas, Paris. 1--620.\cr

Greenacre, M. J. (1984) \emph{Theory and applications of correspondence analysis}, Academic Press, London.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(rpjdl)
chisq.test(rpjdl$fau)$statistic
rpjdl.coa <- dudi.coa(rpjdl$fau, scannf = FALSE, nf = 4)
sum(rpjdl.coa$eig)*rpjdl.coa$N # the same

par(mfrow = c(1,2))
s.label(rpjdl.coa$co, clab = 0.6, lab = rpjdl$frlab)
s.label(rpjdl.coa$li, clab = 0.6)
par(mfrow = c(1,1))

data(bordeaux)
db <- dudi.coa(bordeaux, scan = FALSE)
db
score(db)
}
\keyword{multivariate}
