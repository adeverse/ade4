\name{olympic}
\alias{olympic}
\docType{data}
\title{Olympic Decathlon}
\description{
This data set gives the performances of 33 men's decathlon in the 1988 Olympics
}
\usage{data(olympic)}
\format{
    \code{olympic} is a list of 2 components.
    \describe{
    \item{tab}{is a data frame with 33 rows and 10 columns events of the decathlon.}
    \item{scores}{is a vector of the final points scores of the competition.}
    }
}
\source{
Example 357 in: \cr
Hand, D.J., Daly, F., Lunn, A.D., McConway, K.J. and Ostrowski, E. (1994) 
\emph{A handbook of small data sets}, Chapman & Hall, London. 458 p.

Lunn, A. D. and McNeil, D.R. (1991) \emph{Computer-Interactive Data Analysis}, Wiley, New York
}
\examples{
data(olympic)
pca1 <- dudi.pca(olympic$tab, scan = FALSE)
par(mfrow = c(2,2))
barplot(pca1$eig)
s.corcircle(pca1$co)
plot(olympic$score, pca1$l1[,1])
abline(lm(pca1$l1[,1]~olympic$score))
s.label(pca1$l1, clab = 0.5)
s.arrow(2 * pca1$co, add.p = TRUE)
par(mfrow = c(1,1))}
\keyword{datasets}
