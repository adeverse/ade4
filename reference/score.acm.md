# Graphs to study one factor in a Multiple Correspondence Analysis

performs the canonical graph of a Multiple Correspondence Analysis.

## Usage

``` r
# S3 method for class 'acm'
score(x, xax = 1, which.var = NULL, mfrow = NULL, 
    sub = names(oritab), csub = 2, possub = "topleft", ...)
```

## Arguments

- x:

  an object of class `acm`

- xax:

  the column number for the used axis

- which.var:

  the numbers of the kept columns for the analysis, otherwise all
  columns

- mfrow:

  a vector of the form "c(nr,nc)", otherwise computed by a special own
  function `n2mfrow`

- sub:

  a vector of strings of characters to be inserted as sub-titles,
  otherwise the variable names of the initial array

- csub:

  a character size for the sub-titles

- possub:

  a string of characters indicating the sub-title position ("topleft",
  "topright", "bottomleft", "bottomright")

- ...:

  further arguments passed to or from other methods

## Author

Daniel Chessel

## Examples

``` r
data(banque)
banque.acm <- dudi.acm(banque, scann = FALSE, nf = 3)
score(banque.acm, which = which(banque.acm$cr[, 1] > 0.2))
#> Error in s.class(dfxy = cbind(banque.acm$l1[, 1], as.numeric(as.numeric(tapply(banque.acm$l1[,     1], banque[1:810, 2L], function (x, ...) UseMethod("mean")))[banque[1:810, 2L]])), fac = banque[1:810,     2L], ellipseSize = 0, plot = FALSE, storeData = TRUE, pos = -3,     ppoints = list(pch = "|"), porigin = list(draw = FALSE),     pgrid = list(draw = FALSE), psub = list(position = "topleft"),     paxes = list(draw = TRUE), plabels = list(cex = 1.25), psub.text = "duree (cr=0.29)"): non convenient selection for dfxy (can not be converted to dataframe)
```
