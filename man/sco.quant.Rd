\name{sco.quant}
\alias{sco.quant}
\title{Graph to Analyse the Relation between a Score and Quantitative Variables}
\description{
represents the graphs to analyse the relation between a score and quantitative variables. 
}
\usage{
sco.quant (score, df, fac = NULL, clabel = 1, abline = FALSE, 
    sub = names(df), csub = 2, possub = "topleft") 
}
\arguments{
  \item{score}{a numeric vector}
  \item{df}{a data frame which rows equal to the score length}
  \item{fac}{a factor with the same length than the score}
  \item{clabel}{character size for the class labels (if any) used with \code{par("cex")*clabel}}
  \item{abline}{a logical value indicating whether a regression line should be added}
  \item{sub}{a vector of strings of characters for the labels of variables}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
}
\examples{
w <- runif(100, -5, 10)
fw <- cut (w, 5)
levels(fw) <- LETTERS[1:5]
wX <- data.frame(matrix(w + rnorm(900, sd = (1:900) / 100), 100, 9))
sco.quant(w, wX, fac = fw, abline = TRUE, clab = 2, csub = 3)
}
\keyword{hplot}
\keyword{multivariate}
