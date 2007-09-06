\name{kplot.mcoa}
\alias{kplot.mcoa}
\title{Multiple Graphs for a Multiple Co-inertia Analysis}
\description{
performs high level plots of a Multiple Co-inertia Analysis, 
using an object of class \code{mcoa}. 
}
\usage{
kplot.mcoa(object, xax = 1, yax = 2, which.tab = 1:nrow(object$cov2), 
    mfrow = NULL, option = c("points", "axis", "columns"), 
    clab = 1, cpoint = 2, csub = 2, possub = "bottomright",\dots)
}
\arguments{
  \item{object}{an object of class \code{mcoa}}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{which.tab}{a numeric vector containing the numbers of the tables to analyse}
  \item{mfrow}{a vector of the form 'c(nr,nc)', otherwise computed by as special own function \code{n2mfrow}}
  \item{option}{a string of characters for the drawing option
      \item{"points"}{plot of the projected scattergram onto the co-inertia axes}
      \item{"axis"}{projections of inertia axes onto the co-inertia axes.}
      \item{"columns"}{projections of variables onto the synthetic variables planes.}
  }
  \item{clab}{a character size for the labels}
  \item{cpoint}{a character size for plotting the points, used with \code{par("cex")}*cpoint. If zero, no points are drawn.}
  \item{csub}{a character size for the sub-titles, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{\dots}{further arguments passed to or from other methods}
}
\author{Daniel Chessel }
\examples{
data(friday87)
w1 <- data.frame(scale(friday87$fau, scal = FALSE))
w2 <- ktab.data.frame(w1, friday87$fau.blo, 
    tabnames = friday87$tab.names)
mcoa1 <- mcoa(w2, "lambda1", scan = FALSE)
kplot(mcoa1, clab = 2, csub = 2, cpoi = 3, opt = "axis")

kplot(mcoa1, mfrow = c(3,4), clab = 2, csub = 3, cpoi = 3)

kplot(mcoa1, clab = 2, csub = 3, cpoi = 3, mfrow = c(3,4), 
    opt = "columns")
}
\keyword{multivariate}
\keyword{hplot}
