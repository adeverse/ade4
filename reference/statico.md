# STATIS and Co-Inertia : Analysis of a series of paired ecological tables

Does the analysis of a series of pairs of ecological tables. This
function uses Partial Triadic Analysis ([pta](pta.md)) and
[ktab.match2ktabs](ktab.match2ktabs.md) to do the computations.

## Usage

``` r
statico(KTX, KTY, scannf = TRUE)
```

## Arguments

- KTX:

  an objet of class ktab

- KTY:

  an objet of class ktab

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

## Details

This function takes 2 ktabs and crosses each pair of tables of these
ktabs with the function [ktab.match2ktabs](ktab.match2ktabs.md). It then
does a partial triadic analysis on this new ktab with [pta](pta.md).

## Value

a list of class ktab, subclass kcoinertia. See [ktab](ktab.md)

## References

Thioulouse J. (2011). Simultaneous analysis of a sequence of paired
ecological tables: a comparison of several methods. *Annals of Applied
Statistics*, **5**, 2300-2325. Thioulouse J., Simier M. and Chessel D.
(2004). Simultaneous analysis of a sequence of paired ecological tables.
*Ecology* **85**, 272-283. Simier, M., Blanc L., Pellegrin F., and
Nandris D. (1999). Approche simultanée de K couples de tableaux :
Application a l'étude des relations pathologie végétale - environnement.
*Revue de Statistique Appliquée*, **47**, 31-46.

## Author

Jean Thioulouse <jean.thioulouse@univ-lyon1.fr>

## WARNING

IMPORTANT : KTX and KTY must have the same k-tables structure, the same
number of columns, and the same column weights.

## Examples

``` r
data(meau)
wit1 <- withinpca(meau$env, meau$design$season, scan = FALSE, scal = "total")
spepca <- dudi.pca(meau$spe, scale = FALSE, scan = FALSE, nf = 2)
wit2 <- wca(spepca, meau$design$season, scan = FALSE, nf = 2)
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kta2 <- ktab.within(wit2, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
statico1 <- statico(kta1, kta2, scan = FALSE)
plot(statico1)
#> Error in s.corcircle(dfxy = statico1$RV.coo, xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "Interstructure",         position = "topleft"), pbackground = list(box = FALSE),     plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
kplot(statico1)
#> Error in s.corcircle(dfxy = statico1$Tax, labels = statico1$T4[, 2], facets = statico1$T4[,     1], xax = 1, yax = 2, plot = FALSE, storeData = TRUE, pos = -3,     pbackground = list(box = FALSE), plabels = list(alpha = 1,         cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
