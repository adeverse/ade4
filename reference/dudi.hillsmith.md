# Ordination of Tables mixing quantitative variables and factors

performs a multivariate analysis with mixed quantitative variables and
factors.

## Usage

``` r
dudi.hillsmith(df, row.w = rep(1, nrow(df))/nrow(df), 
   scannf = TRUE, nf = 2)
```

## Arguments

- df:

  a data frame with mixed type variables (quantitative and factor)

- row.w:

  a vector of row weights, by default uniform row weights are used

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

## Details

If `df` contains only quantitative variables, this is equivalent to a
normed PCA.  
If `df` contains only factors, this is equivalent to a MCA.  

This analysis is the Hill and Smith method and is very similar to
`dudi.mix` function. The differences are that `dudi.hillsmith` allow to
use various row weights, while `dudi.mix` deals with ordered
variables.  
The principal components of this analysis are centered and normed
vectors maximizing the sum of :  
squared correlation coefficients with quantitative variables  
correlation ratios with factors  

## Value

Returns a list of class `mix` and `dudi` (see [dudi](dudi.md))
containing also

- index:

  a factor giving the type of each variable : f = factor, q =
  quantitative

- assign:

  a factor indicating the initial variable for each column of the
  transformed table

- cr:

  a data frame giving for each variable and each score:  
  the squared correlation coefficients if it is a quantitative
  variable  
  the correlation ratios if it is a factor

## References

Hill, M. O., and A. J. E. Smith. 1976. Principal component analysis of
taxonomic data with multi-state discrete characters. *Taxon*, **25**,
249-255.

## Author

Stéphane Dray <stephane.dray@univ-lyon1.fr>  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## See also

`dudi.mix`

## Examples

``` r
data(dunedata)
attributes(dunedata$envir$use)$class <- "factor"   # use dudi.mix for ordered data
dd1 <- dudi.hillsmith(dunedata$envir, scann = FALSE)
if(adegraphicsLoaded()) {
  g <- scatter(dd1, row.plab.cex = 1, col.plab.cex = 1.5)
} else {
  scatter(dd1, clab.r = 1, clab.c = 1.5)
}
#> Error in s.label(dfxy = dd1$li, xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, plabels = list(cex = 0.75), clab = list(r = 1,         c = 1.5)): non convenient selection for dfxy (can not be converted to dataframe)
```
