# Plot of the factorial maps in a Multiple Correspondence Analysis

performs the scatter diagrams of a Multiple Correspondence Analysis.

## Usage

``` r
# S3 method for class 'acm'
scatter(x, xax = 1, yax = 2, mfrow=NULL, csub = 2, possub = "topleft", ...)
```

## Arguments

- x:

  an object of class `acm`

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

- mfrow:

  a vector of the form "c(nr,nc)", if NULL (the default) is computed by
  `n2mfrow`

- csub:

  a character size for the legend, used with `par("cex")*csub`

- possub:

  a string of characters indicating the legend position ("topleft",
  "topright", "bottomleft", "bottomright") in a array of figures

- ...:

  further arguments passed to or from other methods

## Author

Daniel Chessel

## Examples

``` r
data(lascaux)
if(adegraphicsLoaded()) {
  plot(dudi.acm(lascaux$ornem, sca = FALSE))
} else {
  scatter(dudi.acm(lascaux$ornem, sca = FALSE), csub = 3)
}
```
