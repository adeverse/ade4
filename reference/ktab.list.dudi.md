# Creation of a K-tables from a list of duality diagrams

creates a list of class `ktab` from a list of duality diagrams.

## Usage

``` r
ktab.list.dudi(obj, rownames = NULL, colnames = NULL, tabnames = NULL)
```

## Arguments

- obj:

  a list of objects of class 'dudi'. Each element of the list must have
  the same row names for `$tab` and even for `$lw`

- rownames:

  the row names of the K-tables (otherwise the row names of the `$tab`)

- colnames:

  the column names of the K-tables (otherwise the column names of the
  `$tab`)

- tabnames:

  the names of the arrays of the K-tables (otherwise the names of the
  `obj` if they exist, or else "Ana1", "Ana2", ...)

## Value

returns a list of class `ktab`. See [`ktab`](ktab.md)

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(euro123)
pca1 <- dudi.pca(euro123$in78, scale = FALSE, scann = FALSE)
pca2 <- dudi.pca(euro123$in86, scale = FALSE, scann = FALSE)
pca3 <- dudi.pca(euro123$in97, scale = FALSE, scann = FALSE)
ktabeuro <- ktab.list.dudi(list(pca1, pca2, pca3), 
    tabnames = c("1978", "1986", "1997"))
if(adegraphicsLoaded()) {
  kplot(sepan(ktabeuro))
} else {
  kplot(sepan(ktabeuro), mfr = c(2, 2), clab.c = 1.5)
}
#> Error in s.label(dfxy = sepan(ktabeuro)$Li, labels = sepan(ktabeuro)$TL[,     2], facets = sepan(ktabeuro)$TL[, 1], xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(position = "bottomright"),     samelimits = FALSE, mfr = c(2, 2), clab = list(c = 1.5)): non convenient selection for dfxy (can not be converted to dataframe)

data(meaudret)
w1 <- split(meaudret$env,meaudret$design$season)
ll <- lapply(w1, dudi.pca, scann = FALSE)
kta <- ktab.list.dudi(ll, rownames <- paste("Site", 1:5, sep = ""))
if(adegraphicsLoaded()) {
  kplot(sepan(kta), row.plab.cex = 1.5, col.plab.cex = 0.75)
} else {
  kplot(sepan(kta), clab.r = 1.5, clab.c = 0.75)
}
#> Error in s.label(dfxy = sepan(kta)$Li, labels = sepan(kta)$TL[, 2], facets = sepan(kta)$TL[,     1], xax = 1, yax = 2, plot = FALSE, storeData = TRUE, pos = -3,     psub = list(position = "bottomright"), samelimits = FALSE,     clab = list(r = 1.5, c = 0.75)): non convenient selection for dfxy (can not be converted to dataframe)

data(jv73)
w <- split(jv73$poi, jv73$fac.riv)
wjv73poi <- lapply(w, dudi.pca, scal = FALSE, scan = FALSE)
wjv73poi <- lapply(wjv73poi, t)
wjv73poi <- ktab.list.dudi(wjv73poi)
kplot(sepan(wjv73poi), permut = TRUE, traj = TRUE)
#> Error in eval(thecall$labels, envir = sys.frame(sys.nframe() + pos)): object 'wjv73poi' not found
```
