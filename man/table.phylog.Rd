\encoding{latin1}
\name{table.phylog}
\alias{table.phylog}
\title{Plot arrays in front of a phylogenetic tree}
\description{
This function gives a graphical display for viewing the numbers of a table by square sizes in front of the corresponding phylogenetic tree.
}
\usage{
table.phylog(df, phylog, x = 1:ncol(df), f.phylog = 0.5,
 labels.row = gsub("[_]", " ", row.names(df)), clabel.row = 1,
 labels.col = names(df), clabel.col = 1,
 labels.nod = names(phylog$nodes), clabel.nod = 0, cleaves = 1,
 cnodes = 1, csize = 1, grid = TRUE, clegend = 0.75)
}
\arguments{
  \item{df}{: a data frame or a matrix}
  \item{phylog}{: an object of class \code{'phylog'}}
  \item{x}{: a vector of values to position the columns}
  \item{f.phylog}{: a size coefficient for tree size (a parameter to draw the tree in proportion to leaves labels)}
  \item{labels.row}{: a vector of strings of characters for row labels}
  \item{clabel.row}{: a character size for the leaves labels, used with \code{par("cex")*clabel.row}. If zero, no row labels are drawn}
  \item{labels.col}{: a vector of strings of characters for columns labels}
  \item{clabel.col}{: a character size for the leaves labels, used with \code{par("cex")*clabel.col}. If zero, no column labels are drawn}
  \item{labels.nod}{: a vector of strings of characters for the nodes labels}
  \item{clabel.nod}{: a character size for the nodes labels, used with \code{par("cex")*clabel.nodes}. If zero, no nodes labels are drawn}
  \item{cleaves}{: a character size for plotting the points that represent the leaves, used with \code{par("cex")*cleaves}. If zero, no points are drawn}
  \item{cnodes}{: a character size for plotting the points that represent the nodes, used with \code{par("cex")*cnodes}. If zero, no points are drawn}
  \item{csize}{: a size coefficient for symbols}
  \item{grid}{: a logical value indicating whether the grid should be plotted}
  \item{clegend}{: a character size for the legend (if 0, no legend)}
}
\author{Daniel Chessel  \cr
Sébastien Ollier \email{ollier@biomserv.univ-lyon1.fr}
}
\details{The function verifies that \code{sort(row.names(df))==sort(names(phylog$leaves))}. 
If \code{df} is a matrix the function uses \code{as.data.frame(df)}. }
 
\seealso{\code{\link{symbols.phylog}} for one variable}
\examples{
\dontrun{
data(newick.eg)
w.phy <- newick2phylog(newick.eg[[9]])
w.tab <- data.frame(matrix(rnorm(620), 31, 20))
row.names(w.tab) <- sort(names(w.phy$leaves))
table.phylog(w.tab, w.phy, csi = 1.5, f = 0.5,
 clabel.n = 0.75, clabel.c = 0.5)
}
}
\keyword{hplot}
