\name{sco.gauss}
\alias{sco.gauss}
\title{Relationships between one score and qualitative variables}
\description{
Draws Gauss curves with the same mean and variance as the scores of indivivuals belonging to categories of several qualitative variables.
}
\usage{
sco.gauss(score, fac, startp = min(score), endp = max(score), steps = 200, ymax = 0,
	sub = names(fac), csub = 2, possub = "topleft", legen = TRUE, label = row.names(fac))
}
\arguments{
  \item{score}{a numeric vector}
  \item{fac}{a dataframe containing only factors, number of rows equal to the length of the score vector}
  \item{startp}{starting point for drawing the Gauss curves}
  \item{endp}{end point for drawing the Gauss curves}
  \item{steps}{number of segments for drawing the Gauss curves}
  \item{ymax}{max ordinate for all Gauss curves}
  \item{sub}{vector of strings of characters for the lables of qualitative variables}
  \item{csub}{character size for the legend}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{legen}{if TRUE, the first graphic of the series displays the score with the \code{rug} function and evenly spaced labels (see \code{sco.label})}
  \item{label}{labels for the score}
}
\details{
Takes one vector containing quantitative values (score) and one dataframe containing only factors
that give categories to wich the quantitative values belong. Computes the mean and variance
of the values in each category of each factor, and draws a Gauss curve with
the same mean and variance for each category of each factor.
Can optionaly set the start and end point of the curves and the number of
segments. The max ordinate (ymax) can also be set arbitrarily to set a common
max for all factors (else the max is different for each factor).
}
\value{
The matched call.
}
\author{Jean Thioulouse }
\examples{
data(meau)
acpmil <- dudi.pca(meau$mil, scannf=FALSE)
dffac=cbind.data.frame(meau$plan$dat, meau$plan$sta)
sco.gauss(acpmil$li[,1], dffac)
}
\keyword{multivariate}
\keyword{hplot}
