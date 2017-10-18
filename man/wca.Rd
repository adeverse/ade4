\name{wca}

\alias{wca}
\alias{wca.dudi}

\title{Within-Class Analysis}

\description{
Performs a particular case of an Orthogonal Principal Component Analysis with
respect to Instrumental Variables (orthopcaiv), in which there is only a
single factor as covariable.
}

\usage{
\method{wca}{dudi}(x, fac, scannf = TRUE, nf = 2, \dots) 
}

\arguments{
  \item{x}{a duality diagram, object of class \code{\link{dudi}} from
    one of the functions \code{dudi.coa}, \code{dudi.pca},...}
  \item{fac}{a factor partitioning the rows of \code{dudi$tab} in classes}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{\dots}{further arguments passed to or from other methods}
}

\value{
Returns a list of the sub-class \code{within} in the class \code{dudi}
  \item{tab}{a data frame containing the transformed data (substraction of the class mean)}
  \item{call}{the matching call}
  \item{nf}{number of kept axes}
  \item{rank}{the rank of the analysis}
  \item{ratio}{percentage of within-class inertia}
  \item{eig}{a numeric vector containing the eigenvalues}
  \item{lw}{a numeric vector of row weigths}
  \item{cw}{a numeric vector of column weigths}
  \item{tabw}{a numeric vector of class weigths}
  \item{fac}{the factor defining the classes}
  \item{li}{data frame row coordinates}
  \item{l1}{data frame row normed scores} 
  \item{co}{data frame column coordinates}
  \item{c1}{data frame column normed scores}
  \item{ls}{data frame supplementary row coordinates}
  \item{as}{data frame inertia axis onto within axis}
}

\references{
Benzécri, J. P. (1983) Analyse de l'inertie intra-classe par l'analyse d'un 
tableau de correspondances. \emph{Les Cahiers de l'Analyse des données}, \bold{8}, 351--358.\cr\cr
Dolédec, S. and Chessel, D. (1987) Rythmes saisonniers et composantes stationnelles 
en milieu aquatique I- Description d'un plan d'observations complet par projection de 
variables. \emph{Acta Oecologica, Oecologia Generalis}, \bold{8}, 3, 403--426.
}

\note{
To avoid conflict names with the \code{base:::within} function, the
function \code{within} is now deprecated and removed. It 
is replaced by the method \code{wca.dudi} of the new generic \code{wca} function. 
}

\author{
Daniel Chessel \cr
Anne-Béatrice Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
}

\examples{
data(meaudret)
pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 4)
wit1 <- wca(pca1, meaudret$design$site, scan = FALSE, nf = 2)

if(adegraphicsLoaded()) {
  g1 <- s.traject(pca1$li, meaudret$design$site, psub.text = "Principal Component Analysis", 
    plines.lty = 1:nlevels(meaudret$design$site), psub.cex = 1.5, plot = FALSE)
  g2 <- s.traject(wit1$li, meaudret$design$site, 
    psub.text = "Within site Principal Component Analysis", 
    plines.lty = 1:nlevels(meaudret$design$site), psub.cex = 1.5, plot = FALSE)
  g3 <- s.corcircle (wit1$as, plot = FALSE)
  G <- ADEgS(list(g1, g2, g3), layout = c(2, 2))
  
} else {
  par(mfrow = c(2, 2))
  s.traject(pca1$li, meaudret$design$site, sub = "Principal Component Analysis", csub = 1.5)
  s.traject(wit1$li, meaudret$design$site, sub = "Within site Principal Component Analysis", 
    csub = 1.5)
  s.corcircle (wit1$as)
  par(mfrow = c(1,1))
}
plot(wit1)
}

\keyword{multivariate}