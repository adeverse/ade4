\name{kplot.pta}
\alias{kplot.pta}
\title{Multiple Graphs for a Partial Triadic Analysis}
\description{
performs high level plots of a Partial Triadic Analysis, 
using an object of class \code{pta}. 
}
\usage{
\method{kplot}{pta}(object, xax = 1, yax = 2, which.tab = 1:nrow(object$RV), 
    mfrow = NULL, which.graph = 1:4, clab = 1, cpoint = 2, csub = 2, 
    possub = "bottomright", ask = par("ask"), ...)
}
\arguments{
  \item{object}{an object of class \code{pta}}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{which.tab}{a numeric vector containing the numbers of the tables to analyse}
  \item{mfrow}{parameter of the array of figures to be drawn, otherwise the graphs associated to a table are drawn on the same row}
 \item{which.graph}{an option for drawing, an integer between 1 and 4. For each table of which.tab, are drawn :
      \item{1}{the projections of the principal axes}
      \item{2}{the projections of the rows}
      \item{3}{the projections of the columns}
      \item{4}{the projections of the principal components onto the planes of the compromise}
  }
  \item{clab}{a character size for the labels}
  \item{cpoint}{a character size for plotting the points, used with \code{par("cex")}*cpoint. If zero, no points are drawn.}
  \item{csub}{a character size for the sub-titles, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{ask}{a logical value indicating if the graphs requires several arrays of figures}
  \item{\dots}{further arguments passed to or from other methods}
}
\author{Daniel Chessel }
\examples{
data(meaudret)
wit1 <- within(dudi.pca(meaudret$fau, scan = FALSE, scal = FALSE), 
    meaudret$plan$dat, scan = FALSE)
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5"), 4))
kta2 <- t(kta1) ; pta1 <- pta(kta2, scann = FALSE)
kplot(pta1, clab = 1.5, csub = 3)
kplot(pta1, clab = 1.5, csub = 3, which.graph = 3, mfrow = c(2,2))
}
\keyword{multivariate}
\keyword{hplot}
