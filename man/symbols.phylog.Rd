\name{symbols.phylog}
\alias{symbols.phylog}
\alias{dotchart.phylog}
\title{Representation of a quantitative variable in front of a phylogenetic tree}
\description{
\code{symbols.phylog} draws the phylogenetic tree and represents the values of the variable by symbols (squares or circles) which size is proportional to value. White symbols correspond to values which are below the mean, and black symbols correspond to values which are over. \cr \cr
\code{dotchart.phylog} represents the phylogenetic tree and draws a Cleveland dot plot of the variable.
}
\usage{
symbols.phylog(phylog, circles, squares, csize = 1, clegend = 1,
 sub = "", csub = 1, possub = "topleft")
dotchart.phylog(phylog, values, ceti = 1, cdot = 1, ...)
}
\arguments{
  \item{phylog}{ an object of class \code{phylog}}
  \item{circles}{ a vector giving the radii of the circles}
  \item{squares}{ a vector giving the length of the sides of the squares}
  \item{values}{a vector giving the position in a \code{dotplot}}
  \item{csize}{ a size coefficient for symbols}
  \item{ceti}{ a character size for the legend of the dot plot, used with \code{par("cex")*ceti}}
  \item{cdot}{ a character size for plotting the points of the dot plot, used with \code{par("cex")*cdot}}
  \item{clegend}{ a character size for the legend used by \code{par("cex")*clegend}}
  \item{sub}{ a string of characters to be inserted as legend}
  \item{csub}{ a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{ a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{\dots}{ further arguments passed to or from other methods}
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} \cr
Sébastien Ollier \email{ollier@biomserv.univ-lyon1.fr}
}
\seealso{\code{\link{table.phylog}} for many variables}
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

par(mfrow=c(2,3))
for (j in 1:6) {
    w <- tab0[,j]
    dotchart.phylog(mjrochet.phy, w, cdot=1.5,
        sub=names(tab0)[j],csub=3,cnodes=2,ceti=1.5)
}
par(mfrow=c(1,1))

}
\keyword{hplot}
