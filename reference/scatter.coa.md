# Plot of the factorial maps for a correspondence analysis

performs the scatter diagrams of a correspondence analysis.

## Usage

``` r
# S3 method for class 'coa'
scatter(x, xax = 1, yax = 2, method = 1:3, clab.row = 0.75, 
    clab.col = 1.25, posieig = "top", sub = NULL, csub = 2, ...)
```

## Arguments

- x:

  an object of class `coa`

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

- method:

  an integer between 1 and 3  
  1 Rows and columns with the coordinates of lambda variance  
  2 Columns variance 1 and rows by averaging  
  3 Rows variance 1 and columns by averaging

- clab.row:

  a character size for the rows

- clab.col:

  a character size for the columns

- posieig:

  if "top", the eigenvalues bar plot is upside; if "bottom", it is
  downside; if "none", no plot

- sub:

  a string of characters to be inserted as legend

- csub:

  a character size for the legend, used with `par("cex")*csub`

- ...:

  further arguments passed to or from other methods

## References

Oksanen, J. (1987) Problems of joint display of species and site scores
in correspondence analysis. *Vegetatio*, **72**, 51–57.

## Author

Daniel Chessel

## Examples

``` r
data(housetasks)
w <- dudi.coa(housetasks, scan = FALSE)
if(adegraphicsLoaded()) {
  g1 <- scatter(w, method = 1, psub.text = "1 / Standard", posieig = "none", plot = FALSE)
  g2 <- scatter(w, method = 2, psub.text = "2 / Columns -> averaging -> Rows", 
    posieig = "none", plot = FALSE)
  g3 <- scatter(w, method = 3, psub.text = "3 / Rows -> averaging -> Columns ", 
    posieig = "none", plot = FALSE)
  G <- ADEgS(list(g1, g2, g3), layout = c(2, 2))
  
} else {
  par(mfrow = c(2, 2))
  scatter(w, method = 1, sub = "1 / Standard", posieig = "none")
  scatter(w, method = 2, sub = "2 / Columns -> averaging -> Rows", posieig = "none")
  scatter(w, method = 3, sub = "3 / Rows -> averaging -> Columns ", posieig = "none")
  par(mfrow = c(1, 1))
}
#> Error in s.label(dfxy = w$li, xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, plabels = list(cex = 0.75), xlim = c(-1.78084019584536,     1.2438983366721), ylim = c(-1.22699830497162, 1.79774022754584    ), sub = "1 / Standard"): non convenient selection for dfxy (can not be converted to dataframe)
```
