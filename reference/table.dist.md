# Graph Display for Distance Matrices

presents a graph for viewing distance matrices.

## Usage

``` r
table.dist(d, x = 1:(attr(d, "Size")), labels = as.character(x), 
    clabel = 1, csize = 1, grid = TRUE)
```

## Arguments

- d:

  an object of class `dist`

- x:

  a vector of the row and column positions

- labels:

  a vector of strings of characters for the labels

- clabel:

  a character size for the labels

- csize:

  a coefficient for the circle size

- grid:

  a logical value indicating whether a grid in the background of the
  plot should be drawn

## Author

Daniel Chessel

## Examples

``` r
data(eurodist)
table.dist(eurodist, labels = attr(eurodist, "Labels"))
```
