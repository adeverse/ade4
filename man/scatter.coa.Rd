\name{scatter.coa}
\alias{scatter.coa}
\title{Plot of the factorial maps for a correspondence analysis}
\description{
performs the scatter diagrams of a correspondence analysis. 
}
\usage{
\method{scatter}{coa}(x, xax = 1, yax = 2, method = 1:3, clab.row = 0.75, 
    clab.col = 1.25, posieig = "top", sub = NULL, csub = 2, \dots)
}
\arguments{
  \item{x}{an object of class \code{coa}}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{method}{an integer between 1 and 3 \cr
    1 Rows and columns with the coordinates of lambda variance\cr
    2 Columns variance 1 and rows by averaging\cr
    3 Rows variance 1 and columns by averaging}
  \item{clab.row}{a character size for the rows}
  \item{clab.col}{a character size for the columns}
  \item{posieig}{if "top", the eigenvalues bar plot is upside; if "bottom", it is downside; if "none", no plot}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{\dots}{further arguments passed to or from other methods}
}
\references{Oksanen, J. (1987) Problems of joint display of species and site scores in correspondence analysis. \emph{Vegetatio}, \bold{72}, 51--57.
}
\author{Daniel Chessel}
\examples{
data(housetasks)
w <- dudi.coa(housetasks, scan = FALSE)
if(adegraphicsLoaded()) {
  g1 <- scatter(w, method = 1, psub.text = "1 / Standard", posieig = "none", plot = FALSE)
  g2 <- scatter(w, method = 2, psub.text = "2 / Columns -> averaging -> Rows", 
    posieig = "none", plot = FALSE)
  g3 <- scatter(w, method = 3, psub.text = "3 / Rows -> averaging -> Columns ", 
    posieig = "none", plot = FALSE)
  G <- ADEgS(list(g1, g2, g3), layout = c(2, 2))
  
} else {
  par(mfrow = c(2, 2))
  scatter(w, method = 1, sub = "1 / Standard", posieig = "none")
  scatter(w, method = 2, sub = "2 / Columns -> averaging -> Rows", posieig = "none")
  scatter(w, method = 3, sub = "3 / Rows -> averaging -> Columns ", posieig = "none")
  par(mfrow = c(1, 1))
}}
\keyword{multivariate}
\keyword{hplot}
