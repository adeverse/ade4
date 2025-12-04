# Pair of Ecological Data

This data set gives for trappong nights informations about species and
meteorological variables.

## Usage

``` r
data(trichometeo)
```

## Format

`trichometeo` is a list of 3 components.

- fau:

  is a data frame with 49 rows (trapping nights) and 17 species.

- meteo:

  is a data frame with 49 rows and 11 meteorological variables.

- cla:

  is a factor of 12 levels for the definition of the consecutive night
  groups

## Source

Data from P. Usseglio-Polatera

## References

Usseglio-Polatera, P. and Auda, Y. (1987) Influence des facteurs
météorologiques sur les résultats de piégeage lumineux. *Annales de
Limnologie*, **23**, 65–79. (code des espèces p. 76)

See a data description at <http://pbil.univ-lyon1.fr/R/pdf/pps034.pdf>
(in French).

## Examples

``` r
data(trichometeo)
faulog <- log(trichometeo$fau + 1)
pca1 <- dudi.pca(trichometeo$meteo, scan = FALSE)
niche1 <- niche(pca1, faulog, scan = FALSE)

if(adegraphicsLoaded()) {
  g1 <- s.distri(niche1$ls, faulog, plab.cex = 0.6, ellipseSize = 0, starSize = 0.3, plot = FALSE)
  g2 <- s.arrow(7 * niche1$c1, plab.cex = 1, plot = FALSE)
  G <- superpose(g1, g2, plot = TRUE)
  
} else {
  s.label(niche1$ls, clab = 0)
  s.distri(niche1$ls, faulog, clab = 0.6, add.p = TRUE, cell = 0, csta = 0.3)
  s.arrow(7 * niche1$c1, clab = 1, add.p = TRUE)
}
```
