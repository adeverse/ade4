\name{dotchart.phylog}
\alias{dotchart.phylog}
\title{Representation of many quantitative variables in front of a phylogenetic tree}
\description{
\code{dotchart.phylog} represents the phylogenetic tree and draws Cleveland dot
 plot of each variable.
}
\usage{
dotchart.phylog(phylog, values, y = NULL, scaling = TRUE, ranging =
TRUE, yranging = NULL, joining = TRUE, yjoining = NULL, ceti = 1, cdot =
1, csub = 1, f.phylog = 1/(1 + ncol(values)), ...)
}
\arguments{
  \item{phylog}{ an object of class \code{phylog}}
  \item{values}{ a vector or a data frame giving the variables}
  \item{y}{ a vector which values correspond to leaves positions}
  \item{scaling}{ if TRUE, data are scaled}
  \item{ranging}{ if TRUE, dotplots are drawn with the same horizontal limits}
  \item{yranging}{ a vector with two values giving the horizontal limits.
   If NULL, horizontal limits are defined by lower and upper values of data}
  \item{joining}{ if TRUE, segments join each point to a central value}
  \item{yjoining}{ a vector with the central value. If NULL, the central value equals 0}
  \item{ceti}{ a character size for editing horizontal limits, \cr 
  used with \code{par("cex")*ceti}}
  \item{cdot}{ a character size for plotting the points of the dot plot,
   used with \code{par("cex")*cdot}}
  \item{csub}{ a character size for editing the names of variables, \cr 
  used with \code{par("cex")*csub}}
  \item{f.phylog}{ a size coefficient for tree size (a parameter to draw the tree
   in proportion to leaves labels)}
  \item{\dots}{ further arguments passed to or from other methods}
}
\author{
Daniel Chessel  \cr
Sébastien Ollier \email{sebastien.ollier@u-psud.fr}
}
\seealso{\code{\link{symbols.phylog}} and \code{\link{table.phylog}}}
\examples{
# one variable
tre <- c("((A,B),(C,D));")
phy <- newick2phylog(tre)
x <- 1:4
par(mfrow = c(2,2))
dotchart.phylog(phy, x, scaling = FALSE)
dotchart.phylog(phy, x)
dotchart.phylog(phy, x, joining = FALSE)
dotchart.phylog(phy, x, scaling = FALSE,
 yjoining = 0, yranging = c(-1, 5))
par(mfrow = c(1,1))

# many variables
data(mjrochet)
phy <- newick2phylog(mjrochet$tre)
tab <- data.frame(log(mjrochet$tab))
dotchart.phylog(phy, tab, ceti = 0.5, csub = 0.6,
 cleaves = 0, cdot = 0.6)
par(mfrow=c(1,1))
}
\keyword{hplot}
