\name{suprow}
\alias{suprow}
\alias{suprow.coa}
\alias{suprow.pca}
\alias{suprow.default}
\title{Projections of Supplementary Rows}
\description{
performs projections of supplementary rows. 
}
\usage{ 
suprow.coa (x, Xsup, \dots) 
suprow.default (x, Xsup, \dots) 
suprow.pca (x, Xsup, \dots) 
}
\arguments{
  \item{x}{an object of class \code{dudi}}
  \item{Xsup}{an array with the supplementary rows (\code{Xsup} and \code{x$tab} have the same column number)}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
If \code{suprow.default} is used, the column vectors of Xsup are projected without prior modifications onto the principal components of dudi with the scalar product associated to the row weightings of dudi.
}
\value{
returns a data frame containing the coordinates of the supplementary projections
}
\references{
Gower, J. C. (1967) Multivariate analysis and multivariate geometry. \emph{The statistician}, \bold{17}, 13--28.
}
\author{
Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}\cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(euro123)
par(mfrow = c(2,2))
w <- euro123[[2]]
dudi1 <- dudi.pca(w, scal = FALSE, scan = FALSE)
s.arrow(dudi1$c1, sub = "Classical", possub = "bottomright", csub = 2.5)
s.label(suprow(dudi1,w), add.plot = TRUE, clab = 0.75)

s.arrow(dudi1$c1,
    sub = "Without centring", possub = "bottomright", csub = 2.5)
s.label(suprow.default(dudi1,w), clab = 0.75, add.plot = TRUE)

triangle.plot(w, clab = 0.75, label = row.names(w), scal = FALSE)
triangle.plot(w, clab = 0.75, label = row.names(w), scal = TRUE)

data(rpjdl)
rpjdl.coa <- dudi.coa(rpjdl$fau, scann = FALSE, nf = 4)
rpjdl.coa$li[1:3,]
suprow(rpjdl.coa,rpjdl$fau[1:3,])$lisup # the same

data(deug)
deug.dudi <- dudi.pca(df = deug$tab, center = deug$cent, 
    scale = FALSE, scannf = FALSE)
suprow(deug.dudi, deug$tab[1:3,])$lisup # the supplementary individuals are centered
deug.dudi$li[1:3,]  # the same
}
\keyword{multivariate}
