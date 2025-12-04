# STATIS and Co-Inertia : Analysis of a series of paired ecological tables

Prepares the analysis of a series of paired ecological tables. Partial
Triadic Analysis (see [`pta`](pta.md)) can be used thereafter to perform
the analysis of this k-table.

## Usage

``` r
ktab.match2ktabs(KTX, KTY)
```

## Arguments

- KTX:

  an objet of class `ktab`

- KTY:

  an objet of class `ktab`

## Value

a list of class `ktab`, subclass `kcoinertia`. See [`ktab`](ktab.md)

## References

Thioulouse J., Simier M. and Chessel D. (2004). Simultaneous analysis of
a sequence of paired ecological tables. *Ecology* **85**, 272-283..

Simier, M., Blanc L., Pellegrin F., and Nandris D. (1999). Approche
simultanée de K couples de tableaux : Application a l'étude des
relations pathologie végétale - environnement. *Revue de Statistique
Appliquée*, **47**, 31-46.

## Author

Jean Thioulouse <Jean.Thioulouse@univ-lyon1.fr>

## WARNING

IMPORTANT : `KTX` and `KTY` must have the same k-tables structure, the
same number of columns, and the same column weights.

## Examples

``` r
data(meau)
wit1 <- withinpca(meau$env, meau$design$season, scan = FALSE, scal = "total")
pcaspe <- dudi.pca(meau$spe, scale = FALSE, scan = FALSE, nf = 2)
wit2 <- wca(pcaspe, meau$design$season, scan = FALSE, nf = 2)
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kta2 <- ktab.within(wit2, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kcoi <- ktab.match2ktabs(kta1, kta2)
ptacoi <- pta(kcoi, scan = FALSE, nf = 2)
plot(ptacoi)
#> Error in s.corcircle(dfxy = ptacoi$RV.coo, xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "Interstructure",         position = "topleft"), pbackground = list(box = FALSE),     plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
kplot(ptacoi)
#> Error in s.corcircle(dfxy = ptacoi$Tax, labels = ptacoi$T4[, 2], facets = ptacoi$T4[,     1], xax = 1, yax = 2, plot = FALSE, storeData = TRUE, pos = -3,     pbackground = list(box = FALSE), plabels = list(alpha = 1,         cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
