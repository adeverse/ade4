\name{kplot.mfa}
\alias{kplot.mfa}
\title{Multiple Graphs for a Multiple Factorial Analysis}
\description{
performs high level plots of a Multiple Factorial Analysis, 
using an object of class \code{mfa}. 
}
\usage{
kplot.mfa(object, xax = 1, yax = 2, mfrow = NULL, 
    which.tab = 1:length(object$blo), row.names = FALSE, col.names = TRUE, 
    traject = FALSE, permute.row.col = FALSE, 
    clab = 1, csub = 2, possub = "bottomright", \dots)
}
\arguments{
  \item{object}{an object of class \code{mfa}}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{mfrow}{a vector of the form 'c(nr,nc'), otherwise computed by a special own function \code{n2mfrow}}
  \item{which.tab}{vector of the numbers of tables used for the analysis}
  \item{row.names}{a logical value indicating whether the row labels should be inserted}
  \item{col.names}{a logical value indicating whether the column labels should be inserted}
  \item{traject}{a logical value indicating whether the trajectories of the rows should be drawn in a natural order}
  \item{permute.row.col}{if TRUE, the rows are represented by vectors and columns by points, otherwise it is the opposite}
  \item{clab}{a character size for the labels}
  \item{csub}{a character size for the sub-titles, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{\dots}{further arguments passed to or from other methods}
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\examples{
data(friday87)
w1 <- data.frame(scale(friday87$fau, scal = FALSE))
w2 <- ktab.data.frame(w1, friday87$fau.blo, 
    tabnames = friday87$tab.names)
mfa1 <- mfa(w2, scann = FALSE)
kplot(mfa1)
}
\keyword{multivariate}
\keyword{hplot}
