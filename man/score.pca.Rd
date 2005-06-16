\name{score.pca}
\alias{score.pca}
\title{Graphs to Analyse a factor in PCA}
\description{
performs the canonical graph of a Principal Component Analysis. 
}
\usage{
score.pca(x, xax = 1, which.var = NULL, mfrow = NULL, csub = 2, 
    sub = names(x$tab), abline = TRUE, \dots)
}
\arguments{
  \item{x}{an object of class \code{pca}}
  \item{xax}{the column number for the used axis}
  \item{which.var}{the numbers of the kept columns for the analysis, otherwise all columns}
  \item{mfrow}{a vector of the form "c(nr,nc)", otherwise computed by a special own function \code{n2mfrow}}
  \item{csub}{a character size for sub-titles, used with \code{par("cex")*csub}}
  \item{sub}{a vector of string of characters to be inserted as sub-titles, otherwise the names of the variables}
  \item{abline}{a logical value indicating whether a regression line should be added}
  \item{\dots}{further arguments passed to or from other methods}
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\examples{
data(deug)
dd1 <- dudi.pca(deug$tab, scan = FALSE)
score(dd1, csub = 3)
 
# The correlations are :
dd1$co[,1]
# [1] 0.7925 0.6532 0.7410 0.5287 0.5539 0.7416 0.3336 0.2755 0.4172
}
\keyword{multivariate}
\keyword{hplot}
