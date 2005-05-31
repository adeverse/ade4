\name{originality}
\alias{originality}
\title{Originality of a species
}
\description{
computes originality values for species from an ultrametric phylogenetic tree.
}
\usage{
originality(phyl, method = 5)
}
\arguments{
  \item{phyl}{an object of class phylog}
  \item{method}{a vector containing integers between 1 and 5. }
}
\Details{
1 = Vane-Wright et al.'s (1991) node-counting index
2 = May's (1990) branch-counting index
3 = Nixon & Wheeler's (1991) unweighted index*, *based on the sum of units in binary values
4 = Nixon & Wheeler's (1991) weighted index 
5 = QE-based index
}
\value{
Returns a data frame with species in rows, and the selected indices of originality in columns. 
Indices are expressed as percentages.
}
\references{
Pavoine, S., Ollier, S. and Dufour, A.-B. (2005)  Is the originality of a species measurable? 
\emph{Ecology Letters}, \bold{8}, 579--586.

Vane-Wright, R.I., Humphries, C.J. and Williams, P.H. (1991). What to protect? Systematics 
and the agony of choice. \emph{Biological Conservation}, \bold{55}, 235--254. 

May, R.M. (1990). Taxonomy as destiny. \emph{Nature}, \bold{347}, 129--130. 

Nixon, K.C. & Wheeler, Q.D. (1992). Measures of phylogenetic diversity. In: \emph{Extinction and 
Phylogeny} (eds. Novacek, M.J. and Wheeler, Q.D.), 216--234, Columbia University Press, New York.
}
\author{
Sandrine Pavoine \email{pavoine@biomserv.univ-lyon1.fr}
}
\examples{
data(carni70)
carni70.phy <- newick2phylog(carni70$tre)
ori.tab <- originality(carni70.phy, 1:5)
names(ori.tab)
dotchart.phylog(carni70.phy, ori.tab, scaling=FALSE, yjoining=0, 
    cleaves=0, ceti=0.5, csub=0.7, cdot=0.5)
}
\keyword{multivariate}
