# Multiple Graphs for a Multiple Factorial Analysis

performs high level plots of a Multiple Factorial Analysis, using an
object of class `mfa`.

## Usage

``` r
# S3 method for class 'mfa'
kplot(object, xax = 1, yax = 2, mfrow = NULL, 
    which.tab = 1:length(object$blo), row.names = FALSE, col.names = TRUE, 
    traject = FALSE, permute.row.col = FALSE, 
    clab = 1, csub = 2, possub = "bottomright", ...)
```

## Arguments

- object:

  an object of class `mfa`

- xax, yax:

  the numbers of the x-axis and the y-axis

- mfrow:

  a vector of the form 'c(nr,nc'), otherwise computed by a special own
  function `n2mfrow`

- which.tab:

  vector of the numbers of tables used for the analysis

- row.names:

  a logical value indicating whether the row labels should be inserted

- col.names:

  a logical value indicating whether the column labels should be
  inserted

- traject:

  a logical value indicating whether the trajectories of the rows should
  be drawn in a natural order

- permute.row.col:

  if TRUE, the rows are represented by vectors and columns by points,
  otherwise it is the opposite

- clab:

  a character size for the labels

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
mfa1 <- mfa(w2, scann = FALSE)
kplot(mfa1)
#> Error in s.label(dfxy = mfa1$lisup, facets = mfa1$TL[, 1], xax = 1, yax = 2,     plot = FALSE, storeData = TRUE, pos = -3, plabels = list(        cex = 0), ppoints = list(cex = 1.5), samelimits = FALSE): non convenient selection for dfxy (can not be converted to dataframe)
```
