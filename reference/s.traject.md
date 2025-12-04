# Trajectory Plot

performs the scatter diagram with trajectories.

## Usage

``` r
s.traject(dfxy, fac = factor(rep(1, nrow(dfxy))), 
    ord = (1:length(fac)),  xax = 1, yax = 2, label = levels(fac), 
    clabel = 1, cpoint = 1, pch = 20, xlim = NULL, ylim = NULL, 
    grid = TRUE, addaxes = TRUE, edge = TRUE, origin = c(0,0), 
    include.origin = TRUE, sub = "", csub = 1, possub = "bottomleft", 
    cgrid = 1, pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE)
```

## Arguments

- dfxy:

  a data frame containing two columns for the axes

- fac:

  a factor partioning the rows of the data frame in classes

- ord:

  a vector of length equal to fac. The trajectory is drawn in an
  ascending order of the ord values

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

- label:

  a vector of strings of characters for the point labels

- clabel:

  if not NULL, a character size for the labels, used with
  `par("cex")*clabel`

- cpoint:

  a character size for plotting the points, used with
  `par("cex")*cpoint`. If zero, no points are drawn

- pch:

  if `cpoint` \> 0, an integer specifying the symbol or the single
  character to be used in plotting points

- xlim:

  the ranges to be encompassed by the x, if NULL they are computed

- ylim:

  the ranges to be encompassed by the y, if NULL they are computed

- grid:

  a logical value indicating whether a grid in the background of the
  plot should be drawn

- addaxes:

  a logical value indicating whether the axes should be plotted

- edge:

  if TRUE the arrows are plotted, otherwhise only the segments

- origin:

  the fixed point in the graph space, for example c(0,0) the origin axes

- include.origin:

  a logical value indicating whether the point "origin" should be
  belonged to the graph space

- sub:

  a string of characters to be inserted as legend

- csub:

  a character size for the legend, used with `par("cex")*csub`

- possub:

  a string of characters indicating the sub-title position ("topleft",
  "topright", "bottomleft", "bottomright")

- cgrid:

  a character size, parameter used with `par("cex")*cgrid` to indicate
  the mesh of the grid

- pixmap:

  aan object 'pixmap' displayed in the map background

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
  rw <- function(a) {
    x <- 0
    for(i in 1:49) x <- c(x, x[length(x)] + runif(1, -1, 1))
    x
  }
  y <- unlist(lapply(1:5, rw))
  x <- unlist(lapply(1:5, rw))
  z <- gl(5, 50)
  s.traject(data.frame(x, y), z, edge = FALSE)
}
```
