\name{procella}
\alias{procella}
\docType{data}
\title{Phylogeny and quantitative traits of birds}
\description{
This data set describes the phylogeny of 19 birds as reported by Bried et al. (2002). It also gives 6 traits corresponding to these 19 species.
}
\usage{data(procella)}
\format{
\code{procella} is a list containing the 2 following objects:  
\describe{     
   \item{tre}{is a character string giving the phylogenetic tree in Newick format.} 
   \item{traits}{is a data frame with 19 species and 6 traits}    
}}
\details{
Variables of \code{procella$traits} are the following ones: \cr
site.fid: a numeric vector that describes the percentage of site fidelity\cr
mate.fid: a numeric vector that describes the percentage of mate fidelity\cr
mass: an integer vector that describes the adult body weight (g)\cr
ALE: a numeric vector that describes the adult life expectancy (years)\cr
BF: a numeric vector that describes the breeding frequencies\cr
col.size: an integer vector that describes the colony size (no nests monitored)
}
\references{
Bried, J., Pontier, D. and Jouventin, P. (2002) Mate fidelity in monogamus birds: a re-examination of the Procellariiformes. 
\emph{Animal Behaviour}, \bold{65}, 235--246.
}
\examples{
data(procella)
pro.phy <- newick2phylog(procella$tre)
plot(pro.phy,clabel.n = 1, clabel.l = 1)
wt <- procella$traits
wt$site.fid[is.na(wt$site.fid)] <- mean(wt$site.fid[!is.na(wt$site.fid)])
wt$site.fid <- asin(sqrt(wt$site.fid/100))
wt$ALE[is.na(wt$ALE)] <- mean(wt$ALE[!is.na(wt$ALE)])
wt$ALE <- sqrt(wt$ALE)
wt$BF[is.na(wt$BF)] <- mean(wt$BF[!is.na(wt$BF)])
wt$mass <- log(wt$mass)
wt <- wt[, -6]
table.phylog(as.data.frame(scalewt(wt)), pro.phy)
gearymoran(pro.phy$Amat,wt,9999)
}
\keyword{datasets}
