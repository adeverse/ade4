\name{kplot.statis}
\alias{kplot.statis}
\title{Multiple Graphs of a STATIS Analysis}
\description{
performs high level plots for a STATIS analysis, 
using an object of class \code{statis}. 
}
\usage{
kplot.statis(object, xax = 1, yax = 2, mfrow = NULL, 
    which.tab = 1:length(x$tab.names), clab = 1.5, cpoi = 2, 
    traject = FALSE, arrow = TRUE, class = NULL, 
    unique.scale = FALSE, csub = 2, possub = "bottomright",\dots)
}
\arguments{
  \item{object}{an object of class \code{statis}}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{mfrow}{parameter for the array of figures to be drawn}
  \item{which.tab}{a numeric vector containing the numbers of the tables to analyse}
  \item{clab}{a character size for the labels}
  \item{cpoi}{the size of points}
  \item{traject}{a logical value indicating whether the trajectories should be drawn in a natural order}
  \item{arrow}{a logical value indicating whether the column factorial diagrams should be plotted}
  \item{class}{if not NULL, a factor of length equal to the number of the total columns of the K-tables}
  \item{unique.scale}{if TRUE, all the arrays of figures have the same scale}
  \item{csub}{a character size for the labels of the arrays of figures used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{\dots}{further arguments passed to or from other methods}
}
\examples{
data(jv73)
dudi1 <- dudi.pca(jv73$poi, scann = FALSE, scal = FALSE)
wit1 <- within(dudi1, jv73$fac.riv, scann = FALSE)
kta3 <- ktab.within(wit1)
data(jv73)
statis3 <- statis(kta3, scann = FALSE)
kplot(statis3, traj = TRUE, arrow = FALSE, unique = TRUE, 
    clab = 0, csub = 3, cpoi = 3)
}
\keyword{multivariate}
\keyword{hplot}
