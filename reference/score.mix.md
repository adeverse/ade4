# Graphs to Analyse a factor in a Mixed Analysis

performs the canonical graph of a mixed analysis.

## Usage

``` r
# S3 method for class 'mix'
score(x, xax = 1, csub = 2, mfrow = NULL, which.var = NULL, ...)
```

## Arguments

- x:

  an object of class `mix`

- xax:

  the column number for the used axis

- csub:

  a character size for the sub-titles, used with `par("cex")*csub`

- mfrow:

  a vector of the form "c(nr,nc)", otherwise computed by a special own
  function `n2mfrow`

- which.var:

  the numbers of the kept columns for the analysis, otherwise all
  columns

- ...:

  further arguments passed to or from other methods

## Author

Daniel Chessel

## Examples

``` r
data(lascaux)
w <- cbind.data.frame(lascaux$colo, lascaux$ornem)
dd <- dudi.mix(w, scan = FALSE, nf = 4, add = TRUE)
score(dd, which = which(dd$cr[,1] > 0.3))
#> Error in s.label(dfxy = cbind(dd$l1[, 1], dd$tab[, 3:4][1:306, 1]), plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "PNAD (r2=0.45)",         position = "topleft"), paxes = list(aspectratio = "fill",         draw = TRUE), porigin = list(include = FALSE), pgrid = list(        draw = FALSE), plabels = list(cex = 0)): non convenient selection for dfxy (can not be converted to dataframe)
```
