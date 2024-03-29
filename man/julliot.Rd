\name{julliot}
\alias{julliot}
\docType{data}

\title{Seed dispersal}

\description{
  This data set gives the spatial distribution of seeds (quadrats counts) of 
  seven species in the understorey of tropical rainforest.
}

\usage{data(julliot)}

\format{\code{julliot} is a list with the following components:
  \describe{
    \item{tab}{a data frame with 160 rows (quadrats) and 7 variables (species)}
    \item{xy}{a data frame with the coordinates of the 160 quadrats
      (positioned by their centers)}
    \item{area}{a data frame with 3 variables returning the boundary lines of 
      each quadrat. The first variable is a factor. The levels of this one are 
      the row.names of \code{tab}. The second and third variables return the 
      coordinates (x,y) of the points of the boundary line.}
    \item{Spatial}{an object of the class \code{SpatialPolygons} of \code{sp},
      containing the map}
}}

\details{
  Species names of \code{julliot$tab} are:
  \emph{Pouteria torta}, 
  \emph{Minquartia guianensis}, 
  \emph{Quiina obovata}, 
  \emph{Chrysophyllum lucentifolium}, 
  \emph{Parahancornia fasciculata}, 
  \emph{Virola michelii}, 
  and \emph{Pourouma spp}.
}

\references{
  Julliot, C. (1992). Utilisation des ressources alimentaires par le singe hurleur 
  roux, \emph{Alouatta seniculus} (Atelidae, Primates), en Guyane : impact de 
  la dissémination des graines sur la régénération forestière. Thèse de troisième
  cycle, Université de Tours.

  Julliot, C. (1997). Impact of seed dispersal by red howler monkeys 
  \emph{Alouatta seniculus} on the seedling population in the understorey of 
  tropical rain forest. \emph{Journal of Ecology}, \bold{85}, 431--440.
}

\examples{
data(julliot)

\dontrun{
if(adegraphicsLoaded()) {
  if(requireNamespace("sp", quietly = TRUE)) {
    obj1 <- sp::SpatialPolygonsDataFrame(Sr = julliot$Spatial, data = log(julliot$tab + 1))
    g1 <- s.Spatial(obj1)
    g2 <- s.value(julliot$xy, scalewt(log(julliot$tab + 1)), Sp = julliot$Spatial, 
      pSp.col = "white", pgrid.draw = FALSE)
  }
} else {
  if(requireNamespace("splancs", quietly = TRUE)) {
    par(mfrow = c(3, 3))
    for(k in 1:7)
      area.plot(julliot$area, val = log(julliot$tab[, k] + 1),
        sub = names(julliot$tab)[k], csub = 2.5)
    par(mfrow = c(1, 1))
    
    par(mfrow = c(3, 3))
    for(k in 1:7) {
      area.plot(julliot$area)
      s.value(julliot$xy, scalewt(log(julliot$tab[, k] + 1)),
        sub = names(julliot$tab)[k], csub = 2.5, add.p = TRUE)
    }
    par(mfrow = c(1, 1))
  }
}}


if(adegraphicsLoaded()) {
  if(requireNamespace("sp", quietly = TRUE)) {
    g3 <- s.image(julliot$xy, log(julliot$tab + 1), span = 0.25)
  }
  g4 <- s.value(julliot$xy, log(julliot$tab + 1))
  
} else {
  if(requireNamespace("splancs", quietly = TRUE)) {
    par(mfrow = c(3, 3))
    for(k in 1:7)
      s.image(julliot$xy, log(julliot$tab[, k] + 1), kgrid = 3, span = 0.25,
        sub = names(julliot$tab)[k], csub = 2.5)
    par(mfrow = c(1, 1))
    
    par(mfrow = c(3, 3))
    for(k in 1:7)
      s.value(julliot$xy, log(julliot$tab[, k] + 1),
        sub = names(julliot$tab)[k], csub = 2.5)
    par(mfrow = c(1, 1))    
  }
}
        
\dontrun{
if (requireNamespace("spdep", quietly = TRUE)) {
  neig0 <- nb2neig(spdep::dnearneigh(as.matrix(julliot$xy), 1, 1.8))
  if(adegraphicsLoaded()) {
    g5 <- s.label(julliot$xy, nb = spdep::dnearneigh(as.matrix(julliot$xy), 1, 1.8))
  
  } else {
    par(mfrow = c(1, 1))
    s.label(julliot$xy, neig = neig0, clab = 0.75, incl = FALSE,
     addax = FALSE, grid = FALSE)
  }
  gearymoran(ade4:::neig.util.LtoG(neig0), log(julliot$tab + 1))
  
  if (requireNamespace("adephylo", quietly = TRUE)) {
    adephylo::orthogram(log(julliot$tab[, 3] + 1), ortho = scores.neig(neig0))
  }
}}
}

\keyword{datasets}
