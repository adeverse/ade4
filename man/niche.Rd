\name{niche}
\alias{niche}
\alias{plot.niche}
\alias{print.niche}
\alias{niche.param}
\alias{rtest.niche}
\title{Method to Analyse a pair of tables : Environmental and Faunistic Data}
\description{
performs a special multivariate analysis for ecological data. 
}
\usage{
niche(dudiX, Y, scannf = TRUE, nf = 2)
print.niche (x, \dots) 
plot.niche (x, xax = 1, yax = 2, \dots)
niche.param(x)
rtest.niche(x,nrepet=999)
}
\arguments{
  \item{dudiX}{a duality diagram providing from a function \code{dudi.coa}, \code{dudi.pca}, ... using an array sites-variables}
  \item{Y}{a data frame sites-species according to \code{dudiX$tab} with no columns of zero}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{x}{an object of class \code{niche}}
  \item{\dots}{further arguments passed to or from other methods}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{nrepet}{the number of permutations for the testing procedure}
}
\value{
Returns a list of the class \code{niche} (sub-class of \code{dudi}) containing :
 \item{rank}{an integer indicating the rank of the studied matrix}
 \item{nf}{an integer indicating the number of kept axes}
 \item{RV}{a numeric value indicating the RV coefficient}
 \item{eig}{a numeric vector with the all eigenvalues}
 \item{lw}{a data frame with the row weigths (crossed array)}
 \item{tab}{a data frame with the crossed array (averaging species/sites)}
 \item{li}{a data frame with the species coordinates}
 \item{l1}{a data frame with the species normed scores}
 \item{co}{a data frame with the variable coordinates}
 \item{c1}{a data frame with the variable normed scores}
 \item{ls}{a data frame with the site coordinates}
 \item{as}{a data frame with the axis upon niche axis} 
}
\references{
Dolédec, S., Chessel, D. and Gimaret, C. (2000) Niche separation in community analysis: a new method. \emph{Ecology}, \bold{81}, 2914--1927.
}
\author{
Daniel Chessel\cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}\cr
Stephane Dray \email{dray@biomserv.univ-lyon1.fr}
}
\examples{
data(doubs)
dudi1 <- dudi.pca(doubs$mil, scale = TRUE, scan = FALSE, nf = 3)
nic1 <- niche(dudi1, doubs$poi, scann = FALSE)

par(mfrow = c(2,2))
s.traject(dudi1$li, clab = 0)
s.traject(nic1$ls, clab = 0)
s.corcircle(nic1$as)
s.arrow(nic1$c1)

par(mfrow = c(5,6))
for (i in 1:27) s.distri(nic1$ls, as.data.frame(doubs$poi[,i]),
    csub = 2, sub = names(doubs$poi)[i])

par(mfrow = c(1,1))
s.arrow(nic1$li, clab = 0.7)

par(mfrow = c(1,1))
data(trichometeo)
pca1 <- dudi.pca(trichometeo$meteo, scan = FALSE)
nic1 <- niche(pca1, log(trichometeo$fau + 1), scan = FALSE)
plot(nic1)
niche.param(nic1)
rtest(nic1,19)

data(rpjdl)
plot(niche(dudi.pca(rpjdl$mil, scan = FALSE), rpjdl$fau, scan = FALSE))
}
\keyword{multivariate}
