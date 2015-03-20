\encoding{latin1}
\name{mafragh}
\alias{mafragh}
\docType{data}
\title{Phyto-Ecological Survey}
\description{
This data set gives environmental and spatial informations about species and sites. 
}
\usage{data(mafragh)}
\format{
    \code{mafragh} is a list of 6 components.
\describe{
        \item{xy}{are the coordinates of 97 sites.}
        \item{flo}{is a data frame with 97 sites and 56 species.}
        \item{espnames}{is a vector of the names of species.}
        \item{neig}{is the neighbourhood graph of the 97 sites (an object of class 'neig').}
        \item{mil}{is a data frame with 97 sites and 11 environmental variables.}
        \item{partition}{is a factor classifying the 97 sites in 5 classes.}
        \item{area}{is a data frame of class \code{area}}
}}
\source{
Belair, G.d. and Bencheikh-Lehocine, M. (1987) Composition et d?terminisme de la v?g?tation d'une 
plaine c?ti?re mar?cageuse : La Mafragh (Annaba, Alg?rie). \emph{Bulletin d'Ecologie}, \bold{18}, 393--407.
}
\references{
See a data description at \url{http://pbil.univ-lyon1.fr/R/pps/pps053.pdf} (in French).
}
\examples{
data(mafragh)
coa1 <- dudi.coa(mafragh$flo, scan = FALSE)
pca1 <- dudi.pca(mafragh$xy, scan = FALSE)
if(adegraphicsLoaded()) {
  g1 <- s.label(mafragh$xy, nb = mafragh$nb, psub.text = "Samples & Neighbourhood graph", plot = F)
  g2 <- s.value(mafragh$xy, coa1$li[, 1], psub.text = "Axis 1 - COA", plot = FALSE)
  g3 <- s.value(mafragh$xy, pca1$li[,1], psub.text = "Axis 1 - PCA", plot = FALSE)
  g4 <- s.class(pca1$li, mafragh$partition, psub.text = "Plane 1-2 - PCA", plot = FALSE)
  g5 <- s.class(coa1$li, mafragh$partition, psub.text = "Plane 1-2 - COA", plot = FALSE)
  g6 <- s.class(mafragh$xy, mafragh$partition, chullSize = 1, ellipseSize = 0, starSize = 0, 
    ppoints.cex = 0, plot = FALSE)
  G <- ADEgS(c(g1, g2, g3, g4, g5, g6), layout = c(3, 2))

} else {
  par(mfrow = c(3, 2))
  s.label(mafragh$xy, inc = FALSE, neig = mafragh$neig, sub = "Samples & Neighbourhood graph")
  s.value(mafragh$xy, coa1$li[, 1], sub = "Axis 1 - COA")
  s.value(mafragh$xy, pca1$li[,1], sub = "Axis 1 - PCA")
  s.class(pca1$li, mafragh$partition, sub = "Plane 1-2 - PCA")
  s.class(coa1$li, mafragh$partition, sub = "Plane 1-2 - COA")
  s.chull(mafragh$xy, mafragh$partition, optchull = 1)
  par(mfrow=c(1, 1))
}

\dontrun{
link1 <- area2link(mafragh$area)
neig1 <- neig(mat01 = 1*(link1 > 0))
nb1 <- neig2nb(neig1)

if(adegraphicsLoaded()) {
  if(requireNamespace("sp", quiet = TRUE)) {
    g7 <- s.label(mafragh$xy, Sp = mafragh$Spatial, pSp.col = "white", plot = FALSE)
    g8 <- s.label(mafragh$xy, Sp = mafragh$Spatial, pSp.col = "white", nb = nb1, plab.cex = 0, 
      pnb.node.cex = 0, ppoints.cex = 0, plot = FALSE)
    G <- ADEgS(c(g7, g8), layout = c(2, 1))
  }

} else {
  par(mfrow = c(2, 1))
  area.plot(mafragh$area, center = mafragh$xy, clab = 0.75)
  area.plot(mafragh$area, center = mafragh$xy, graph = neig1)
  par(mfrow = c(1, 1))
}

if(requireNamespace("maptools", quiet = TRUE) & requireNamespace("spdep", quiet = TRUE)) {
  lw1 <- apply(link1, 1, function(x) x[x > 0])
  listw1 <- nb2listw(nb1, lw1)
  coa1 <- dudi.coa(mafragh$flo, scan = FALSE, nf = 4)
  ms1 <- multispati(coa1, listw1, scan = FALSE, nfp = 2, nfn = 0)
  summary(ms1)
  
  if(adegraphicsLoaded()) {
    if(requireNamespace("lattice", quiet = TRUE)) {
      g9 <- s1d.barchart(coa1$eig, p1d.hori = FALSE, plot = FALSE)
      g10 <- s1d.barchart(ms1$eig, p1d.hori = FALSE, plot = FALSE)
      g11 <- s.corcircle(ms1$as, plot = FALSE)
      g12 <- xyplot(ms1$li[, 1] ~ coa1$li[, 1])
      G <- ADEgS(list(g9, g10, g11, g12), layout = c(2, 2))
    }
    
  } else {    
    par(mfrow = c(2, 2))
    barplot(coa1$eig)
    barplot(ms1$eig)
    s.corcircle(ms1$as)
    plot(coa1$li[, 1], ms1$li[, 1])
    par(mfrow = c(1, 1))
  }
}
}}
\keyword{datasets}
