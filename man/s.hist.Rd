\name{s.hist}
\alias{s.hist}
\title{Display of a scatterplot and its two marginal histograms}
\description{
  performs a scatterplot and the two marginal histograms of each axis.
}
\usage{
s.hist(dfxy, xax = 1, yax = 2, cgrid = 1, cbreaks = 2, adjust = 1, ...)
}
\arguments{
  \item{dfxy}{a data frame with two coordinates }
  \item{xax}{column for the x axis }
  \item{yax}{column for the y axis }
  \item{cgrid}{a character size, parameter used with \code{par("cex")*cgrid} to indicate the mesh of the grid }
  \item{cbreaks}{a parameter used to define the numbers of cells for the histograms. By default,
  two cells are defined for each interval of the grid displayed in \code{s.label}. With an increase of the integer \code{cbreaks}, 
  the number of cells increases as well.}
  \item{adjust}{a parameter passed to \code{density} to display a kernel density estimation}
  \item{\dots}{further arguments passed from the \code{s.label} for the scatter plot}
}
\examples{
data(rpjdl)
coa1 <- dudi.coa(rpjdl$fau, scannf = FALSE, nf = 4)
s.hist(coa1$li)
s.hist(coa1$li, cgrid = 2, cbr = 3, adj = 0.5, clab = 0)
s.hist(coa1$co, cgrid = 2, cbr = 3, adj = 0.5, clab = 0)
}
\keyword{multivariate}
\keyword{hplot}
