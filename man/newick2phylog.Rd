\name{newick2phylog}
\alias{newick2phylog}
\alias{hclust2phylog}
\alias{taxo2phylog}
\alias{newick2phylog.addtools}
\title{Create phylogeny}
\description{
The first three functions ensure to create object of class \code{phylog} from either a character string in Newick format (\code{newick2phylog}) or an object of class \code{'hclust'} (\code{hclust2phylog}) or a taxonomy (\code{taxo2phylog}).
The function \code{newick2phylog.addtools} is an internal function called by \code{newick2phylog}, \code{hclust2phylog} and \code{taxo2phylog} when \code{newick2phylog.addtools} = TRUE. It adds some items in \code{'phylog'} objects.
}
\usage{
newick2phylog(x.tre, add.tools = TRUE, call = match.call())
hclust2phylog(hc, add.tools = TRUE)
taxo2phylog(taxo, add.tools = TRUE)
newick2phylog.addtools(res, tol = 1e-07)
}
\arguments{
  \item{x.tre}{a character string corresponding to a phylogenetic tree in Newick format\cr
   (see \url{http://evolution.genetics.washington.edu/phylip/newicktree.html})}
  \item{add.tools}{if TRUE, executes the function \code{newick2phylog.addtools}}
  \item{call}{call}
  \item{hc}{an object of class \code{hclust}}
  \item{taxo}{an object of class \code{taxo}}
  \item{res}{an object of class \code{phylog} (an internal argument of the function \code{newick2phylog})}
  \item{tol}{used in case 3 of \code{method} as a tolerance threshold for null eigenvalues}
}
\value{
Return object of class \code{phylog}.
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} \cr
Sébastien Ollier \email{ollier@biomserv.univ-lyon1.fr}
}
\seealso{\code{\link{phylog}}, \code{\link{plot.phylog}}, \code{\link{as.taxo}}}
\examples{
# newick2phylog
\dontrun{
w <- NULL
w[1] <- "(,((((((((((((((((,,(,(,))),),(((,(,)),(,)),),(,(,)),(,)),((((("
w[2] <- ",(,)),),),(,)),((((,((,),((,(,)),))),(,)),(,(,),,((,),(,)),)),("
w[3] <- "(((((,),),(,(,))),),(,)),(((,),),)))),((,,((,),)),(,)),((,),(,)"
w[4] <- ")),(((((((((,,),),,),),((,),)),(,),((,),)),),(((((,),),),((,),)"
w[5] <- "),(((,(,(,(,)))),(,)),(((,),(((((((,),),),,),(,)),(,)),)),((,)"
w[6] <- ",))))),(,((,),(,)),((,(,)),)))),((((,(,(,))),((,(,)),,((,(,)),)"
w[7] <- ",)),(((,),),(((,),),))),((,),))),((((((((((,,,,(,)),),((,),)),("
w[8] <- ",(,))),(((((((((,(,)),(,)),((((,((,),(,(,(,))))),((,),(,(,)))),"
w[9] <- "),((,),))),(((((((((,(,)),((,),(,))),),),),(((,((,),)),),((,((,"
w[10] <- "),)),)),(,)),(,(,(,)))),((((,(,)),(,)),(((,),(,)),(,),,(,))),(,"
w[11] <- "))),(,,,))),((((,),),),(((,(,(,))),((,),)),(,)))),(,)),),(,((,("
w[12] <- ",)),),(((,),),))),),(((,),),(,),(,(,))),(((,),(,)),((,),(,)))),"
w[13] <- "(((,),((,),)),(((((,,,,,),(,)),(,)),(,((,),))),))),(,(((((,(((("
w[14] <- ",(,)),),),)),),((,((,),((,((,),(,))),))),)),((((,),(((,),(,(,))"
w[15] <- "),)),),)),((,),)))),(((,((,,((,),)),)),),((,),))),((,),(,))),(("
w[16] <- ",),)),(((((,),((,(,)),(((,(,)),(,(((,),),))),))),(,),,),),),,(,"
w[17] <- ")),((((,),,),),((,,,),((,),((,),))))),((((((,(,)),,(,)),,(,),(,"
w[18] <- "),),(((((,(,(,),)),(((,),,),(,))),),),),,,((,),)),),)),(((((,),"
w[19] <- "(,(,)),),((,((,),),,),)),(((((((,),((((,,,),(,(,))),(((,(,)),),"
w[20] <- "(,))),)),),),),(,)),),),((,),))),((,),)),(((((((((((,),),(((((("
w[21] <- ",),),((,),)),(,)),),)),(,)),),((((((,),),(((,),),)),(,)),),(,))"
w[22] <- ",),),),),(,)),),((,),(,),,,)),(,(,(,)))),),(,)),),);"
phy1 <- newick2phylog(w,FALSE)
phy1
radial.phylog(phy1, clabel.l = 0, circle = 2.2, clea = 0.5,
 cnod = 0.5)}

data(newick.eg)
radial.phylog(newick2phylog(newick.eg[[8]], FALSE), cnode = 1,
 clabel.l = 0.8)

# hclust2phylog
\dontrun{
data(USArrests)
hc <- hclust(dist(USArrests), "ave")
par(mfrow = c(1,2))
plot(hc, hang = -1)
phy <- hclust2phylog(hc)
plot.phylog(phy, clabel.l = 0.75, clabel.n = 0.6, f = 0.75)

par(mfrow = c(1,1))
row.names(USArrests) 
names(phy$leaves) #WARNING not the same for two reasons
row.names(USArrests) <- gsub(" ","_",row.names(USArrests))
row.names(USArrests) 
names(phy$leaves) #WARNING not the same for one reason
USArrests <- USArrests[names(phy$leaves),]
row.names(USArrests) 
names(phy$leaves) #the same
table.phylog(data.frame(scalewt(USArrests)), phy, csi = 2.5,
 clabel.r = 0.75, f = 0.7)
}

#taxo2phylog
data(taxo.eg)
tax <- as.taxo(taxo.eg[[1]])
tax.phy <- taxo2phylog(as.taxo(taxo.eg[[1]]))
par(mfrow = c(1,2))
plot.phylog(tax.phy, clabel.l = 1.25, clabel.n = 1.25, f = 0.75)
plot.phylog(taxo2phylog(as.taxo(taxo.eg[[1]][sample(15),])),
 clabel.l = 1.25, clabel.n = 1.25, f = 0.75)

par(mfrow=c(1,1))
plot.phylog(taxo2phylog(as.taxo(taxo.eg[[2]])), clabel.l = 1,
 clabel.n = 0.75, f = 0.65)
}
\keyword{manip}
