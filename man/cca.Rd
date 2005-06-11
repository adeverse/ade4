\name{cca}
\alias{cca}
\title{Canonical Correspondence Analysis}
\description{
Performs a Canonical Correspondence Analysis.  
}
\usage{
cca(sitspe, sitenv, scannf = TRUE, nf = 2)
}
\arguments{
  \item{sitspe}{a data frame for correspondence analysis, typically a sites x species table}
  \item{sitenv}{a data frame containing variables, typically a sites x environmental variables table}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
}
\value{
returns an object of class \code{pcaiv}. See \code{\link{pcaiv}}
}
\references{
Ter Braak, C. J. F. (1986) Canonical correspondence analysis : a new eigenvector technique for multivariate direct gradient analysis. \emph{Ecology}, \bold{67}, 1167--1179.\cr

Ter Braak, C. J. F. (1987) The analysis of vegetation-environment relationships by canonical correspondence analysis. \emph{Vegetatio}, \bold{69}, 69--77.\cr

Chessel, D., Lebreton J. D. and Yoccoz N. (1987) Propriétés de l'analyse canonique des correspondances. Une utilisation en hydrobiologie. \emph{Revue de Statistique Appliquée}, \bold{35}, 55--72.\cr
}
\seealso{\code{\link{cca}} in the package \code{vegan}}
}
\author{
Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}\cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(rpjdl)
millog <- log(rpjdl$mil + 1)
iv1 <- cca(rpjdl$fau, millog, scan = FALSE)
plot(iv1)

# analysis with c1 - as - li -ls
# projections of inertia axes on PCAIV axes
s.corcircle(iv1$as)

# Species positions
s.label(iv1$c1, 2, 1, clab = 0.5, xlim = c(-4,4))
# Sites positions at the weighted mean of present species
s.label(iv1$ls, 2, 1, clab = 0, cpoi = 1, add.p = TRUE)

# Prediction of the positions by regression on environmental variables
s.match(iv1$ls, iv1$li, 2, 1, clab = 0.5)

# analysis with fa - l1 - co -cor
# canonical weights giving unit variance combinations
s.arrow(iv1$fa)

# sites position by environmental variables combinations
# position of species by averaging
s.label(iv1$l1, 2, 1, clab = 0, cpoi = 1.5)
s.label(iv1$co, 2, 1, add.plot = TRUE)

s.distri(iv1$l1, rpjdl$fau, 2, 1, cell = 0, csta = 0.33)
s.label(iv1$co, 2, 1, clab = 0.75, add.plot = TRUE)

# coherence between weights and correlations
par(mfrow = c(1,2))
s.corcircle(iv1$cor, 2, 1)
s.arrow(iv1$fa, 2, 1)
par(mfrow = c(1,1))
 }
\keyword{multivariate}
