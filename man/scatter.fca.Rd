\name{scatter.fca}
\alias{scatter.fca}
\title{Plot of the factorial maps for a fuzzy correspondence analysis}
\description{
performs the scatter diagrams of a fuzzy correspondence analysis. 
}
\usage{
scatter.fca(x, xax = 1, yax = 2, clab.moda = 1, labels = names(x$tab), 
    sub = NULL, csub = 2, \dots)
}
\arguments{
  \item{x}{an object of class \code{fca}}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{clab.moda}{the character size to write the modalities}
  \item{labels}{a vector of strings of characters for the labels of the modalities}
  \item{sub}{a vector of strings of characters to be inserted as legend in each figure}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{\dots}{further arguments passed to or from other methods}
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\examples{
data(coleo)
coleo.fuzzy <- prep.fuzzy.var(coleo$tab, coleo$col.blocks)
fca1 <- dudi.fca(coleo.fuzzy, sca = FALSE, nf = 3)
scatter(fca1, labels = coleo$moda.names, clab.moda = 1.5,
    sub = names(coleo$col.blocks), csub = 3)
}
\keyword{multivariate}
\keyword{hplot}
