\name{macon}
\alias{macon}
\non_function{}
\title{Wine Tasting}
\usage{data(macon)}
\description{
The \code{macon} data frame has 8 rows-wines and 25 columns-tasters.
Each column is a classification of 8 wines (Beaujolais, France).
}
\source{
Foire Nationale des Vins de France, Mâcon, 1985
}
\examples{
data(macon)
s.corcircle(dudi.pca(macon, scan = FALSE)$co)
}
\keyword{datasets}
