\name{sco.label}
\alias{sco.label}
\title{Evenly spaced labels of a numeric score}
\description{
Draws evenly spaced labels, each label linked to the corresponding value of a numeric score.
}
\usage{
sco.label(score, label)
}
\arguments{
  \item{score}{a numeric vector}
  \item{label}{labels for the score}
}
\details{
Takes one vector of quantitative values (abscissae) and draws lines connecting
these abscissae to evenly spaced labels. 
Can be used as a legend in the sco.gauss function.
}
\value{
The matched call.
}
\author{Jean Thioulouse }
\examples{
data(meau)
acpmil <- dudi.pca(meau$mil, scannf=FALSE)
sco.label(acpmil$li[,1], row.names(acpmil$li))
}
\keyword{multivariate}
\keyword{hplot}
