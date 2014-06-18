\name{aravo}
\alias{aravo}
\docType{data}
\title{Distribution of Alpine plants in Aravo (Valloire, France)}
\description{This dataset describe the distribution of 82 species of
  Alpine plants in 75 sites. Species traits and environmental variables
  are also measured.
}
\usage{data(aravo)}
\format{
  \code{aravo} is a list containing the following objects :
\describe{
   \item{spe}{is a data.frame with the abundance values of 82 species (columns)
     in 75 sites (rows).}
   \item{env}{is a data.frame with the measurements of 6 environmental
     variables for the sites.} 
   \item{traits}{is data.frame with the measurements of 8 traits for the species.}
   \item{spe.names}{is a vector with full species names.}
 }
}
\details{The environmental variables are:
  \tabular{lll}{
    Aspect \tab	Relative south aspect (opposite of the sine of aspect
    with flat coded 0)\cr
    Slope \tab	Slope inclination (degrees)\cr
    Form \tab	Microtopographic landform index: 1 (convexity); 2
    (convex slope); 3 (right slope); 4 (concave slope); 5 (concavity) \cr
    Snow \tab	Mean snowmelt date (Julian day) averaged over 1997-1999 \cr
    PhysD \tab	Physical disturbance, i.e., percentage of unvegetated
    soil due to physical processes \cr
    ZoogD \tab	Zoogenic disturbance, i.e., quantity of unvegetated soil
    due to marmot activity: no; some; high
  }
  The species traits for the plants are:
  \tabular{ll}{
    Height 	\tab Vegetative height (cm) \cr
    Spread 	\tab Maximum lateral spread of clonal plants (cm)\cr
    Angle 	\tab Leaf elevation angle estimated at the middle of the lamina\cr
    Area 	\tab Area of a single leaf\cr
    Thick 	\tab Maximum thickness of a leaf cross section (avoiding the midrib)\cr
    SLA 	\tab Specific leaf area\cr
    Nmass 	\tab Mass-based leaf nitrogen content\cr
    Seed 	\tab Seed mass
  }
}

\source{
  Choler, P. (2005)
  Consistent shifts in Alpine plant traits along a mesotopographical gradient.
\emph{Arctic, Antarctic, and Alpine Research}, \bold{37},444--453.
}

\examples{
data(aravo)
coa1 <- dudi.coa(aravo$spe, scannf = FALSE, nf = 2)
dudienv <- dudi.hillsmith(aravo$env, scannf = FALSE, nf = 2, row.w = coa1$lw)
duditrait <- dudi.pca(aravo$traits, scannf = FALSE, nf = 2, row.w = coa1$cw)
rlq1 <- rlq(dudienv, coa1, duditrait, scannf = FALSE, nf = 2)
plot(rlq1)
}
\keyword{datasets}
