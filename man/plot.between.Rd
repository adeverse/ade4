\encoding{latin1}
\name{between}
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
}
\arguments{
  \item{x}{an object of class \code{between} or \code{betcoi}}
  \item{xax, yax}{the column index of the x-axis and the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}

\references{
Dol�dec, S. and Chessel, D. (1987) Rythmes saisonniers et composantes stationnelles en milieu aquatique
I- Description d'un plan d'observations complet par projection de variables. \emph{Acta Oecologica, Oecologia Generalis}, \bold{8}, 3, 403--426.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}\cr
Stephane Dray \email{stephane.dray@univ-lyon1.fr}
}
\seealso{\code{\link{bca.dudi}}, \code{\link{bca.coinertia}}}
\examples{
data(meaudret)
par(mfrow = c(2,2))
pca1 <- dudi.pca(meaudret$mil, scan = FALSE, nf = 4)
s.class(pca1$li, meaudret$plan$sta,
    sub = "Principal Component Analysis (mil)", csub = 1.75)
pca2 <- dudi.pca(meaudret$fau, scal = FALSE, scan = FALSE, nf = 4)
s.class(pca2$li, meaudret$pla$sta,
    sub = "Principal Component Analysis (fau)", csub = 1.75)
bet1 <- bca(pca1, meaudret$plan$sta, scan = FALSE, nf = 2)
bet2 <- bca(pca2, meaudret$plan$sta, scan = FALSE, nf = 2)
s.class(bet1$ls, meaudret$plan$sta,
    sub = "Between sites PCA (mil)", csub = 1.75)
s.class(bet2$ls, meaudret$plan$sta,
    sub = "Between sites PCA (fau)", csub = 1.75)

par(mfrow = c(1,1))
coib <- coinertia(bet1, bet2, scann = FALSE)
plot(coib)
}
\keyword{multivariate}