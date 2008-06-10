\encoding{latin1}
\name{orthogram}
\alias{orthogram}
\title{Orthonormal decomposition of variance}
\description{
This function performs the orthonormal decomposition of variance of a quantitative variable on an orthonormal basis. It also returns the results of five non parametric tests associated to the variance decomposition. 
It thus provides tools (graphical displays and test) for analysing phylogenetic, spatial and temporal pattern of one quantitative variable.
}
\usage{
orthogram(x, orthobas = NULL, neig = NULL, phylog = NULL,
     nrepet = 999, posinega = 0, tol = 1e-07, na.action = c("fail",
     "mean"), cdot = 1.5, cfont.main = 1.5, lwd = 2, nclass,
     high.scores = 0,alter=c("greater", "less", "two-sided"))
}
\arguments{
  \item{x}{a numeric vector corresponding to the quantitative variable}
  \item{orthobas}{an object of class \code{'orthobasis'}}
  \item{neig}{an object of class \code{'neig'}}
  \item{phylog}{an object of class \code{'phylog'}}
  \item{nrepet}{an integer giving the number of permutations}
  \item{posinega}{a parameter for the ratio test. If posinega > 0, the function computes the ratio test.}
  \item{tol}{a tolerance threshold for orthonormality condition}
  \item{na.action}{if 'fail' stops the execution of the current expression when \code{z} contains any missing value. If 'mean' replaces any missing values by mean(\code{z})}
  \item{cdot}{a character size for points on the cumulative decomposition display}
  \item{cfont.main}{a character size for titles}
  \item{lwd}{a character size for dash lines}
  \item{nclass}{a single number giving the number of cells for the histogram}
  \item{high.scores}{a single number giving the number of vectors to
    return. If > 0, the function returns labels of vectors that explains
    the larger part of variance.}
  \item{alter}{a character string specifying the alternative hypothesis,
    must be one of "greater" (default), "less" or "two-sided"}
}
\details{
The function computes the variance decomposition of a quantitative vector x on an orthonormal basis B. The variable is normalized given the uniform weight to eliminate problem of scales.
It plots the squared correlations \eqn{R^{2}}{R^2} between x and vectors of B (variance decomposition) and the cumulated squared correlations \eqn{SR^{2}}{SR^2} (cumulative decomposition).
The function also provides five non parametric tests to test the existence of autocorrelation. The tests derive from the five following statistics :
    \item{R2Max}{=\eqn{\max(R^{2})}{max(R^2)}. It takes high value when a high part of the variability is explained by one score.}
    \item{SkR2k}{=\eqn{\sum_{i=1}^{n-1}(iR^{2}_i)}{sum_i^(n-1) i*(R^2)_i}. It compares the part of variance explained by internal nodes to the one explained by end nodes.}
    \item{Dmax}{=\eqn{\max_{m=1,...,n-1}(\sum_{j=1}^{m}R^{2}_j - \frac{m}{n-1})}{max_(m=1,...,n-1)(sum_(j=1)^m(R^2_j) - (m/n-1))}. It examines the accumulation of variance for a sequence of scores.}
    \item{SCE}{=\eqn{\sum_{m=1}^{n-1} (\sum_{j=1}^{m}R^{2}_j - \frac{m}{n-1})^{2}}{sum_(m=1)^(n-1)(sum_(j=1)^m(R^2_j) - (m/n-1))^2}. It examines also the accumulation of variance for a sequence of scores.}
    \item{ratio}{depends of the parameter posinega. If posinega > 0, the statistic ratio exists and equals \eqn{\sum_{i=1}^{posinega}R^{2}_i}{sum_i (R^2)_i with i < posinega + 1}. It compares the part of variance explained by internal nodes to the one explained by end nodes when we can define how many vectors correspond to internal nodes.}
}
\value{
If (high.scores = 0), returns an object of class \code{'krandtest'} (randomization tests) corresponding to the five non parametric tests. \cr \cr
If (high.scores > 0), returns a list containg : 
    \item{w}{: an object of class \code{'krandtest'} (randomization tests)}
    \item{scores.order}{: a vector which terms give labels of vectors that explain the larger part of variance}   
}
\references{
Ollier, S., Chessel, D. and Couteron, P. (2005) Orthonormal Transform to Decompose the Variance of a Life-History Trait across a Phylogenetic Tree. \emph{Biometrics}, \bold{62}, 471--477.
}
\author{Sébastien Ollier \email{ollier@biomserv.univ-lyon1.fr} \cr
Daniel Chessel 
}
\seealso{\code{\link{gridrowcol}}, \code{\link{orthobasis}}, \code{\link{mld}}}
\examples{
# a phylogenetic example
data(ungulates)
ung.phy <- newick2phylog(ungulates$tre)
FemBodyMass <- log(ungulates$tab[,1])
NeonatBodyMass <- log((ungulates$tab[,2]+ungulates$tab[,3])/2)
plot(FemBodyMass,NeonatBodyMass, pch = 20, cex = 2)
abline(lm(NeonatBodyMass~FemBodyMass))
z <- residuals(lm(NeonatBodyMass~FemBodyMass))
dotchart.phylog(ung.phy,val = z, clabel.n = 1,
     labels.n = ung.phy$Blabels, cle = 1.5, cdot = 2)
table.phylog(ung.phy$Bscores, ung.phy,clabel.n = 1,
     labels.n = ung.phy$Blabels)
orthogram(z, ung.phy$Bscores)
orthogram(z, phyl=ung.phy) # the same thing

# a spatial example
data(irishdata)
neig1 <- neig(mat01 = 1*(irishdata$link > 0))
sco1 <- scores.neig(neig1)
z <- scalewt(irishdata$tab$cow)
orthogram(z, sco1)

# a temporal example
data(arrival)
w <- orthobasis.circ(24)
orthogram(arrival$hours, w)
par(mfrow = c(1,2))
dotcircle(arrival$hours)
dotcircle(w[,2])
par(mfrow = c(1,1))

data(lynx)
ortho <- orthobasis.line(114)
orthogram(lynx,ortho)
attributes(lynx)$tsp
par(mfrow = c(2,1))
par(mar = c(4,4,2,2))
plot.ts(lynx)
plot(ts(ortho[,23], start = 1821, end = 1934, freq = 1), ylab = "score 23")
par(mfrow = c(1,1))
}
\keyword{spatial}
\keyword{ts}
