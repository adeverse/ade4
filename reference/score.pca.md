# Graphs to Analyse a factor in PCA

performs the canonical graph of a Principal Component Analysis.

## Usage

``` r
# S3 method for class 'pca'
score(x, xax = 1, which.var = NULL, mfrow = NULL, csub = 2, 
    sub = names(x$tab), abline = TRUE, ...)
```

## Arguments

- x:

  an object of class `pca`

- xax:

  the column number for the used axis

- which.var:

  the numbers of the kept columns for the analysis, otherwise all
  columns

- mfrow:

  a vector of the form "c(nr,nc)", otherwise computed by a special own
  function `n2mfrow`

- csub:

  a character size for sub-titles, used with `par("cex")*csub`

- sub:

  a vector of string of characters to be inserted as sub-titles,
  otherwise the names of the variables

- abline:

  a logical value indicating whether a regression line should be added

- ...:

  further arguments passed to or from other methods

## Author

Daniel Chessel

## Examples

``` r
data(deug)
dd1 <- dudi.pca(deug$tab, scan = FALSE)
score(dd1)
#> Error in s.label(dfxy = cbind(dd1$l1[, 1], deug$tab[1:104, 1L]), plot = FALSE,     storeData = TRUE, pos = -3, paxes = list(aspectratio = "fill",         draw = TRUE), porigin = list(include = FALSE), pgrid = list(        draw = FALSE), plabels = list(cex = 0), psub.text = "Algebra (r=-0.79)"): non convenient selection for dfxy (can not be converted to dataframe)
 
# The correlations are :
dd1$co[,1]
#> [1] -0.7924753 -0.6531896 -0.7410261 -0.5287294 -0.5538660 -0.7416171 -0.3336153
#> [8] -0.2755026 -0.4171874
# [1] 0.7925 0.6532 0.7410 0.5287 0.5539 0.7416 0.3336 0.2755 0.4172
```
