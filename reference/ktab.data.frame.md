# Creation of K-tables from a data frame

creates K tables from a data frame.

## Usage

``` r
ktab.data.frame(df, blocks, rownames = NULL, colnames = NULL, 
    tabnames = NULL, w.row = rep(1, nrow(df)) / nrow(df), 
    w.col = rep(1, ncol(df)))
```

## Arguments

- df:

  a data frame

- blocks:

  an integer vector for which the sum must be the number of variables of
  df. Its length is the number of arrays of the K-tables

- rownames:

  the row names of the K-tables (otherwise the row names of df)

- colnames:

  the column names of the K-tables (otherwise the column names of df)

- tabnames:

  the names of the arrays of the K-tables (otherwise "Ana1", "Ana2",
  ...)

- w.row:

  a vector of the row weightings

- w.col:

  a vector of the column weightings

## Value

returns a list of class `ktab`. See [`ktab`](ktab.md).

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(escopage)
wescopage <- data.frame(scalewt(escopage$tab))
wescopage <- ktab.data.frame(wescopage, escopage$blo,
        tabnames = escopage$tab.names)
plot(sepan(wescopage))
#> Error in plot.sepan(sepan(wescopage)): object 'wescopage' not found
data(friday87)
w <- data.frame(scale(friday87$fau, scal = FALSE))
w <- ktab.data.frame(w, friday87$fau.blo, tabnames = friday87$tab.names)
kplot(sepan(w))
#> Error in s.label(dfxy = sepan(w)$Li, labels = sepan(w)$TL[, 2], facets = sepan(w)$TL[,     1], xax = 1, yax = 2, plot = FALSE, storeData = TRUE, pos = -3,     psub = list(position = "bottomright"), samelimits = FALSE): non convenient selection for dfxy (can not be converted to dataframe)
```
