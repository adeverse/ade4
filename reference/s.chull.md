# Plot of the factorial maps with polygons of contour by level of a factor

performs the scatter diagrams with polygons of contour by level of a
factor.

## Usage

``` r
s.chull(dfxy, fac, xax = 1, yax = 2, 
    optchull = c(0.25, 0.5, 0.75, 1), label = levels(fac), clabel = 1, 
    cpoint = 0, col = rep(1, length(levels(fac))), xlim = NULL, ylim = NULL,
    grid = TRUE, addaxes = TRUE, origin = c(0,0), include.origin = TRUE, 
    sub = "", csub = 1, possub = "bottomleft", cgrid = 1, pixmap = NULL, 
    contour = NULL, area = NULL, add.plot = FALSE)
```

## Arguments

- dfxy:

  a data frame containing the two columns for the axes

- fac:

  a factor partioning the rows of the data frame in classes

- xax:

  the column number of x in `dfxy`

- yax:

  the column number of y in `dfxy`

- optchull:

  the number of convex hulls and their interval

- label:

  a vector of strings of characters for the point labels

- clabel:

  if not NULL, a character size for the labels, used with
  `par("cex")*clabel`

- cpoint:

  a character size for plotting the points, used with
  `par("cex")*cpoint`. If zero, no points are drawn

- col:

  a vector of colors used to draw each class in a different color

- xlim:

  the ranges to be encompassed by the x axis, if NULL, they are computed

- ylim:

  the ranges to be encompassed by the y axis, if NULL they are computed

- grid:

  a logical value indicating whether a grid in the background of the
  plot should be drawn

- addaxes:

  a logical value indicating whether the axes should be plotted

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

  a character size, parameter used with par("cex")\* `cgrid` to indicate
  the mesh of the grid

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
xy <- cbind.data.frame(x = runif(200,-1,1), y = runif(200,-1,1))
posi <- factor(xy$x > 0) : factor(xy$y > 0)
coul <- c("black", "red", "green", "blue")

if(adegraphicsLoaded()) {
  s.class(xy, posi, ppoi.cex = 1.5, chullSize = c(0.25, 0.5, 0.75, 1), ellipseSize = 0, 
    starSize = 0, ppoly = list(col = "white", border = coul))
} else {
  s.chull(xy, posi, cpoi = 1.5, col = coul)
}
```
