# Multiple Graphs for a Multiple Co-inertia Analysis

performs high level plots of a Multiple Co-inertia Analysis, using an
object of class `mcoa`.

## Usage

``` r
# S3 method for class 'mcoa'
kplot(object, xax = 1, yax = 2, which.tab = 1:nrow(object$cov2), 
    mfrow = NULL, option = c("points", "axis", "columns"), 
    clab = 1, cpoint = 2, csub = 2, possub = "bottomright",...)
```

## Arguments

- object:

  an object of class `mcoa`

- xax, yax:

  the numbers of the x-axis and the y-axis

- which.tab:

  a numeric vector containing the numbers of the tables to analyse

- mfrow:

  a vector of the form 'c(nr,nc)', otherwise computed by as special own
  function `n2mfrow`

- option:

  a string of characters for the drawing option

  "points"

  :   plot of the projected scattergram onto the co-inertia axes

  "axis"

  :   projections of inertia axes onto the co-inertia axes.

  "columns"

  :   projections of variables onto the synthetic variables planes.

- clab:

  a character size for the labels

- cpoint:

  a character size for plotting the points, used with
  `par("cex")`\*cpoint. If zero, no points are drawn.

- csub:

  a character size for the sub-titles, used with `par("cex")*csub`

- possub:

  a string of characters indicating the sub-title position ("topleft",
  "topright", "bottomleft", "bottomright")

- ...:

  further arguments passed to or from other methods

## Author

Daniel Chessel

## Examples

``` r
data(friday87)
w1 <- data.frame(scale(friday87$fau, scal = FALSE))
w2 <- ktab.data.frame(w1, friday87$fau.blo, tabnames = friday87$tab.names)
mcoa1 <- mcoa(w2, "lambda1", scan = FALSE)
kplot(mcoa1, option = "axis")
#> Error in s.corcircle(dfxy = mcoa1$Tax, facets = mcoa1$T4[, 1], xax = 1,     yax = 2, plot = FALSE, storeData = TRUE, pos = -3, pbackground = list(        box = FALSE), plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
kplot(mcoa1)
#> Error in s.label(dfxy = mcoa1$SynVar, xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "Reference"),     plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
kplot(mcoa1, option = "columns")
#> Error in s.arrow(dfxy = mcoa1$Tco, facets = mcoa1$TC[, 1], xax = 1, yax = 2,     plot = FALSE, storeData = TRUE, pos = -3, plabels = list(        cex = 1.25), samelimits = FALSE): non convenient selection for dfxy (can not be converted to dataframe)
```
