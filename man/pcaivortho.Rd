\name{pcaivortho}
\alias{pcaivortho}
\alias{summary.pcaivortho}
\title{Principal Component Analysis with respect to orthogonal instrumental variables}
\description{
performs a Principal Component Analysis with respect to orthogonal instrumental variables. 
}
\usage{
pcaivortho(dudi, df, scannf = TRUE, nf = 2)
\method{summary}{pcaivortho}(object, \dots) 
}
\arguments{
  \item{dudi}{a duality diagram, object of class \code{dudi}}
  \item{df}{a data frame with the same rows}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{object}{an object of class \code{pcaiv}}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
an object of class 'pcaivortho' sub-class of class \code{dudi}
  \item{rank}{an integer indicating the rank of the studied matrix}
  \item{nf}{an integer indicating the number of kept axes}
  \item{eig}{a vector with the all eigenvalues}
  \item{lw}{a numeric vector with the row weigths (from \code{dudi})}
  \item{cw}{a numeric vector with the column weigths (from \code{dudi})}
  \item{Y}{a data frame with the dependant variables}
  \item{X}{a data frame with the explanatory variables}
  \item{tab}{a data frame with the modified array (projected variables)}
  \item{c1}{a data frame with the Pseudo Principal Axes (PPA)}
  \item{as}{a data frame with the Principal axis of \code{dudi$tab} on PAP}
  \item{ls}{a data frame with the projection of lines of \code{dudi$tab} on PPA}
  \item{li}{a data frame \code{dudi$ls} with the predicted values by X}
  \item{l1}{a data frame with the Constraint Principal Components (CPC)}
  \item{co}{a data frame with the inner product between the CPC and Y}
  \item{param}{a data frame containing a summary}
}
\author{
Daniel Chessel \cr
Anne-Béatrice Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}\cr
Stéphane Dray \email{stephane.dray@univ-lyon1.fr}
}
\references{
Rao, C. R. (1964) The use and interpretation of principal component analysis in applied research. \emph{Sankhya}, \bold{A 26}, 329--359.\cr\cr
Sabatier, R., Lebreton J. D. and Chessel D. (1989) Principal component analysis with instrumental variables as a tool for modelling composition data. In R. Coppi and S. Bolasco, editors. \emph{Multiway data analysis}, Elsevier Science Publishers B.V., North-Holland, 341--352
}
\examples{
\dontrun{
data(avimedi)
cla <- avimedi$plan$reg:avimedi$plan$str
# simple ordination
coa1 <- dudi.coa(avimedi$fau, scan = FALSE, nf = 3)
# within region
w1 <- wca(coa1, avimedi$plan$reg, scan = FALSE)
# no region the same result
pcaivnonA <- pcaivortho(coa1, avimedi$plan$reg, scan = FALSE)
summary(pcaivnonA)
# region + strate
interAplusB <- pcaiv(coa1, avimedi$plan, scan = FALSE)

if(adegraphicsLoaded()) {
  g1 <- s.class(coa1$li, cla, psub.text = "Sans contrainte", plot = FALSE)
  g21 <- s.match(w1$li, w1$ls, plab.cex = 0, psub.text = "Intra Région", plot = FALSE)
  g22 <- s.class(w1$li, cla, plot = FALSE)
  g2 <- superpose(g21, g22)
  g31 <- s.match(pcaivnonA$li, pcaivnonA$ls, plab.cex = 0, psub.tex = "Contrainte Non A", 
    plot = FALSE)
  g32 <- s.class(pcaivnonA$li, cla, plot = FALSE)
  g3 <- superpose(g31, g32)
  g41 <- s.match(interAplusB$li, interAplusB$ls, plab.cex = 0, psub.text = "Contrainte A + B", 
    plot = FALSE)
  g42 <- s.class(interAplusB$li, cla, plot = FALSE)
  g4 <- superpose(g41, g42)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))

} else {
  par(mfrow = c(2, 2))
  s.class(coa1$li, cla, sub = "Sans contrainte")
  s.match(w1$li, w1$ls, clab = 0, sub = "Intra Région")
  s.class(w1$li, cla, add.plot = TRUE)
  s.match(pcaivnonA$li, pcaivnonA$ls, clab = 0, sub = "Contrainte Non A")
  s.class(pcaivnonA$li, cla, add.plot = TRUE)
  s.match(interAplusB$li, interAplusB$ls, clab = 0, sub = "Contrainte A + B")
  s.class(interAplusB$li, cla, add.plot = TRUE)
  par(mfrow = c(1,1))
}}}
\keyword{multivariate}
