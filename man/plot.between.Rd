\encoding{latin1}
\name{between}
\alias{summary.between}
\alias{print.between}
\alias{plot.between}
\alias{print.betcoi}
\alias{plot.betcoi}
\title{Between-Class Analysis}
\description{
Outputs and graphical representations of the results of a between-class analysis.}
\usage{
\method{plot}{between}(x, xax = 1, yax = 2, \dots) 
\method{print}{between}(x, \dots)
\method{plot}{betcoi}(x, xax = 1, yax = 2, \dots)
\method{print}{betcoi}(x, \dots)
\method{summary}{between}(object, \dots)
}
\arguments{
  \item{x,object}{an object of class \code{between} or \code{betcoi}}
  \item{xax, yax}{the column index of the x-axis and the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}

\references{
Dolédec, S. and Chessel, D. (1987) Rythmes saisonniers et composantes stationnelles en milieu aquatique
I- Description d'un plan d'observations complet par projection de variables. \emph{Acta Oecologica, Oecologia Generalis}, \bold{8}, 3, 403--426.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}\cr
Stephane Dray \email{stephane.dray@univ-lyon1.fr}
}
\seealso{\code{\link{bca.dudi}}, \code{\link{bca.coinertia}}}
\examples{
data(meaudret)

pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 4)
pca2 <- dudi.pca(meaudret$spe, scal = FALSE, scan = FALSE, nf = 4)
bet1 <- bca(pca1, meaudret$design$site, scan = FALSE, nf = 2)
bet2 <- bca(pca2, meaudret$design$site, scan = FALSE, nf = 2)

if(adegraphicsLoaded()) {
  g1 <- s.class(pca1$li, meaudret$design$site, psub.text = "Principal Component Analysis (env)", 
    plot = F)
  g2 <- s.class(pca2$li, meaudret$design$site, psub.text = "Principal Component Analysis (spe)", 
    plot = F)
  g3 <- s.class(bet1$ls, meaudret$design$site, psub.text = "Between sites PCA (env)", 
    plot = F)
  g4 <- s.class(bet2$ls, meaudret$design$site, psub.text = "Between sites PCA (spe)", 
    plot = F)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  
} else {
  par(mfrow = c(2, 2))
  s.class(pca1$li, meaudret$design$site, sub = "Principal Component Analysis (env)", csub = 1.75)
  s.class(pca2$li, meaudret$design$site, sub = "Principal Component Analysis (spe)", csub = 1.75)
  s.class(bet1$ls, meaudret$design$site, sub = "Between sites PCA (env)", csub = 1.75)
  s.class(bet2$ls, meaudret$design$site, sub = "Between sites PCA (spe)", csub = 1.75)
  par(mfrow = c(1,1))
}

coib <- coinertia(bet1, bet2, scann = FALSE)
plot(coib)
}
\keyword{multivariate}
