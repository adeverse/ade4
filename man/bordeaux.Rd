\name{bordeaux}
\alias{bordeaux}
\docType{data}
\title{Wine Tasting}
\description{
The \code{bordeaux} data frame gives the opinions of 200 judges in a blind tasting of five different types of claret 
(red wine from the Bordeaux area in the south western parts of France).
}
\usage{data(bordeaux)}
\format{
  This data frame has 5 rows (the wines) and 4 columns (the judgements) divided in excellent,
  good, mediocre and boring.
  }
}
\source{
 van Rijckevorsel, J. (1987) \emph{The application of fuzzy coding and horseshoes in multiple correspondence analysis}.
 DSWO Press, Leiden (p. 32)
}
\examples{
data(bordeaux)
bordeaux
score(dudi.coa(bordeaux, scan = FALSE))
}
\keyword{datasets}
