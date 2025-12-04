# 1D plot of a pair of numeric scores with labels

Draws evenly spaced labels, each label linked to the corresponding
values of two numeric score.

## Usage

``` r
sco.match(score1, score2, label = names(score1), clabel = 1, 
    horizontal = TRUE, reverse = FALSE, pos.lab = 0.5, wmatch = 3, 
    pch = 20, cpoint = 1, boxes = TRUE, lim = NULL, grid = TRUE, 
    cgrid = 1, include.origin = TRUE, origin = c(0, 0), sub = "", 
    csub = 1.25, possub = "bottomleft")
```

## Arguments

- score1:

  a numeric vector

- score2:

  a numeric vector

- label:

  labels for the score

- clabel:

  a character size for the labels, used with `par("cex")*clabel`

- horizontal:

  logical. If TRUE, the plot is horizontal

- reverse:

  logical. If horizontal = TRUE and reverse=TRUE, the plot is at the
  bottom, if reverse = FALSE, the plot is at the top. If horizontal =
  FALSE, the plot is at the right (TRUE) or at the left (FALSE).

- pos.lab:

  a values between 0 and 1 to manage the position of the labels.

- wmatch:

  a numeric values to specify the width of the matching region in the
  plot. The width is equal to wmatch \* the height of character

- pch:

  an integer specifying the symbol or the single character to be used in
  plotting points

- cpoint:

  a character size for plotting the points, used with
  `par("cex")*cpoint`. If zero, no points are drawn

- boxes:

  if TRUE, labels are framed

- lim:

  the range for the x axis or y axis (if horizontal = FALSE), if NULL,
  they are computed

- grid:

  a logical value indicating whether a grid in the background of the
  plot should be drawn

- cgrid:

  a character size, parameter used with par("cex")\* `cgrid` to indicate
  the mesh of the grid

- include.origin:

  a logical value indicating whether the point "origin" should belong to
  the plot

- origin:

  the fixed point in the graph space, for example c(0,0) the origin axes

- sub:

  a string of characters to be inserted as legend

- csub:

  a character size for the legend, used with `par("cex")*csub`

- possub:

  a string of characters indicating the sub-title position ("topleft",
  "topright", "bottomleft", "bottomright")

## Value

The matched call.

## Author

Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
sco.match(-5:5,2*(-5:5))
```
