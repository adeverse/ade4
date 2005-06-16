\name{score.mix}
\alias{score.mix}
\title{Graphs to Analyse a factor in a Mixed Analysis}
\description{
performs the canonical graph of a mixed analysis. 
}
\usage{
score.mix (x, xax = 1, csub = 2, mfrow = NULL, which.var = NULL, \dots)
}
\arguments{
  \item{x}{an object of class \code{mix}}
  \item{xax}{the column number for the used axis}
  \item{csub}{a character size for the sub-titles, used with \code{par("cex")*csub}}
  \item{mfrow}{a vector of the form "c(nr,nc)", otherwise computed by a special own function \code{n2mfrow}}
  \item{which.var}{the numbers of the kept columns for the analysis, otherwise all columns }
  \item{\dots}{further arguments passed to or from other methods}
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\examples{
data(lascaux)
w <- cbind.data.frame(lascaux$colo, lascaux$ornem)
dd <- dudi.mix(w, scan = FALSE, nf = 4, add = TRUE)
score(dd, which = which(dd$cr[,1] > 0.3))
}
\keyword{multivariate}
\keyword{hplot}
