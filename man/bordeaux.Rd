\name{bordeaux}
\alias{bordeaux}
\non_function{}
\title{Wine Tasting}
\description{
The \code{bordeaux} data frame gives the opinions of 200 judges in a blind tasting of five different types of claret 
(red wine from the Bordeaux area in the south western parts of France).
}
\usage{data(bordeaux)}
\format{
  This data frame has 5 rows (the wines) and 4 columns (the judgements).
    \describe{
    \item{excellent}{a numeric vector}
    \item{good}{a numeric vector}
    \item{mediocre}{a numeric vector}
    \item{boring}{a numeric vector}
  }
}
\source{
 van Rijckevorsel, J. (1987)\cr
 The application of fuzzy coding and hoerseshoes in multiple correspondence analysis.\cr
 DSWO Press, Leiden (p. 32)
}
\examples{
data(bordeaux)
bordeaux
score(dudi.coa(bordeaux, scan = FALSE))
}
\keyword{datasets}
