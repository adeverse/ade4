# Plot of Paired Coordinates

performs the scatter diagram for a paired coordinates.

## Usage

``` r
s.match(df1xy, df2xy, xax = 1, yax = 2, pch = 20, cpoint = 1, 
    label = row.names(df1xy), clabel=1, edge = TRUE, xlim = NULL, 
    ylim = NULL, grid = TRUE, addaxes = TRUE, cgrid = 1, 
    include.origin = TRUE, origin = c(0,0), sub = "", csub = 1.25, 
    possub = "bottomleft", pixmap = NULL, contour = NULL, area = NULL, 
    add.plot = FALSE)
```

## Arguments

- df1xy:

  a data frame containing two columns from the first system

- df2xy:

  a data frame containing two columns from teh second system

- xax:

  the column number for the x-axis of both the two systems

- yax:

  the column number for the y-axis of both the two systems

- pch:

  if `cpoint` \> 0, an integer specifying the symbol or the single
  character to be used in plotting points

- cpoint:

  a character size for plotting the points, used with
  `par("cex")*cpoint`. If zero, no points are drawn

- label:

  a vector of strings of characters for the couple labels

- clabel:

  if not NULL, a character size for the labels, used with
  `par("cex")*clabel`

- edge:

  If TRUE the arrows are plotted, otherwise only the segments are drawn

- xlim:

  the ranges to be encompassed by the x axis, if NULL they are computed

- ylim:

  the ranges to be encompassed by the y axis, if NULL they are computed

- grid:

  a logical value indicating whether a grid in the background of the
  plot should be drawn

- addaxes:

  a logical value indicating whether the axes should be plotted

- cgrid:

  a character size, parameter used with par("cex")\* `cgrid` to indicate
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

  aan object `pixmap` displayed in the map background

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
if(!adegraphicsLoaded()) {
  X <- data.frame(x = runif(50, -1, 2), y = runif(50, -1, 2))
  Y <- X + rnorm(100, sd = 0.3)
  par(mfrow = c(2, 2))
  s.match(X, Y)
  s.match(X, Y, edge = FALSE, clab = 0)
  s.match(X, Y, edge = FALSE, clab = 0)
  s.label(X, clab = 1, add.plot = TRUE)
  s.label(Y, clab = 0.75, add.plot = TRUE)
  s.match(Y, X, clab = 0)
  par(mfrow = c(1, 1))
}
```
