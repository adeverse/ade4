\name{dudi.dec}
\alias{dudi.dec}
\title{Decentred Correspondence Analysis}
\description{
performs a decentred correspondence analysis. 
}
\usage{
dudi.dec(df, eff, scannf = TRUE, nf = 2)
}
\arguments{
  \item{df}{a data frame containing positive or null values}
  \item{eff}{a vector containing the reference distribution. Its length is equal to the number of rows of df}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
}
\value{
Returns a list of class \code{dec} and \code{dudi} (see \code{\link{dudi}}) containing also 
  \item{R}{sum of all the values of the initial table}
}
\references{Dolédec, S., Chessel, D. and Olivier J. M. (1995) L'analyse des correspondances décentrée: 
application aux peuplements ichtyologiques du haut-Rhône. 
\emph{Bulletin Français de la Pêche et de la Pisciculture}, \bold{336}, 29--40.}
\author{
Daniel Chessel \cr
Anne-Béatrice Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
}
\examples{
data(ichtyo)
dudi1 <- dudi.dec(ichtyo$tab, ichtyo$eff, scan = FALSE)
sum(apply(ichtyo$tab, 2, function(x)
    chisq.test(x, p = ichtyo$eff/sum(ichtyo$eff))$statistic))
sum(dudi1$eig) * sum(ichtyo$eff) # the same

s.class(dudi1$li, ichtyo$dat, wt = ichtyo$eff/sum(ichtyo$eff))
}
\keyword{multivariate}
