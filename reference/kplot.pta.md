# Multiple Graphs for a Partial Triadic Analysis

performs high level plots of a Partial Triadic Analysis, using an object
of class `pta`.

## Usage

``` r
# S3 method for class 'pta'
kplot(object, xax = 1, yax = 2, which.tab = 1:nrow(object$RV), 
    mfrow = NULL, which.graph = 1:4, clab = 1, cpoint = 2, csub = 2, 
    possub = "bottomright", ask = par("ask"), ...)
```

## Arguments

- object:

  an object of class `pta`

- xax, yax:

  the numbers of the x-axis and the y-axis

- which.tab:

  a numeric vector containing the numbers of the tables to analyse

- mfrow:

  parameter of the array of figures to be drawn, otherwise the graphs
  associated to a table are drawn on the same row

- which.graph:

  an option for drawing, an integer between 1 and 4. For each table of
  which.tab, are drawn :

  1

  :   the projections of the principal axes

  2

  :   the projections of the rows

  3

  :   the projections of the columns

  4

  :   the projections of the principal components onto the planes of the
      compromise

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

- ask:

  a logical value indicating if the graphs requires several arrays of
  figures

- ...:

  further arguments passed to or from other methods

## Author

Daniel Chessel

## Examples

``` r
data(meaudret)
wit1 <- wca(dudi.pca(meaudret$spe, scan = FALSE, scal = FALSE), 
  meaudret$design$season, scan = FALSE)
kta1 <- ktab.within(wit1, colnames = rep(c("S1", "S2", "S3", "S4", "S5"), 4))
kta2 <- t(kta1)
pta1 <- pta(kta2, scann = FALSE)
kplot(pta1)
#> Error in s.corcircle(dfxy = pta1$Tax, labels = pta1$T4[, 2], facets = pta1$T4[,     1], xax = 1, yax = 2, plot = FALSE, storeData = TRUE, pos = -3,     pbackground = list(box = FALSE), plabels = list(alpha = 1,         cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
kplot(pta1, which.graph = 3)
#> Error in s.arrow(dfxy = pta1$Tco, labels = pta1$TC[, 2], facets = pta1$TC[,     1], xax = 1, yax = 2, plot = FALSE, storeData = TRUE, pos = -3,     plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
