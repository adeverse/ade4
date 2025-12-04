# Process to go from a Within Analysis to a K-tables

performs the process to go from a Within Analysis to a K-tables.

## Usage

``` r
ktab.within(dudiwit, rownames = NULL, colnames = NULL, tabnames = NULL)
```

## Arguments

- dudiwit:

  an objet of class `within`

- rownames:

  the row names of the K-tables (otherwise the row names of
  `dudiwit$tab`)

- colnames:

  the column names of the K-tables (otherwise the column names  
  of `dudiwit$tab`)

- tabnames:

  the names of the arrays of the K-tables (otherwise the levels of the
  factor which defines the within-classes)

## Value

a list of class `ktab`. See [`ktab`](ktab.md)

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(bacteria)
w1 <- data.frame(t(bacteria$espcodon))
dudi1 <- dudi.coa(w1, scann = FALSE, nf = 4)
wit1 <- wca(dudi1, bacteria$code, scannf = FALSE)
kta1 <- ktab.within(wit1)
plot(statis(kta1, scann = FALSE))
#> Error in s.corcircle(dfxy = statis(kta1, scann = FALSE)$RV.coo, xax = 1,     yax = 2, plot = FALSE, storeData = TRUE, pos = -3, psub = list(        text = "Interstructure", position = "topleft"), pbackground = list(        box = FALSE), plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)

kta2 <- kta1[kta1$blo>3]
kplot(mfa(kta2, scann = FALSE))
#> Error in s.label(dfxy = mfa(kta2, scann = FALSE)$lisup, facets = mfa(kta2,     scann = FALSE)$TL[, 1], xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, plabels = list(cex = 0), ppoints = list(cex = 1.5),     samelimits = FALSE): non convenient selection for dfxy (can not be converted to dataframe)
```
