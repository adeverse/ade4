\name{witwit.coa}
\alias{witwit.coa}
\alias{summary.witwit}
\alias{witwitsepan}
\title{Internal Correspondence Analysis}
\description{
\code{witwit.coa} performs an Internal Correspondence Analysis. 
\code{witwitsepan} gives the computation and the barplot of the eigenvalues
for each separated analysis in an Internal Correspondence Analysis.
}
\usage{
witwit.coa(dudi, row.blocks, col.blocks, scannf = TRUE, nf = 2)
summary.witwit(object, \dots)
witwitsepan <- function (ww, mfrow = NULL, csub = 2, plot = TRUE)
}
\arguments{
  \item{dudi}{an object of class \code{coa} }
  \item{row.blocks}{a numeric vector indicating the row numbers for each block of rows}
  \item{col.blocks}{a numeric vector indicating the column numbers for each block of columns}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \cr
  \item{object}{an object of class \code{witwit}}
  \item{\dots}{further arguments passed to or from other methods}
  \cr
  \item{ww}{an object of class \code{witwit}}
  \item{mfrow} {a vector of the form "c(nr,nc)", otherwise computed by a special own function 'n2mfrow'}
  \item{csub} {a character size for the sub-titles, used with \code{par("cex")*csub}}
  \item{plot} {if FALSE, numeric results are returned}
}
\value{
returns a list of class \code{witwit}, \code{coa} and \code{dudi} (see \link{as.dudi}) containing
  \item{rbvar}{a data frame with the within variances of the rows of the factorial coordinates}
  \item{lbw}{a data frame with the marginal weighting of the row classes}
  \item{cvar}{a data frame with the within variances of the columns of the factorial coordinates}
  \item{cbw}{a data frame with the marginal weighting of the column classes}
}
\references{
Cazes, P., Chessel, D. and Dolédec, S. (1988) L'analyse des correspondances internes d'un tableau partitionné :
son usage en hydrobiologie. \emph{Revue de Statistique Appliquée}, \bold{36}, 39--54. 
}
\author{
Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}
}
\examples{
data(ardeche)
coa1 <- dudi.coa(ardeche$tab, scann = FALSE, nf = 4)
ww <- witwit.coa(coa1, ardeche$row.blocks, ardeche$col.blocks, scann = FALSE)
ww
s.class(ww$co, ardeche$sta.fac, clab = 1.5, cell = 0, axesell = FALSE)
s.label(ww$co, add.p = TRUE, clab = 0.75)
summary(ww)

witwitsepan(ww, c(4 ,6))
}
\keyword{multivariate}
