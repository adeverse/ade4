# Creating a K-tables from a list of data frames.

creates a list of class `ktab` from a list of data frames

## Usage

``` r
ktab.list.df(obj, rownames = NULL, colnames = NULL, tabnames = NULL, 
    w.row = rep(1, nrow(obj[[1]])), w.col = lapply(obj, function(x) 
    rep(1 / ncol(x), ncol(x))))
```

## Arguments

- obj:

  a list of data frame

- rownames:

  the names of the K-tables rows (otherwise, the row names of the
  arrays)

- colnames:

  the names of the K-tables columns (otherwise, the column names of the
  arrays)

- tabnames:

  the names of the arrays of the K-tables (otherwise, the names of the
  obj if they exist, or else "Ana1", "Ana2", ...)

- w.row:

  a vector of the row weightings in common with all the arrays

- w.col:

  a list of the vector of the column weightings for each array

## Details

Each element of the initial list have to possess the same names and row
numbers

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Value

returns a list of class `ktab`. See [`ktab`](ktab.md)

## Examples

``` r
data(jv73)
l0 <- split(jv73$morpho, jv73$fac.riv)
l0 <- lapply(l0, function(x) data.frame(t(scalewt(x))))
#> Warning: Variables with null variance not standardized.
#> Warning: Variables with null variance not standardized.
#> Warning: Variables with null variance not standardized.
kta <- ktab.list.df(l0)
kplot(sepan(kta[c(2, 5, 7, 10)]), perm = TRUE)
#> Error in s.label(dfxy = sepan(kta[c(2, 5, 7, 10)])$Co, labels = sepan(kta[c(2,     5, 7, 10)])$TC[, 2], facets = sepan(kta[c(2, 5, 7, 10)])$TC[,     1], xax = 1, yax = 2, plot = FALSE, storeData = TRUE, pos = -3,     psub = list(position = "bottomright"), samelimits = FALSE): non convenient selection for dfxy (can not be converted to dataframe)
```
