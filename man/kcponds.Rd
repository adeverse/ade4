\name{kcponds}
\alias{kcponds}
\docType{data}
\title{Ponds in a nature reserve}
\description{
This data set contains informations about 33 ponds in De Maten reserve (Genk, Belgium).
}
\usage{data(kcponds)}
\format{
        \item{tab}{: a data frame with 15 environmental variables(columns) on 33 ponds(rows)}
        \item{area}{: an object of class \code{'area'}}
        \item{xy}{: a data frame with the coordinates of ponds}
        \item{neig}{: an object of class \code{'neig'}}   

Variables of \code{kcponds$tab} are the following ones : \cr
       \item{depth}{: depth}
       \item{area}{: area}
       \item{O2}{: oxygen concentration}
       \item{cond}{: conductivity}
       \item{pH}{: pH}
       \item{Fe}{: Fe concentration}
       \item{secchi}{: Secchi disk depth}
       \item{N}{: NNO concentration}
       \item{TP}{: total phosphorus concentration}
       \item{chla}{: chlorophyll-a concentration}
       \item{EM}{: emergent macrophyte cover}
       \item{FM}{: floating macrophyte cover}
       \item{SM}{: submerged macrophyte cover}
       \item{denMI}{: total density of macroinvertebrates}
       \item{divMI}{: diversity macroinvertebrates}
}
\source{
Cottenie, K. (2002) Local and regional processes in a zooplankton metacommunity. PhD, Katholieke Universiteit Leuven, Leuven, Belgium. \cr
\url{http://www.kuleuven.ac.be/bio/eco/phdkarlcottenie.pdf}
}
\examples{
data(kcponds)

par(mfrow=c(3,1))
area.plot(kcponds$area)
s.label(kcponds$xy,add.p = TRUE, cpoi = 2, clab = 0)
s.label(kcponds$xy,add.p = TRUE, cpoi = 3, clab = 0)
s.label(kcponds$xy,add.p = TRUE, cpoi = 0, clab = 0,
     neig = kcponds$neig, cneig = 1)
area.plot(kcponds$area)
s.label(kcponds$xy, add.p = TRUE, clab = 1.5)
w <- as.numeric(scalewt(kcponds$tab$N))
s.value(kcponds$xy, w, cleg = 2, sub = "Nitrogen concentration",
     csub = 4, possub = "topright", include = FALSE)
pca1 <- dudi.pca(kcponds$tab, scan = FALSE, nf = 4)
if(require(spdep, quiet = TRUE)){
multi1 <- multispati(pca1, nb2listw(neig2nb(kcponds$neig)),
     scan = FALSE, nfposi = 2, nfnega = 1)
}
summary(multi1)
}
\keyword{datasets}
