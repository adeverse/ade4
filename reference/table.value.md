# Plot of the Arrays

presents a graph for viewing the numbers of a table by square sizes.

## Usage

``` r
table.value(df, x = 1:ncol(df), y = nrow(df):1, 
    row.labels = row.names(df), col.labels = names(df), clabel.row = 1, 
    clabel.col = 1, csize = 1, clegend = 1, grid = TRUE)
```

## Arguments

- df:

  a data frame

- x:

  a vector of values to position the columns

- y:

  a vector of values to position the rows

- row.labels:

  a character vector for the row labels

- col.labels:

  a character vector for the column labels

- clabel.row:

  a character size for the row labels

- clabel.col:

  a character size for the column labels

- csize:

  a coefficient for the square size of the values

- clegend:

  a character size for the legend (if 0, no legend)

- grid:

  a logical value indicating whether the grid should be plotted

## Author

Daniel Chessel

## Examples

``` r
if(!adegraphicsLoaded()) {
  data(olympic)
  w <- olympic$tab
  w <- data.frame(scale(w))
  wpca <- dudi.pca(w, scann = FALSE)
  par(mfrow = c(1, 3))
  table.value(w, csi = 2, clabel.r = 2, clabel.c = 2)
  table.value(w, y = rank(wpca$li[, 1]), x = rank(wpca$co[, 1]), csi = 2,
    clabel.r = 2, clabel.c = 2)
  table.value(w, y = wpca$li[, 1], x = wpca$co[, 1], csi = 2, 
    clabel.r = 2, clabel.c = 2)
  par(mfrow = c(1, 1))
}
```
