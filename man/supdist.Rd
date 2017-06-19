\name{supdist}
\alias{supdist}
\title{
Projection of additional items in a PCO analysis
}

\description{
This function takes the grand distance matrix between all items (Active + 
Supplementary). It computes the PCO of the distance matrix between Active items, 
and projects the distance matrix of Supplementary items in this PCO.
}

\usage{supdist(d, fsup, tol = 1e-07)}

\arguments{
  \item{d}{Grand distance matrix between all (Active + Supplementary) items}
  \item{fsup}{A factor with two levels giving the Active (level `A') or 
    Supplementary (level `S') status for each item in the distance matrix.}
  \item{tol}{Numeric tolerance used to evaluate zero eigenvalues}
}

\value{
  \item{coordSup}{Coordinates of Supplementary items projected in the PCO of Active items}
  \item{coordAct}{Coordinates of Active item}
  \item{coordTot}{Coordinates of Active plus Supplementary items}
}

\references{
Computations based on the Methods section of the following paper:
Pele J, Abdi H, Moreau M, Thybert D, Chabbert M (2011) Multidimensional Scaling 
Reveals the Main Evolutionary Pathways of Class A G-Protein-Coupled Receptors. 
PLoS ONE 6(4): e19094. \url{https://doi.org/10.1371/journal.pone.0019094}
}

\author{Jean Thioulouse}

\seealso{\code{\link{dudi.pco}}, \code{\link{suprow}}}

\examples{
data(meau)
## Case 1: Supplementary items = subset of Active items
## Supplementary coordinates should be equal to Active coordinates
## PCO of active items (meau dataset has 6 sites and 10 variables)
envpca1 <- dudi.pca(meau$env, scannf = FALSE)
dAct <- dist(envpca1$tab)
pco1 <- dudi.pco(dAct, scannf = FALSE)
## Projection of rows 19:24 (winter season for the 6 sites)
## Supplementary items must be normalized
f1 <- function(w) (w - envpca1$cent) / envpca1$norm
envSup <- t(apply(meau$env[19:24, ], 1, f1))
envTot <- rbind.data.frame(envpca1$tab, envSup)
dTot <- dist(envTot)
fSA1 <- as.factor(rep(c("A", "S"), c(24, 6)))
cSup1 <- supdist(dTot, fSA1)
## Comparison (coordinates should be equal)
cSup1$coordSup[, 1:2]
pco1$li[19:24, ]

data(meaudret)
## Case 2: Supplementary items = new items
## PCO of active items (meaudret dataset has only 5 sites and 9 variables)
envpca2 <- dudi.pca(meaudret$env, scannf = FALSE)
dAct <- dist(envpca2$tab)
pco2 <- dudi.pco(dAct, scannf = FALSE)
## Projection of site 6 (four seasons, without Oxyg variable)
## Supplementary items must be normalized
f1 <- function(w) (w - envpca2$cent) / envpca2$norm
envSup <- t(apply(meau$env[seq(6, 24, 6), -5], 1, f1))
envTot <- rbind.data.frame(envpca2$tab, envSup)
dTot <- dist(envTot)
fSA2 <- as.factor(rep(c("A", "S"), c(20, 4)))
cSup2 <- supdist(dTot, fSA2)
## Supplementary items vs. real items
if(!adegraphicsLoaded()) {
 par(mfrow = c(1, 2))
 s.label(pco1$li)
 s.label(rbind.data.frame(pco2$li, cSup2$coordSup[, 1:2]))
} else {
 gl1 <- s.label(pco1$li, plabels.optim = TRUE)
 gl2 <- s.label(rbind.data.frame(pco2$li, cSup2$coordSup[, 1:2]),
  plabels.optim = TRUE)
 ADEgS(list(gl1, gl2))
}
}

\keyword{multivariate}