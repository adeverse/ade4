\name{scatter.dudi}
\alias{scatter.dudi}
\title{Plot of the Factorial Maps}
\description{
performs the scatter diagrams of objects of class \code{dudi}. 
}
\usage{
\method{scatter}{dudi}(x, xax = 1, yax = 2, clab.row = 0.75, clab.col = 1, 
    permute = FALSE, posieig = "top", sub = NULL, \dots)
}
\arguments{
  \item{x}{an object of class \code{dudi}}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{clab.row}{a character size for the rows}
  \item{clab.col}{a character size for the columns}
  \item{permute}{if FALSE, the rows are plotted by points and the columns by arrows. If TRUE it is the opposite.}
  \item{posieig}{if "top" the eigenvalues bar plot is upside, if "bottom" it is downside, if "none" no plot}
  \item{sub}{a string of characters to be inserted as legend}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
\code{scatter.dudi} is a factorial map of individuals and the projection of the vectors of the canonical basis multiplied by a constante of rescaling. In the eigenvalues bar plot,the used axes for the plot are in black, the other kept axes in grey and the other in white.

The \code{permute} argument can be used to choose between the distance biplot (default) and the correlation biplot (permute = TRUE).

}
\author{Daniel Chessel }
\examples{
data(deug)
scatter(dd1 <- dudi.pca(deug$tab, scannf = FALSE, nf = 4), 
    posieig = "bottomright")

data(rhone)
dd1 <- dudi.pca(rhone$tab, nf = 4, scann = FALSE)
scatter(dd1, sub = "Principal component analysis")
}
\keyword{multivariate}
\keyword{hplot}
