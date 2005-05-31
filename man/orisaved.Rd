\name{orisaved}
\alias{orisaved}
\title{Maximal or minimal amount of originality saved under optimal conditions
}
\description{
computes the maximal or minimal amount of originality saved over all 
combinations of species optimizing the amount of evolutionary history preserved. The 
originality of a species is measured with the QE-based index.
}
\usage{
orisaved(phyl, rate = 0.1, method = 1)
}
\arguments{
  \item{phyl}{an object of class phylog}
  \item{rate}{a real value (between 0 and 1) indicating how many species will 
  be saved for each calculation. For example, if the total number of species is 70 
  and 'rate = 0.1' then the calculations will be done at a rate of 10 \% i.e. for 0 
  (= 0 \%), 7 (= 10 \%), 14 (= 20 \%), 21 (= 30 \%), ..., 
  63 (= 90 \%) and 70(= 100 \%) 
  species saved. If 'rate = 0.5' then the calculations will be done for 
  only 0 (= 0 \%), 35 (= 50 \%) and 70(= 100 \%) species saved.}
  \item{method}{an integer either 1 or 2 (see details).}
}
\details{
1 = maximum amount of originality saved 
2 = minimum amount of originality saved 
}
\value{
Returns a numeric vector. 
}
\references{
Pavoine, S., Ollier, S. and Dufour, A.-B. (2005)  
Is the originality of a species measurable? 
\emph{Ecology Letters}, \bold{8}, 579--586.
}
\author{
Sandrine Pavoine \email{pavoine@biomserv.univ-lyon1.fr}
}
\examples{
data(carni70)
carni70.phy <- newick2phylog(carni70$tre)
tmax <- orisaved(carni70.phy, rate = 1 / 70, method = 1) 
tmin <- orisaved(carni70.phy, rate = 1 / 70, method = 2) 
plot(c(0, 1:70), tmax, xlab = "nb of species saved", ylab = "Originality saved", type = "l") 
lines(c(0, 1:70), tmin, lty = 2) 
}
\keyword{multivariate}
