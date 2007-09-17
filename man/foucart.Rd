\name{foucart}
\alias{foucart}
\alias{plot.foucart}
\alias{print.foucart}
\title{K-tables Correspondence Analysis with the same rows and the same columns}
\description{
  K tables have the same rows and the same columns.\cr
  Each table is transformed by P = X/sum(X). The average of P is computing.\cr
  A correspondence analysis is realized on this average.\cr
  The initial rows and the initial columns are projected in supplementary elements.
}
\usage{
foucart(X, scannf = TRUE, nf = 2)
\method{plot}{foucart}(x, xax = 1, yax = 2, clab = 1, csub = 2, 
    possub = "bottomright", \dots) 
\method{print}{foucart}(x, \dots) 
}
\arguments{
  \item{X}{a list of data frame where the row names and the column names are the same for each table}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \cr
  \item{x}{an object of class 'foucart'}
  \item{xax}{the column number of the x-axis}
  \item{yax}{the column number of the y-axis}
  \item{clab}{if not NULL, a character size for the labels, used with \code{par("cex")*clab}}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{\dots}{further arguments passed to or from other methods}

}
\value{
  \code{foucart} returns a list of the classes 'dudi', 'coa' and 'foucart'
    \item{call}{origine}
    \item{nf}{axes-components saved}
    \item{rank}{rank}
    \item{blo}{useful vector}
    \item{cw}{vector: column weights}
    \item{lw}{vector: row weights}
    \item{eig}{vector: eigen values}
    \item{tab}{data.frame: modified array}
    \item{li}{data.frame: row coordinates}
    \item{l1}{data.frame: row normed scores}
    \item{co}{data.frame: column coordinates}
    \item{c1}{data.frame: column normed scores}
    \item{Tli}{data.frame: row coordinates (each table)}
    \item{Tco}{data.frame: col coordinates (each table)}
    \item{TL}{data.frame: factors for Tli}
    \item{TC}{data.frame: factors for Tco}
}
\references{Foucart, T. (1984) \emph{Analyse factorielle de tableaux multiples}, Masson, Paris.
}
\author{P. Bady \email{pierre.bady@univ-lyon1.fr}\cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(bf88)
fou1 <- foucart(bf88, scann = FALSE, nf = 3)
fou1
plot(fou1)

data(meaudret)
l1 <- split(meaudret$fau, meaudret$plan$dat)
l1 <- lapply(l1, function(x) 
    {row.names(x) <- paste("Sta",1:5,sep="");x})
fou2 <- foucart(l1, scan = FALSE)
kplot(fou2, clab.r = 2)
}
\keyword{multivariate}
