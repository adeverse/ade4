\name{pcaivortho}
\alias{pcaivortho}
\title{Principal Component Analysis with respect to orthogonal instrumental variables}
\description{
performs a Principal Component Analysis with respect to orthogonal instrumental variables. 
}
\usage{
pcaivortho(dudi, df, scannf = TRUE, nf = 2)
}
\arguments{
  \item{dudi}{a duality diagram, object of class \code{dudi}}
  \item{df}{a data frame with the same rows}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
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
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\references{
Rao, C. R. (1964) The use and interpretation of principal component analysis in applied research. \emph{Sankhya}, \bold{A 26}, 329--359.\cr\cr
Sabatier, R., Lebreton J. D. and Chessel D. (1989) Principal component analysis with instrumental variables as a tool for modelling composition data. In R. Coppi and S. Bolasco, editors. \emph{Multiway data analysis}, Elsevier Science Publishers B.V., North-Holland, 341--352
}
\examples{
\dontrun{
par(mfrow = c(2,2))
data(avimedi)
cla <- avimedi$plan$reg:avimedi$plan$str

# simple ordination
coa1 <- dudi.coa(avimedi$fau, scan = FALSE, nf = 3)
s.class(coa1$li, cla, sub = "Sans contrainte")

# within region
w1 <- within(coa1, avimedi$plan$reg, scan = FALSE)
s.match(w1$li, w1$ls, clab = 0, sub = "Intra Région")
s.class(w1$li, cla, add.plot = TRUE)

# no region the same result
pcaivnonA <- pcaivortho(coa1, avimedi$plan$reg, scan = FALSE)
s.match(pcaivnonA$li, pcaivnonA$ls, clab = 0, 
    sub = "Contrainte Non A")
s.class(pcaivnonA$li, cla, add.plot = TRUE)

# region + strate
interAplusB <- pcaiv(coa1, avimedi$plan, scan = FALSE)
s.match(interAplusB$li, interAplusB$ls, clab = 0, 
    sub = "Contrainte A + B")
s.class(interAplusB$li, cla, add.plot = TRUE)

par(mfrow = c(1,1))}}
\keyword{multivariate}
