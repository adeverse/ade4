\name{orthobasis}
\alias{orthobasis}
\alias{orthobasis.neig}
\alias{orthobasis.line}
\alias{orthobasis.circ}
\alias{orthobasis.mat}
\alias{orthobasis.haar}
\alias{print.orthobasis}
\alias{is.orthobasis}
\alias{summary.orthobasis}
\alias{plot.orthobasis}

\title{Orthonormal basis for orthonormal transform}
\description{
These functions returns object of class \code{'orthobasis'} that
contains data frame defining an orthonormal basis.

\code{orthobasic.neig} returns the eigen vectors of the matrix N-M where M is the symmetric \emph{n} by \emph{n} matrix of the between-sites neighbouring graph and N is the diagonal matrix of neighbour numbers. \cr
\code{orthobasis.line} returns the analytical solution for the linear neighbouring graph. \cr
\code{orthobasic.circ} returns the analytical solution for the circular neighbouring graph. \cr
\code{orthobsic.mat} returns the eigen vectors of the general link matrix M. \cr
\code{orthobasis.haar} returns wavelet haar basis. 
}
\usage{
orthobasis.neig(neig)
orthobasis.line(n)
orthobasis.circ(n)
orthobasis.mat(mat, cnw=TRUE)
orthobasis.haar(n)
\method{print}{orthobasis}(x,..., nr = 6, nc = 4)
\method{plot}{orthobasis}(x,...)
\method{summary}{orthobasis}(object,...)
is.orthobasis(x)
}
\arguments{
  \item{neig}{is an object of class \code{neig}}
  \item{n}{is an integer that defines length of vectors}
  \item{mat}{is a \emph{n} by \emph{n} phylogenetic or spatial link matrix}
  \item{cnw}{if TRUE, the matrix of the neighbouring graph is modified to give Constant Neighbouring Weights}
  \item{x, object}{is an object of class \code{orthobasis}}
  \item{nr, nc}{the number of rows and columns to be printed}
  \item{\dots}{: further arguments passed to or from other methods}
}
\value{
All the functions return an object of class \code{orthobasis} containing a data frame.
This data frame defines an orthonormal basis with various attributes: \cr
  \item{names}{names of the vectors}
  \item{row.names}{row names of the data frame}
  \item{class}{class}
  \item{values}{optional associated eigenvalues}
  \item{weights}{weights for the rows}
  \item{call}{: call}
}
\references{
Misiti, M., Misiti, Y., Oppenheim, G. and Poggi, J.M. (1993) Analyse de signaux classiques par décomposition en ondelettes. 
\emph{Revue de Statistique Appliquée}, \bold{41}, 5--32.

Cornillon, P.A. (1998) \emph{Prise en compte de proximités en analyse factorielle et comparative}.
Thèse, Ecole Nationale Supérieure Agronomique, Montpellier.
}
\author{Sébastien Ollier \email{sebastien.ollier@u-psud.fr} \cr
Daniel Chessel 
}
\note{the function \code{orthobasis.haar} uses function \code{\link[waveslim]{wavelet.filter}} from package waveslim.}
\seealso{\code{\link{gridrowcol}} that defines an orthobasis for square grid, \code{\link{phylog}} that defines an orthobasis for phylogenetic tree, \code{\link{orthogram}} and \code{\link{mld}}}
\examples{

# a 2D spatial orthobasis
w <- gridrowcol(8, 8)
if(adegraphicsLoaded()) {
  g1 <- s.value(w$xy, w$orthobasis[, 1:16], pleg.drawKey = F, pgri.text.cex = 0, 
    ylim = c(0, 10), pori.inc = F, paxes.dr = F)
  g2 <- s1d.barchart(attr(w$orthobasis, "values"), p1d.hori = F, 
    labels = names(attr(w$orthobasis, "values")), plabels.cex = 0.7)

} else {
  par(mfrow = c(4, 4))
  for(k in 1:16)
    s.value(w$xy, w$orthobasis[, k], cleg = 0, csi = 2, incl = FALSE,
      addax = FALSE, sub = k, csub = 4, ylim = c(0, 10), cgri = 0)
  par(mfrow = c(1, 1))
  barplot(attr(w$orthobasis, "values"))
}


# Haar 1D orthobasis
w <- orthobasis.haar(32)
par(mfrow = c(8, 4))
par(mar = c(0.1, 0.1, 0.1, 0.1))
 for (k in 1:31) {
    plot(w[, k], type = "S", xlab = "", ylab = "", xaxt = "n",
     yaxt = "n", xaxs = "i", yaxs = "i", ylim = c(-4.5, 4.5))
    points(w[, k], type = "p", pch = 20, cex = 1.5)
}

# a 1D orthobasis
w <- orthobasis.line(n = 33)
par(mfrow = c(8, 4))
par(mar = c(0.1, 0.1, 0.1, 0.1))
 for (k in 1:32) {
    plot(w[, k], type = "l", xlab = "", ylab = "", xaxt = "n",
     yaxt = "n", xaxs = "i", yaxs = "i", ylim = c(-1.5, 1.5))
    points(w[, k], type = "p", pch = 20, cex = 1.5)
}

if(adegraphicsLoaded()) {
  s1d.barchart(attr(w, "values"), p1d.hori = F, labels = names(attr(w, "values")), 
    plab.cex = 0.7)
} else {
  par(mfrow = c(1, 1))
  barplot(attr(w, "values"))
}

w <- orthobasis.circ(n = 26)
#par(mfrow = c(5, 5))
#par(mar = c(0.1, 0.1, 0.1, 0.1))
# for (k in 1:25) 
#    dotcircle(w[, k], xlim = c(-1.5, 1.5), cleg = 0)

par(mfrow = c(1, 1))
#barplot(attr(w, "values"))

\dontrun{
# a spatial orthobasis
data(mafragh)
w <- orthobasis.neig(mafragh$neig)
if(adegraphicsLoaded()) {
  s.value(mafragh$xy, w[, 1:8], pleg.drawKey = F)
  s1d.barchart(attr(w, "values"), p1d.hori = F)
} else {
  par(mfrow = c(4, 2))
  for(k in 1:8)
    s.value(mafragh$xy, w[, k], cleg = 0, sub = as.character(k), csub = 3)
  par(mfrow = c(1, 1))
  barplot(attr(w, "values"))
}


# a phylogenetic orthobasis
data(njplot)
phy <- newick2phylog(njplot$tre)
wA <- phy$Ascores
wW <- phy$Wscores
table.phylog(phylog = phy, wA, clabel.row = 0, clabel.col  = 0.5)
table.phylog(phylog = phy, wW, clabel.row = 0, clabel.col  = 0.5)

}}
\keyword{spatial}
\keyword{ts}
