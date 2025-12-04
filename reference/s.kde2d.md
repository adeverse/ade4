# Scatter Plot with Kernel Density Estimate

performs a scatter of points without labels by a kernel Density
Estimation in One or Two Dimensions

## Usage

``` r
s.kde2d(dfxy, xax = 1, yax = 2, pch = 20, cpoint = 1, neig = NULL, cneig = 2, 
    xlim = NULL, ylim = NULL, grid = TRUE, addaxes = TRUE, cgrid = 1, 
    include.origin = TRUE, origin = c(0, 0), sub = "", csub = 1.25, 
    possub = "bottomleft", pixmap = NULL, contour = NULL, 
    area = NULL, add.plot = FALSE)
```

## Arguments

- dfxy:

  a data frame with at least two coordinates

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

- pch:

  if `cpoint` \> 0, an integer specifying the symbol or the single
  character to be used in plotting points

- cpoint:

  a character size for plotting the points, used with
  `par("cex")*cpoint`. If zero, no points are drawn

- neig:

  a neighbouring graph

- cneig:

  a size for the neighbouring graph lines used with par("lwd")\*`cneig`

- xlim:

  the ranges to be encompassed by the x axis, if NULL, they are computed

- ylim:

  the ranges to be encompassed by the y axis, if NULL, they are computed

- grid:

  a logical value indicating whether a grid in the background of the
  plot should be drawn

- addaxes:

  a logical value indicating whether the axes should be plotted

- cgrid:

  a character size, parameter used with par("cex")\* 'cgrid' to indicate
  the mesh of the grid

- include.origin:

  a logical value indicating whether the point "origin" should be
  belonged to the graph space

- origin:

  the fixed point in the graph space, for example c(0,0) the origin axes

- sub:

  a string of characters to be inserted as legend

- csub:

  a character size for the legend, used with `par("cex")*csub`

- possub:

  a string of characters indicating the sub-title position ("topleft",
  "topright", "bottomleft", "bottomright")

- pixmap:

  an object `pixmap` displayed in the map background

- contour:

  a data frame with 4 columns to plot the contour of the map : each row
  gives a segment (x1,y1,x2,y2)

- area:

  a data frame of class 'area' to plot a set of surface units in contour

- add.plot:

  if TRUE uses the current graphics window

## Value

The matched call.

## Author

Daniel Chessel

## Examples

``` r
# To recognize groups of points
if(!adegraphicsLoaded()) {
  data(rpjdl)
  coa1 <- dudi.coa(rpjdl$fau, scannf = FALSE, nf = 3)
  s.kde2d(coa1$li)
}
```
