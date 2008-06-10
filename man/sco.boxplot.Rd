\name{sco.boxplot}
\alias{sco.boxplot}
\title{Representation of the link between a variable and a set of qualitative variables}
\description{
represents the link between a variable and a set of qualitative variables. 
}
\usage{
sco.boxplot(score, df, labels = names(df), clabel = 1, xlim = NULL, 
    grid = TRUE, cgrid = 0.75, include.origin = TRUE, origin = 0, 
    sub = NULL, csub = 1)
}
\arguments{
  \item{score}{a numeric vector}
  \item{df}{a data frame with only factors}
  \item{labels}{a vector of strings of characters for the labels of variables}
  \item{clabel}{if not NULL, a character size for the labels, used with  \code{par("cex")*clabel}}
  \item{xlim}{the ranges to be encompassed by the x axis, if NULL they are computed}
  \item{grid}{a logical value indicating whether the scale vertical lines should be drawn}
  \item{cgrid}{a character size, parameter used with \code{par("cex")*cgrid} to indicate the mesh of the scale}
  \item{include.origin}{a logical value indicating whether the point "origin" should be belonged to the graph space}
  \item{origin}{the fixed point in the graph space, for example 0 the origin axis}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
}
\author{
Daniel Chessel 
}
\examples{
w1 <- rnorm(100,-1)
w2 <- rnorm(100)
w3 <- rnorm(100,1)
f1 <- gl(3,100)
f2 <- gl(30,10)
sco.boxplot(c(w1,w2,w3), data.frame(f1,f2))

data(banque)
banque.acm <- dudi.acm(banque, scan = FALSE, nf = 4)
par(mfrow = c(1,3))
sco.boxplot(banque.acm$l1[,1], banque[,1:7], clab = 1.8)
sco.boxplot(banque.acm$l1[,1], banque[,8:14], clab = 1.8)
sco.boxplot(banque.acm$l1[,1], banque[,15:21], clab = 1.8)
par(mfrow = c(1,1))
}
\keyword{multivariate}
\keyword{hplot}
