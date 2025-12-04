# STATIS and Co-Inertia : Analysis of a series of paired ecological tables

Analysis of a series of pairs of ecological tables. This function uses
Partial Triadic Analysis ([pta](pta.md)) and [coinertia](coinertia.md)
to do the computations.

## Usage

``` r
costatis(KTX, KTY, scannf = TRUE)
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

This function takes 2 ktabs. It does a PTA (partial triadic analysis:
[pta](pta.md)) on each ktab, and does a coinertia analysis
([coinertia](coinertia.md)) on the compromises of the two PTAs.

## Value

a list of class coinertia, subclass dudi. See [coinertia](coinertia.md)

## References

Thioulouse J. (2011). Simultaneous analysis of a sequence of paired
ecological tables: a comparison of several methods. *Annals of Applied
Statistics*, **5**, 2300-2325.

## Author

Jean Thioulouse <Jean.Thioulouse@univ-lyon1.fr>

## WARNING

IMPORTANT : KTX and KTY must have the same k-tables structure, the same
number of columns, and the same column weights.

## Examples

``` r
data(meau)
wit1 <- withinpca(meau$env, meau$design$season, scan = FALSE, scal = "total")
pcaspe <- dudi.pca(meau$spe, scale = FALSE, scan = FALSE, nf = 2)
wit2 <- wca(pcaspe, meau$design$season, scan = FALSE, nf = 2)
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kta2 <- ktab.within(wit2, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
costatis1 <- costatis(kta1, kta2, scan = FALSE)
plot(costatis1)
#> Error in s.corcircle(dfxy = costatis1$aX, xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "Unconstrained axes (X)"),     pbackground = list(box = FALSE), plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
