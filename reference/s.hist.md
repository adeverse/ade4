# Display of a scatterplot and its two marginal histograms

performs a scatterplot and the two marginal histograms of each axis.

## Usage

``` r
s.hist(dfxy, xax = 1, yax = 2, cgrid = 1, cbreaks = 2, adjust = 1, ...)
```

## Arguments

- dfxy:

  a data frame with two coordinates

- xax:

  column for the x axis

- yax:

  column for the y axis

- cgrid:

  a character size, parameter used with `par("cex")*cgrid` to indicate
  the mesh of the grid

- cbreaks:

  a parameter used to define the numbers of cells for the histograms. By
  default, two cells are defined for each interval of the grid displayed
  in `s.label`. With an increase of the integer `cbreaks`, the number of
  cells increases as well.

- adjust:

  a parameter passed to `density` to display a kernel density estimation

- ...:

  further arguments passed from the `s.label` for the scatter plot

## Value

The matched call.

## Author

Daniel Chessel

## Examples

``` r
data(rpjdl)
coa1 <- dudi.coa(rpjdl$fau, scannf = FALSE, nf = 4)
s.hist(coa1$li)

#> [1] 10 20 30
s.hist(coa1$li, cgrid = 2, cbr = 3, adj = 0.5, clab = 0)

#> [1]  5 10 15 20 25 30
s.hist(coa1$co, cgrid = 2, cbr = 3, adj = 0.5, clab = 0)

#> [1]  5 10 15
```
