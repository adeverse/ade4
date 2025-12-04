# Plot of the Factorial Maps

performs the scatter diagrams of objects of class `dudi`.

## Usage

``` r
# S3 method for class 'dudi'
scatter(x, xax = 1, yax = 2, clab.row = 0.75, clab.col = 1, 
    permute = FALSE, posieig = "top", sub = NULL, ...)
```

## Arguments

- x:

  an object of class `dudi`

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

- clab.row:

  a character size for the rows

- clab.col:

  a character size for the columns

- permute:

  if FALSE, the rows are plotted by points and the columns by arrows. If
  TRUE it is the opposite.

- posieig:

  if "top" the eigenvalues bar plot is upside, if "bottom" it is
  downside, if "none" no plot

- sub:

  a string of characters to be inserted as legend

- ...:

  further arguments passed to or from other methods

## Details

`scatter.dudi` is a factorial map of individuals and the projection of
the vectors of the canonical basis multiplied by a constante of
rescaling. In the eigenvalues bar plot,the used axes for the plot are in
black, the other kept axes in grey and the other in white.

The `permute` argument can be used to choose between the distance biplot
(default) and the correlation biplot (permute = TRUE).

## Author

Daniel Chessel

## Examples

``` r
data(deug)
scatter(dd1 <- dudi.pca(deug$tab, scannf = FALSE, nf = 4), 
    posieig = "bottomright")


data(rhone)
dd1 <- dudi.pca(rhone$tab, nf = 4, scann = FALSE)
if(adegraphicsLoaded()) {
  scatter(dd1, row.psub.text = "Principal component analysis")
} else {
  scatter(dd1, sub = "Principal component analysis")
}
#> Error in s.label(dfxy = dd1$li, xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, plabels = list(cex = 0.75), sub = "Principal component analysis"): non convenient selection for dfxy (can not be converted to dataframe)
```
