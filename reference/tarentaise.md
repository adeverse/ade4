# Mountain Avifauna

This data set gives informations between sites, species, environmental
and biolgoical variables.

## Usage

``` r
data(tarentaise)
```

## Format

`tarentaise` is a list of 5 components.

- ecol:

  is a data frame with 376 sites and 98 bird species.

- frnames:

  is a vector of the 98 French names of the species.

- alti:

  is a vector giving the altitude of the 376 sites in m.

- envir:

  is a data frame with 14 environmental variables.

- traits:

  is a data frame with 29 biological variables of the 98 species.

## Details

The attribute `col.blocks` of the data frame `tarentaise$traits`
indicates it is composed of 6 units of variables.

## Source

Original data from Hubert Tournier, University of Savoie and Philippe
Lebreton, University of Lyon 1.

## References

Lebreton, P., Tournier H. and Lebreton J. D. (1976) Etude de l'avifaune
du Parc National de la Vanoise VI Recherches d'ordre quantitatif sur les
Oiseaux forestiers de Vanoise. *Travaux Scientifiques du parc National
de la vanoise*, **7**, 163–243.

Lebreton, Ph. and Martinot, J.P. (1998) Oiseaux de Vanoise. Guide de
l'ornithologue en montagne. *Libris*, Grenoble. 1–240.

Lebreton, Ph., Lebrun, Ph., Martinot, J.P., Miquet, A. and Tournier, H.
(1999) Approche écologique de l'avifaune de la Vanoise. *Travaux
scientifiques du Parc national de la Vanoise*, **21**, 7–304.

See a data description at <http://pbil.univ-lyon1.fr/R/pdf/pps038.pdf>
(in French).

## Examples

``` r
data(tarentaise)
coa1 <- dudi.coa(tarentaise$ecol, sca = FALSE, nf = 2)
s.class(coa1$li, tarentaise$envir$alti, wt = coa1$lw)

if (FALSE) { # \dontrun{
acm1 <- dudi.acm(tarentaise$envir, sca = FALSE, nf = 2)
s.class(acm1$li, tarentaise$envir$alti)
} # }
```
