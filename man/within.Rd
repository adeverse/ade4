\encoding{latin1}
\name{within}
\alias{within}
\alias{print.within}
\alias{plot.within}
\title{Within Analyses}
\description{
performs within analyses on an object of class \code{dudi}. 
}
\usage{
within(dudi, fac, scannf = TRUE, nf = 2) 
plot.within (x, xax = 1, yax = 2, \dots) 
print.within (x, \dots)
}
\arguments{
 \item{dudi}{an object of class \code{dudi}}
 \item{fac}{a factor distributing the rows of \code{dudi$tab} in classes }
 \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
 \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
 \item{xax}{the column number for the x-axis}
 \item{yax}{the column number for the y-axis}
 \item{x}{an object of class 'within'}
 \item{\dots}{further arguments passed to or from other methods}
}
\value{
Returns a list of the sub-class \code{within} in the class \code{dudi}
  \item{call}{origine}
  \item{nf}{number of axis saved}
  \item{rank}{rank}
  \item{ratio}{percentage of within inertia}
  \item{eig}{numeric eigen values}
  \item{lw}{numeric row weigths}
  \item{cw}{numeric col weigths}
  \item{tabw}{numeric table weigths}
  \item{fac}{factor for grouping}
  \item{tab}{data frame class-variables}
  \item{li}{data frame row coordinates}
  \item{l1}{data frame row normed scores} 
  \item{co}{data frame column coordinates}
  \item{$c1}{data frame column normed scores}
  \item{ls}{data frame supplementary row coordinates}
  \item{as}{data frame inertia axis onto within axis}
}
\references{
Benzécri, J. P. (1983) Analyse de l'inertie intra-classe par l'analyse d'un tableau de correspondances. \emph{Les Cahiers de l'Analyse des données}, \bold{8}, 351--358.\cr\cr
Dolédec, S. and Chessel, D. (1987) Rythmes saisonniers et composantes stationnelles en milieu aquatique I- Description d'un plan d'observations complet par projection de variables. \emph{Acta Oecologica, Oecologia Generalis}, \bold{8}, 3, 403--426.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(meaudret)
par(mfrow = c(2,2))
pca1 <- dudi.pca(meaudret$mil, scan = FALSE, nf = 4)
s.traject(pca1$li, meaudret$plan$sta, 
    sub = "Principal Component Analysis", csub = 1.5)
wit1 <- within(pca1, meaudret$plan$sta, scan = FALSE, nf = 2)
s.traject(wit1$li, meaudret$plan$sta, 
    sub = "Within site Principal Component Analysis", csub = 1.5)
s.corcircle (wit1$as)
par(mfrow = c(1,1))
plot(wit1)
}
\keyword{multivariate}
