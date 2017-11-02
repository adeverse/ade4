\name{randEH}
\alias{randEH}
\title{Nee and May's random process
}
\description{
This function is deprecated. See the function \code{randEH} in the package \code{adiv}.

When branch lengths in an ultrametric phylogenetic tree are expressed as divergence times, the total sum of branch 
lengths in that tree expresses the amount of evolutionary history. The function \code{randEH}
calculates the amount of evolutionary history preserved when \emph{k} random species out of \emph{n} 
original species are saved. 
}
\usage{
randEH(phyl, nbofsp, nbrep = 10) 
}
\arguments{
  \item{phyl}{an object of class phylog}
  \item{nbofsp}{an integer indicating the number of species saved (k).}
  \item{nbrep}{an integer indicating the number of random sampling.}
}
\value{
Returns a numeric vector 
}
\references{
Nee, S. and May, R.M. (1997) Extinction and the loss of evolutionary history. \emph{Science} 
\bold{278}, 692--694.

Pavoine, S., Ollier, S. and Dufour, A.-B. (2005)  
Is the originality of a species measurable? 
\emph{Ecology Letters}, \bold{8}, 579--586.
}
\author{
Sandrine Pavoine \email{pavoine@mnhn.fr}
}
\seealso{\code{\link{optimEH}}
}
\examples{
data(carni70)
carni70.phy <- newick2phylog(carni70$tre)
mean(randEH(carni70.phy, nbofsp = 7, nbrep = 1000)) 

\dontrun{
# the folowing instructions can last about 2 minutes.
data(carni70)
carni70.phy <- newick2phylog(carni70$tre)
percent <- c(0,0.04,0.07,seq(0.1,1,by=0.1)) 
pres <- round(percent*70) 
topt <- sapply(pres, function(i) optimEH(carni70.phy, nbofsp = i, give = FALSE)) 
topt <- topt / EH(carni70.phy) 
tsam <- sapply(pres, function(i) mean(randEH(carni70.phy, nbofsp = i, nbrep = 1000))) 
tsam <- tsam / EH(carni70.phy) 
plot(pres, topt, xlab = "nb of species saved", ylab = "Evolutionary history saved", type = "l") 
lines(pres, tsam)
}
}
\keyword{multivariate}
