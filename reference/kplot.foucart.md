# Multiple Graphs for the Foucart's Correspondence Analysis

performs high level plots of a Foucart's Correspondence Analysis, using
an object of class `foucart`.

## Usage

``` r
# S3 method for class 'foucart'
kplot(object, xax = 1, yax = 2, mfrow = NULL, 
    which.tab = 1:length(object$blo), clab.r = 1, clab.c = 1.25, 
    csub = 2, possub = "bottomright", ...)
```

## Arguments

- object:

  an object of class `foucart`

- xax, yax:

  the numbers of the x-axis and the y-axis

- mfrow:

  a vector of the form 'c(nr,nc)', otherwise computed by as special own
  function `n2mfrow`

- which.tab:

  vector of table numbers for analyzing

- clab.r:

  a character size for the row labels

- clab.c:

  a character size for the column labels

- csub:

  a character size for the sub-titles used with `par("cex")*csub`

- possub:

  a string of characters indicating the sub-title position ("topleft",
  "topright", "bottomleft", "bottomright")

- ...:

  further arguments passed to or from other methods

## Examples

``` r
data(bf88)
fou1 <- foucart(bf88, scann = FALSE, nf = 3)

if(adegraphicsLoaded()) {
  g <- kplot(fou1, row.plab.cex = 0, psub.cex = 2)
} else {
  kplot(fou1, clab.c = 2, clab.r = 0, csub = 3)
}
#> Error in s.label(dfxy = fou1$Tli, facets = fou1$TL[, 1], xax = 1, yax = 2,     plot = FALSE, storeData = TRUE, pos = -3, plabels = list(        cex = 1), xlim = c(-1.86402627934217, 1.65117536933363    ), ylim = c(-1.70842679418408, 1.80677485449171), plabels = list(        cex = 1.25), clab = list(c = 2, r = 0), csub = 3): non convenient selection for dfxy (can not be converted to dataframe)
```
