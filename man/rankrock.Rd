\name{rankrock}
\alias{rankrock}
\non_function{}
\title{Ordination Table}
\description{
This data set gives the classification in order of preference of 10 music groups by 51 students. 
}
\usage{data(rankrock)}
\format{
A data frame with 10 rows and 51 columns.\cr
Each column contains the rank (1 for the favorite, …, 10 for the less appreciated)\cr
attributed to the group by a student.
}
\examples{
data(rankrock)
dudi1 <- dudi.pca(rankrock, scannf = FALSE, nf = 3)
scatter(dudi1, clab.r = 1.5)
}
\keyword{datasets}
