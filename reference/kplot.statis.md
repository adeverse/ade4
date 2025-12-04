# Multiple Graphs of a STATIS Analysis

performs high level plots for a STATIS analysis, using an object of
class `statis`.

## Usage

``` r
# S3 method for class 'statis'
kplot(object, xax = 1, yax = 2, mfrow = NULL, 
    which.tab = 1:length(object$tab.names), clab = 1.5, cpoi = 2, 
    traject = FALSE, arrow = TRUE, class = NULL, 
    unique.scale = FALSE, csub = 2, possub = "bottomright",...)
```

## Arguments

- object:

  an object of class `statis`

- xax, yax:

  the numbers of the x-axis and the y-axis

- mfrow:

  parameter for the array of figures to be drawn

- which.tab:

  a numeric vector containing the numbers of the tables to analyse

- clab:

  a character size for the labels

- cpoi:

  the size of points

- traject:

  a logical value indicating whether the trajectories should be drawn in
  a natural order

- arrow:

  a logical value indicating whether the column factorial diagrams
  should be plotted

- class:

  if not NULL, a factor of length equal to the number of the total
  columns of the K-tables

- unique.scale:

  if TRUE, all the arrays of figures have the same scale

- csub:

  a character size for the labels of the arrays of figures used with
  `par("cex")*csub`

- possub:

  a string of characters indicating the sub-title position ("topleft",
  "topright", "bottomleft", "bottomright")

- ...:

  further arguments passed to or from other methods

## Author

Daniel Chessel

## Examples

``` r
data(jv73)
dudi1 <- dudi.pca(jv73$poi, scann = FALSE, scal = FALSE)
wit1 <- wca(dudi1, jv73$fac.riv, scann = FALSE)
kta1 <- ktab.within(wit1)
statis1 <- statis(kta1, scann = FALSE)

if(adegraphicsLoaded()) {
  g1 <- kplot(statis1, traj = TRUE, arrow = FALSE, plab.cex = 0, psub.cex = 2, ppoi.cex = 2)
} else {
  kplot(statis1, traj = TRUE, arrow = FALSE, unique = TRUE, clab = 0, csub = 2, cpoi = 2)
}
#> Error in s.label(dfxy = statis1$C.Co, xax = 1, yax = 2, facets = statis1$TC[,     1], plot = FALSE, storeData = TRUE, pos = -3, plabels = list(    cex = 1.25), unique = TRUE, clab = 0, csub = 2, cpoi = 2): non convenient selection for dfxy (can not be converted to dataframe)
```
