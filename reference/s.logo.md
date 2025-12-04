# Representation of an object in a graph by a picture

performs the scatter diagrams using pictures to represent the points

## Usage

``` r
s.logo(dfxy, listlogo, klogo=NULL, clogo=1, rectlogo=TRUE,
    xax = 1, yax = 2, neig = NULL, cneig = 1, xlim = NULL, ylim = NULL, 
    grid = TRUE, addaxes = TRUE, cgrid = 1, include.origin = TRUE, 
    origin = c(0, 0), sub = "", csub = 1.25, possub = "bottomleft", 
    pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE)
```

## Arguments

- dfxy:

  a data frame with at least two coordinates

- listlogo:

  a list of pixmap pictures

- klogo:

  a numeric vector giving the order in which pictures of listlogo are
  used; if NULL, the order is the same than the rows of dfxy

- clogo:

  a numeric vector giving the size factor applied to each picture

- rectlogo:

  a logical to decide whether a rectangle should be drawn around the
  picture (TRUE) or not (FALSE)

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

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

Daniel Chessel and Thibaut Jombart <t.jombart@imperial.ac.uk>

## Examples

``` r
if(requireNamespace("pixmap", quietly = TRUE) & requireNamespace("sp", quietly = TRUE)) {
  if(!adegraphicsLoaded()) {
    data(ggtortoises)
    a1 <- ggtortoises$area
    area.plot(a1)
    rect(min(a1$x), min(a1$y), max(a1$x), max(a1$y), col = "lightblue")
    invisible(lapply(split(a1, a1$id), function(x) polygon(x[, -1],col = "white")))
    s.label(ggtortoises$misc, grid = FALSE, include.ori = FALSE, addaxes = FALSE, add.p = TRUE)
    listico <- ggtortoises$ico[as.character(ggtortoises$pop$carap)]
    s.logo(ggtortoises$pop, listico, add.p = TRUE)
    
  } else {
    data(capitales, package = "ade4")
    # 'capitales' data doesn't work with ade4 anymore
    g3 <- s.logo(capitales$xy[sort(rownames(capitales$xy)), ], capitales$logo, 
      Sp = capitales$Spatial, pbackground.col = "lightblue", pSp.col = "white", 
      pgrid.draw = FALSE)
  }
}
```
