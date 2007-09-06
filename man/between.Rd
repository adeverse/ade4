\encoding{latin1}
\name{between}
\alias{between}
\alias{print.between}
\alias{plot.between}
\title{Between-Class Analysis}
\description{
Performs a particular case of a Principal Component Analysis with respect to Instrumental Variables,
in which there is only one instrumental variable, and it is a factor.
}
\usage{
between(dudi, fac, scannf = TRUE, nf = 2)
plot.between(x, xax = 1, yax = 2, \dots) 
print.between(x, \dots) 
}
\arguments{
  \item{dudi}{a duality diagram, object of class \code{\link{dudi}} from one of the functions dudi.coa, dudi.pca, ...}
  \item{fac}{a factor partitioning the rows of \code{dudi$tab} in classes}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, a numeric value indicating the number of kept axes}
  \cr
  \item{x}{an object of class 'between'}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
Returns a list of subclass 'between' of class 'dudi' (see \code{\link{dudi}})
  \item{tab}{a data frame class-variables, array of variables means in each class}
  \item{cw}{a numeric vector of the column weigths}
  \item{lw}{a numeric vector of the group weigths}
  \item{eig}{a numeric vector with all the eigenvalues}
  \item{rank}{an integer}
  \item{nf}{an integer value indicating the number of kept axes}
  \item{c1}{a data frame with the column normed scores}
  \item{l1}{a data frame with the class normed scores}
  \item{co}{a data frame  with the column coordinates}
  \item{li}{a data frame with the class coordinates}
  \item{call}{the origin}
  \item{ratio}{the bewteen-class inertia percentage}
  \item{ls}{a data frame with the row coordinates}
  \item{as}{a data frame containing the projection of inertia axes onto between axes}
}
\references{
Dolédec, S. and Chessel, D. (1987) Rythmes saisonniers et composantes stationnelles en milieu aquatique
I- Description d'un plan d'observations complet par projection de variables. \emph{Acta Oecologica, Oecologia Generalis}, \bold{8}, 3, 403--426.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(meaudret)
par(mfrow = c(2,2))
pca1 <- dudi.pca(meaudret$mil, scan = FALSE, nf = 4)
s.class(pca1$li, meaudret$plan$sta,
    sub = "Principal Component Analysis (mil)", csub = 1.75)
pca2 <- dudi.pca(meaudret$fau, scal = FALSE, scan = FALSE, nf = 4)
s.class(pca2$li, meaudret$pla$sta,
    sub = "Principal Component Analysis (fau)", csub = 1.75)
bet1 <- between(pca1, meaudret$plan$sta, scan = FALSE, nf = 2)
bet2 <- between(pca2, meaudret$plan$sta, scan = FALSE, nf = 2)
s.class(bet1$ls, meaudret$plan$sta,
    sub = "Between sites PCA (mil)", csub = 1.75)
s.class(bet2$ls, meaudret$plan$sta,
    sub = "Between sites PCA (fau)", csub = 1.75)

par(mfrow = c(1,1))
coib <- coinertia(bet1, bet2, scann = FALSE)
plot(coib)
}
\keyword{multivariate}
