\name{avijons}
\alias{avijons}
\docType{data}
\title{Bird species distribution}
\description{
This data set contains informations about spatial distribution of bird species in a zone surrounding the river Rhône near Lyon (France).
}
\usage{data(avijons)}
\format{
\code{avijons} is a list with the following elements : 
        \item{xy}{: a data frame with the coordinates of the sites}
        \item{area}{: an object of class \code{'area'}}
        \item{fau}{: a data frame with the abundance of 64 bird species in 91 sites}
        \item{spe.names.fr}{: a vector of strings of character with species name in french}
}
\source{
Bournaud, M., Amoros, C., Chessel, D., Coulet, M., Doledec, S., Michelot, J.L., Pautou, G., Rostan, J.C., Tachet, H. and Thioulouse, J. (1990) Peuplements d'oiseaux et propriétés des écocomplexes de la plaine du Rhône : descripteurs de fonctionnement global et gestion des berges. Rapport programme S.R.E.T.I.E., Ministère de l' Environnement CORA et URA CNRS 367, Univ. Lyon I. 
}
\references{
Thioulouse, J., Chessel, D. and Champely, S. (1995) Multivariate analysis of spatial patterns: a unified approach to local and global structures. \emph{Environmental and Ecological Statistics}, \bold{2}, 1--14.
}
\examples{
data(avijons)
pnm.eau <- read.pnm(system.file("pictures/avijonseau.pnm",
     package = "ade4"))
pnm.rou <- read.pnm(system.file("pictures/avijonsrou.pnm",
     package = "ade4"))
pnm.veg <- read.pnm(system.file("pictures/avijonsveg.pnm",
     package = "ade4"))
pnm.vil <- read.pnm(system.file("pictures/avijonsvil.pnm",
     package = "ade4"))
jons.coa <- dudi.coa(avijons$fau, scan = FALSE, nf = 4)

par(mfcol = c(3,2))
s.value(avijons$xy, jons.coa$li[,1], pixmap = pnm.rou, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F1+ROADS", csub = 3)
s.value(avijons$xy, jons.coa$li[,1], pixmap = pnm.veg, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F1+TREES", csub = 3)
s.value(avijons$xy, jons.coa$li[,1], pixmap = pnm.eau, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F1+WATER", csub = 3)
s.value(avijons$xy, jons.coa$li[,2], pixmap = pnm.rou, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F2+ROADS", csub = 3)
s.value(avijons$xy, jons.coa$li[,2], pixmap = pnm.veg, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F2+TREES", csub = 3)
s.value(avijons$xy, jons.coa$li[,2], pixmap = pnm.eau, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F2+WATER", csub = 3)

if (require(spdep, quiet = TRUE)) {
    link1 <- area2link(avijons$area)
    lw1 <- apply(link1,1,function(x) x[x>0])
    neig1 <- neig(mat01=1*(link1>0))
    nb1 <- neig2nb(neig1)
    listw1 <- nb2listw(nb1,lw1)
    jons.ms <- multispati(jons.coa, listw1, scan = FALSE, nfp = 3,
     nfn = 2)
    summary(jons.ms)
    par(mfrow = c(2,2))
    barplot(jons.coa$eig)
    barplot(jons.ms$eig)
    s.corcircle(jons.ms$as)
    plot(jons.coa$li[,1], jons.ms$li[,1])

par(mfcol=c(3,2))
s.value(avijons$xy, jons.ms$li[,1], pixmap = pnm.rou, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F1+ROADS", csub = 3)
s.value(avijons$xy, jons.ms$li[,1], pixmap = pnm.veg, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F1+TREES", csub = 3)
s.value(avijons$xy, jons.ms$li[,1], pixmap = pnm.eau, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F1+WATER", csub = 3)
s.value(avijons$xy, jons.ms$li[,2], pixmap = pnm.rou, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F2+ROADS", csub = 3)
s.value(avijons$xy, jons.ms$li[,2], pixmap = pnm.veg, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F2+TREES", csub = 3)
s.value(avijons$xy, jons.ms$li[,2], pixmap = pnm.eau, inclu = FALSE,
 grid = FALSE, addax = FALSE, cleg = 0, sub = "F2+WATER", csub = 3)
}
}
\keyword{datasets}
