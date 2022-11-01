\name{bca}

\alias{bca}
\alias{bca.dudi}

\title{Between-Class Analysis}

\description{
Performs a particular case of a Principal Component Analysis with
respect to Instrumental Variables (pcaiv), in which there is only a
single factor as explanatory variable.
}

\usage{
\method{bca}{dudi}(x, fac, scannf = TRUE, nf = 2, \dots) 
}

\arguments{
  \item{x}{a duality diagram, object of class \code{\link{dudi}} from
    one of the functions \code{dudi.coa}, \code{dudi.pca},...}
  \item{fac}{a factor partitioning the rows of \code{dudi$tab} in classes}
  \item{scannf}{a logical value indicating whether the eigenvalues barplot should be displayed}
  \item{nf}{if scannf FALSE, a numeric value indicating the number of kept axes}
  \item{\dots}{further arguments passed to or from other methods}
}

\value{
Returns a list of class \code{\link{dudi}}, subclass 'between' containing
  \item{tab}{a data frame class-variables containing the means per class
  for each variable}
  \item{cw}{a numeric vector of the column weigths}
  \item{lw}{a numeric vector of the class weigths}
  \item{eig}{a numeric vector with all the eigenvalues}
  \item{rank}{the rank of the analysis}
  \item{nf}{an integer value indicating the number of kept axes}
  \item{c1}{a data frame with the column normed scores}
  \item{l1}{a data frame with the class normed scores}
  \item{co}{a data frame  with the column coordinates}
  \item{li}{a data frame with the class coordinates}
  \item{call}{the matching call}
  \item{ratio}{the bewteen-class inertia percentage}
  \item{ls}{a data frame with the row coordinates}
  \item{as}{a data frame containing the projection of inertia axes onto between axes}
}

\references{
Dolédec, S. and Chessel, D. (1987) Rythmes saisonniers et composantes stationnelles 
en milieu aquatique I- Description d'un plan d'observations complet par 
projection de variables. \emph{Acta Oecologica, Oecologia Generalis}, \bold{8}, 3, 403--426.
}

\note{
To avoid conflict names with the \code{base:::within} function, the
function \code{within} is now deprecated and removed. To be
consistent, the \code{between} function is also deprecated and
is replaced by the method \code{bca.dudi} of the new generic \code{bca} function. 
}

\author{
Daniel Chessel \cr
Anne-Béatrice Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
}

\examples{
data(meaudret)
pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 4)
pca2 <- dudi.pca(meaudret$spe, scal = FALSE, scan = FALSE, nf = 4)
bet1 <- bca(pca1, meaudret$design$site, scan = FALSE, nf = 2)
bet2 <- bca(pca2, meaudret$design$site, scan = FALSE, nf = 2)
  
if(adegraphicsLoaded()) {
  g1 <- s.class(pca1$li, meaudret$design$site, psub.text = "Principal Component Analysis (env)",
    plot = FALSE)
  g2 <- s.class(pca2$li, meaudret$design$site, psub.text = "Principal Component Analysis (spe)",
    plot = FALSE)
  g3 <- s.class(bet1$ls, meaudret$design$site, psub.text = "Between sites PCA (env)", plot = FALSE)
  g4 <- s.class(bet2$ls, meaudret$design$site, psub.text = "Between sites PCA (spe)", plot = FALSE)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  
} else {
  par(mfrow = c(2, 2))
  s.class(pca1$li, meaudret$design$site, sub = "Principal Component Analysis (env)", csub = 1.75)
  s.class(pca2$li, meaudret$design$site, sub = "Principal Component Analysis (spe)", csub = 1.75)
  s.class(bet1$ls, meaudret$design$site, sub = "Between sites PCA (env)", csub = 1.75)
  s.class(bet2$ls, meaudret$design$site, sub = "Between sites PCA (spe)", csub = 1.75)
  par(mfrow = c(1, 1))
}

coib <- coinertia(bet1, bet2, scann = FALSE)
plot(coib)
}
\keyword{multivariate}
