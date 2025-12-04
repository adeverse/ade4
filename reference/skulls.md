# Morphometric Evolution

This data set gives four anthropometric measures of 150 Egyptean skulls
belonging to five different historical periods.

## Usage

``` r
data(skulls)
```

## Format

The `skulls` data frame has 150 rows (egyptean skulls) and 4 columns
(anthropometric measures). The four variables are the maximum breadth
(V1), the basibregmatic height (V2), the basialveolar length (V3) and
the nasal height (V4). All measurements were taken in millimeters.

## Details

The measurements are made on 5 groups and 30 Egyptian skulls. The groups
are defined as follows :  
1 - the early predynastic period (circa 4000 BC)  
2 - the late predynastic period (circa 3300 BC)  
3 - the 12th and 13th dynasties (circa 1850 BC)  
4 - the Ptolemiac period (circa 200 BC)  
5 - the Roman period (circa 150 BC)  

## Source

Thompson, A. and Randall-Maciver, R. (1905) *Ancient races of the
Thebaid*, Oxford University Press.

## References

Manly, B.F. (1994) *Multivariate Statistical Methods. A primer*, Second
edition. Chapman & Hall, London. 1–215.  
The example is treated pp. 6, 13, 51, 64, 72, 107, 112 and 117.

## Examples

``` r
data(skulls)
pca1 <- dudi.pca(skulls, scan = FALSE)
fac <- gl(5, 30)
levels(fac) <- c("-4000", "-3300", "-1850", "-200", "+150")
dis.skulls <- discrimin(pca1, fac, scan = FALSE)
if(!adegraphicsLoaded())
  plot(dis.skulls)
#> Error in s.arrow(dfxy = dis.skulls$fa, xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "Loadings"),     plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
