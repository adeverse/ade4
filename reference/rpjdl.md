# Avifauna and Vegetation

This data set gives the abundance of 51 species and 8 environmental
variables in 182 sites.

## Usage

``` r
data(rpjdl)
```

## Format

`rpjdl` is a list of 5 components.

- fau:

  is the faunistic array of 182 sites (rows) and 51 species (columns).

- mil:

  is the array of environmental variables : 182 sites and 8 variables.

- frlab:

  is a vector of the names of species in French.

- lalab:

  is a vector of the names of species in Latin.

- lab:

  is a vector of the simplified labels of species.

## Source

Prodon, R. and Lebreton, J.D. (1981) Breeding avifauna of a
Mediterranean succession : the holm oak and cork oak series in the
eastern Pyrénées. 1 : Analysis and modelling of the structure gradient.
*Oïkos*, **37**, 21–38.

Lebreton, J. D., Chessel D., Prodon R. and Yoccoz N. (1988) L'analyse
des relations espèces-milieu par l'analyse canonique des
correspondances. I. Variables de milieu quantitatives. *Acta Oecologica,
Oecologia Generalis*, **9**, 53–67.

## References

See a data description at <http://pbil.univ-lyon1.fr/R/pdf/pps048.pdf>
(in French).

## Examples

``` r
if (FALSE) { # \dontrun{
data(rpjdl)
coa1 <- dudi.coa(rpjdl$fau, scann = FALSE)
pca1 <- dudi.pca(rpjdl$fau, scal = FALSE, scann = FALSE)

if(adegraphicsLoaded()) {
  g1 <- s.distri(coa1$l1, rpjdl$fau, xax = 2, yax = 1, starSize = 0.3, 
                 ellipseSize = 0, plab.cex = 0)
  g2 <- s.distri(pca1$l1, rpjdl$fau, xax = 2, yax = 1, starSize = 0.3, 
                 ellipseSize = 0, plab.cex = 0)
} else {
  s.distri(coa1$l1, rpjdl$fau, 2, 1, cstar = 0.3, cell = 0)
  s.distri(pca1$l1, rpjdl$fau, 2, 1, cstar = 0.3, cell = 0)
}

caiv1 <- pcaiv(coa1, rpjdl$mil, scan = FALSE)
plot(caiv1)
} # }
```
