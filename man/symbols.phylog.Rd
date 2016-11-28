\name{symbols.phylog}
\alias{symbols.phylog}
\title{Representation of a quantitative variable in front of a phylogenetic tree}
\description{
\code{symbols.phylog} draws the phylogenetic tree and represents the values of
 the variable by symbols (squares or circles) which size is proportional to value.
 White symbols correspond to values which are below the mean, and black symbols
 correspond to values which are over.
}
\usage{
symbols.phylog(phylog, circles, squares, csize = 1, clegend = 1,
 sub = "", csub = 1, possub = "topleft")
}
\arguments{
  \item{phylog}{ an object of class \code{phylog}}
  \item{circles}{ a vector giving the radii of the circles}
  \item{squares}{ a vector giving the length of the sides of the squares}
  \item{csize}{ a size coefficient for symbols}
  \item{clegend}{ a character size for the legend used by \code{par("cex")*clegend}}
  \item{sub}{ a string of characters to be inserted as legend}
  \item{csub}{ a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{ a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
}
\author{
Daniel Chessel  \cr
Sébastien Ollier \email{sebastien.ollier@u-psud.fr}
}
\seealso{\code{\link{table.phylog}} and \code{\link{dotchart.phylog}} for many variables}
\examples{
data(mjrochet)
mjrochet.phy <- newick2phylog(mjrochet$tre)
tab0 <- data.frame(scalewt(log(mjrochet$tab)))
par(mfrow=c(3,2))
for (j in 1:6) {
    w <- tab0[,j]
    symbols.phylog(phylog = mjrochet.phy, w, csi = 1.5, cleg = 1.5,
     sub = names(tab0)[j], csub = 3)
}
par(mfrow=c(1,1))
}
\keyword{hplot}
