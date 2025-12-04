# 1D plot of a numeric score with labels

Draws evenly spaced labels, each label linked to the corresponding value
of a numeric score.

## Usage

``` r
sco.label(score, label = names(score), clabel = 1, horizontal = TRUE,
reverse = FALSE, pos.lab = 0.5, pch = 20, cpoint = 1, boxes = TRUE, lim
= NULL, grid = TRUE, cgrid = 1, include.origin = TRUE, origin = c(0, 0),
sub = "", csub = 1.25, possub = "bottomleft")
```

## Arguments

- score:

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

Stéphane Dray <stephane.dray@univ-lyon1.fr>, Jean Thioulouse

## Examples

``` r
data(meau)
envpca <- dudi.pca(meau$env, scannf=FALSE)
par(mfrow=c(2,1))
sco.label(envpca$l1[,1], row.names(envpca$l1), lim=c(-1,3.5))
sco.label(envpca$co[,1], row.names(envpca$co), reverse = TRUE, lim=c(-1,3.5))
```
