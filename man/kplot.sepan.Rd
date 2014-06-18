\name{kplot.sepan}
\alias{kplot.sepan}
\alias{kplot.sepan.coa}
\title{Multiple Graphs for Separated Analyses in a K-tables}
\description{
performs high level plots for Separed Analyses in a K-tables, 
using an object of class \code{sepan}. 
}
\usage{
\method{kplot}{sepan}(object, xax = 1, yax = 2, which.tab = 1:length(object$blo), 
    mfrow = NULL, permute.row.col = FALSE, clab.row = 1, 
    clab.col = 1.25, traject.row = FALSE, csub = 2, 
    possub = "bottomright", show.eigen.value = TRUE,\dots)

\method{kplot}{sepan.coa}(object, xax = 1, yax = 2, which.tab = 1:length(object$blo), 
    mfrow = NULL, permute.row.col = FALSE, clab.row = 1, 
    clab.col = 1.25, csub = 2, possub = "bottomright", 
    show.eigen.value = TRUE, poseig = c("bottom", "top"), \dots)
}
\arguments{
  \item{object}{an object of class \code{sepan}}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{which.tab}{a numeric vector containing the numbers of the tables to analyse}
  \item{mfrow}{parameter for the array of figures to be drawn, otherwise use n2mfrow}
  \item{permute.row.col}{if TRUE the rows are represented by arrows and the columns by points, if FALSE it is the opposite}
  \item{clab.row}{a character size for the row labels}
  \item{clab.col}{a character size for the column labels}
  \item{traject.row}{a logical value indicating whether the trajectories between rows should be drawn in a natural order}
  \item{csub}{a character size for the sub-titles, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{show.eigen.value}{a logical value indicating whether the eigenvalues bar plot should be drawn}
  \item{poseig}{if "top" the eigenvalues bar plot is upside, if "bottom", it is downside}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
\code{kplot.sepan} superimposes the points for the rows and the arrows for the columns using an 
adapted rescaling such as the \code{scatter.dudi}.\cr
\code{kplot.sepan.coa} superimposes the row coordinates and the column coordinates with the same scale.
}
\author{Daniel Chessel }
\examples{
data(escopage)
w1 <- data.frame(scale(escopage$tab))
w1 <- ktab.data.frame(w1, escopage$blo, tabnames = escopage$tab.names)
sep1 <- sepan(w1)
if(adegraphicsLoaded()) {
  kplot(sep1, posieig = "none")
} else {
  kplot(sep1, show = FALSE)
}

data(friday87)
w2 <- data.frame(scale(friday87$fau, scal = FALSE))
w2 <- ktab.data.frame(w2, friday87$fau.blo, tabnames = friday87$tab.names)
if(adegraphicsLoaded()) {
  kplot(sepan(w2), row.plabel.cex = 1.25, col.plab.cex = 0)
} else {
  kplot(sepan(w2), clab.r = 1.25, clab.c = 0)
}

data(microsatt)
w3 <- dudi.coa(data.frame(t(microsatt$tab)), scann = FALSE)
loci.fac <- factor(rep(microsatt$loci.names, microsatt$loci.eff))
wit <- wca(w3, loci.fac, scann = FALSE)
microsatt.ktab <- ktab.within(wit)
if(adegraphicsLoaded()) {
  kplot.sepan.coa(sepan(microsatt.ktab), posieig = "none", col.plab.cex = 0, row.plab.cex = 1.5)
} else {
  kplot.sepan.coa(sepan(microsatt.ktab), show = FALSE, clab.c = 0, 
    mfrow = c(3,3), clab.r = 1.5)
}    
}
\keyword{multivariate}
\keyword{hplot}
