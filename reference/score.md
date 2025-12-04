# Graphs for One Dimension

score is a generic function. It proposes methods for the objects 'coa',
'acm', 'mix', 'pca'.

## Usage

``` r
score(x, ...)
scoreutil.base(y, xlim, grid, cgrid, include.origin, origin, sub, csub)
```

## Arguments

- x:

  an object used to select a method

- ...:

  further arguments passed to or from other methods

- y:

  a numeric vector

- xlim:

  the ranges to be encompassed by the x axis, if NULL they are computed

- grid:

  a logical value indicating whether the scale vertical lines should be
  drawn

- cgrid:

  a character size, parameter used with `par("cex")*cgrid` to indicate
  the mesh of the scale

- include.origin:

  a logical value indicating whether the point "origin" should be
  belonged to the graph space

- origin:

  the fixed point in the graph space, for example 0 the origin axis

- sub:

  a string of characters to be inserted as legend

- csub:

  a character size for the legend, used with `par("cex")*csub`

## Details

`scoreutil.base` is a utility function - not for the user - to define
the bottom of the layout of all `score`.

## See also

[`sco.boxplot`](sco.boxplot.md), [`sco.distri`](sco.distri.md),
[`sco.quant`](sco.quant.md)

## Author

Daniel Chessel

## Examples

``` r
if (FALSE) { # \dontrun{
par(mar = c(1, 1, 1, 1))
ade4:::scoreutil.base (runif(20, 3, 7), xlim = NULL, grid = TRUE, cgrid = 0.8, 
  include.origin = TRUE, origin = 0, sub = "Uniform", csub = 1)} # }
# returns the value of the user coordinate of the low line.  
# The user window id defined with c(0,1) in ordinate.
# box()
```
