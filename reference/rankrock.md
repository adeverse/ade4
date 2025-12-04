# Ordination Table

This data set gives the classification in order of preference of 10
music groups by 51 students.

## Usage

``` r
data(rankrock)
```

## Format

A data frame with 10 rows and 51 columns.  
Each column contains the rank (1 for the favorite, ..., 10 for the less
appreciated)  
attributed to the group by a student.

## Examples

``` r
data(rankrock)
dudi1 <- dudi.pca(rankrock, scannf = FALSE, nf = 3)
if(adegraphicsLoaded()) {
  g <- scatter(dudi1, row.plab.cex = 1.5)
} else {
  scatter(dudi1, clab.r = 1.5)
}
#> Error in s.label(dfxy = dudi1$li, xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, plabels = list(cex = 0.75), clab = list(r = 1.5)): non convenient selection for dfxy (can not be converted to dataframe)
```
