# Scatter Plot

performs the scatter diagrams with labels.

## Usage

``` r
s.label(dfxy, xax = 1, yax = 2, label = row.names(dfxy), 
    clabel = 1, pch = 20, cpoint = if (clabel == 0) 1 else 0, boxes = TRUE,
    neig = NULL, cneig = 2, xlim = NULL, ylim = NULL, grid = TRUE, 
    addaxes = TRUE, cgrid = 1, include.origin = TRUE, origin = c(0,0), 
    sub = "", csub = 1.25, possub = "bottomleft", pixmap = NULL, 
    contour = NULL, area = NULL, add.plot = FALSE)
```

## Arguments

- dfxy:

  a data frame with at least two coordinates

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

- label:

  a vector of strings of characters for the point labels

- clabel:

  if not NULL, a character size for the labels, used with
  `par("cex")*clabel`

- pch:

  if `cpoint` \> 0, an integer specifying the symbol or the single
  character to be used in plotting points

- cpoint:

  a character size for plotting the points, used with
  `par("cex")*cpoint`. If zero, no points are drawn

- boxes:

  if TRUE, labels are framed

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

  an object 'pixmap' displayed in the map background

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
  layout(matrix(c(1, 2, 3, 2), 2, 2))
  data(atlas)
  s.label(atlas$xy, lab = atlas$names.district, 
    area = atlas$area, inc = FALSE, addax = FALSE)
  data(irishdata)
  s.label(irishdata$xy, inc = FALSE, contour = irishdata$contour, 
    addax = FALSE)
  
  par(mfrow = c(2, 2))
  cha <- ls()
  s.label(cbind.data.frame(runif(length(cha)), 
    runif(length(cha))), lab = cha)
  x <- runif(50, -2, 2)
  y <- runif(50, -2, 2)
  z <- x^2 + y^2
  s.label(data.frame(x, y), lab = as.character(z < 1))
  s.label(data.frame(x, y), clab = 0, cpoi = 1, add.plot = TRUE)
  symbols(0, 0, circles = 1, add = TRUE, inch = FALSE)
  s.label(cbind.data.frame(runif(100, 0, 10), runif(100, 5, 12)), 
    incl = FALSE, clab = 0)
  s.label(cbind.data.frame(runif(100, -3, 12),
    runif(100, 2, 10)), cl = 0, cp = 2, include = FALSE)
}

```
