\name{score.acm}
\alias{score.acm}
\title{Graphs to study one factor in a Multiple Correspondence Analysis}
\description{
performs the graphs to study one factor in a Multiple Correspondence Analysis. 
}
\usage{
score.acm(x, xax = 1, which.var = NULL, mfrow = NULL, 
    sub = names(oritab), csub = 2, possub = "topleft", \dots)
}
\arguments{
  \item{x}{an object of class \code{acm}}
  \item{xax}{the column number for the used axis}
  \item{which.var}{the numbers of the kept columns for the analysis, otherwise all columns}
  \item{mfrow}{a vector of the form "c(nr,nc)", otherwise computed by a special own function \code{n2mfrow}}
  \item{sub}{a vector of strings of characters to be inserted as sub-titles, otherwise the variable names of the initial array}
  \item{csub}{a character size for the sub-titles}
  \item{possub}{a string of characters indicating the sub-title position ("topleft","topright","bottomleft","bottomright")}
  \item{\dots}{further arguments passed to or from other methods}
}
\examples{
data(banque)
banque.acm <- dudi.acm(banque, scann = FALSE, nf = 3)
score(banque.acm, which = which(banque.acm$cr[,1] > 0.2), csub = 3)
}
\keyword{multivariate}
\keyword{hplot}
