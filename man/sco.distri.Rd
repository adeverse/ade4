\name{sco.distri}
\alias{sco.distri}
\title{Representation by mean- standard deviation of a set of weight distributions on a numeric score}
\description{
represents the mean- standard deviation of a set of weight distributions on a numeric score. 
}
\usage{
sco.distri(score, df, y.rank = TRUE, csize = 1, labels = names(df), clabel = 1,
    xlim = NULL, grid = TRUE, cgrid = 0.75,
    include.origin = TRUE, origin = 0, sub = NULL, csub = 1)
}
\arguments{
  \item{score}{a numeric vector}
  \item{df}{a data frame with only positive or null values}
  \item{y.rank}{a logical value indicating whether the means should be classified in ascending order}
  \item{csize}{an integer indicating the size segment}
  \item{labels}{a vector of strings of characters for the labels of the variables}
  \item{clabel}{if not NULL, a character size for the labels, used with  \code{par("cex")*clabel}}
  \item{xlim}{the ranges to be encompassed by the x axis, if NULL they are computed}
  \item{grid}{a logical value indicating whether the scale vertical lines should be drawn}
  \item{cgrid}{a character size, parameter used with \code{par("cex")*cgrid} to indicate the mesh of the scale}
  \item{include.origin}{a logical value indicating whether the point "origin" should be belonged to the graph space}
  \item{origin}{the fixed point in the graph space, for example c(0,0) the origin axes}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
}
\examples{
w <-seq(-1, 1, le = 200)
distri <- data.frame(lapply(1:50, 
    function(x) sample((200:1)) * ((w >= (-x/50)) & (w <= x/50)) ))
names(distri) <- paste("w", 1:50, sep = "")
par(mfrow = c(1,2))
sco.distri(w, distri, csi = 1.5)
sco.distri(w, distri, y.rank = FALSE, csi = 1.5)
par(mfrow = c(1,1))

data(rpjdl)
coa2 <- dudi.coa(rpjdl$fau, FALSE)
sco.distri(coa2$li[,1], rpjdl$fau, lab = rpjdl$frlab, clab = 0.8)

data(doubs)
par(mfrow = c(2,2))
poi.coa <- dudi.coa(doubs$poi, scann = FALSE)
sco.distri(poi.coa$l1[,1], doubs$poi)
poi.nsc <- dudi.nsc(doubs$poi, scann = FALSE)
sco.distri(poi.nsc$l1[,1], doubs$poi)
s.label(poi.coa$l1)
s.label(poi.nsc$l1)

data(rpjdl)
fau.coa <- dudi.coa(rpjdl$fau, scann = FALSE)
sco.distri(fau.coa$l1[,1], rpjdl$fau)
fau.nsc <- dudi.nsc(rpjdl$fau, scann = FALSE)
sco.distri(fau.nsc$l1[,1], rpjdl$fau)
s.label(fau.coa$l1)
s.label(fau.nsc$l1)

par(mfrow = c(1,1))
}
\keyword{multivariate}
\keyword{hplot}
