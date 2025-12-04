# Decomposition of inertia (i.e. contributions) in multivariate methods

Computes the decomposition of inertia to measure the contributions of
row and/or columns in multivariate methods

## Usage

``` r
# S3 method for class 'dudi'
inertia(x, row.inertia = FALSE, col.inertia = FALSE, ...)
# S3 method for class 'inertia'
print(x, ...)
# S3 method for class 'inertia'
summary(object, sort.axis = 1, subset = 5, ...)
```

## Arguments

- x, object:

  a duality diagram, object of class `dudi` for `inertia.dudi`. An
  object of class `inertia` for the methods `print` and `summary`

- row.inertia:

  if TRUE, returns the decomposition of inertia for the rows

- col.inertia:

  if TRUE, returns the decomposition of inertia for the columns

- sort.axis:

  the kept axis used to sort the contributions in decreasing order

- subset:

  the number of rows and/or columns to display in the summary

- ...:

  further arguments passed to or from other methods

## Value

An object of class `inertia`, i.e. a list containing :

- tot.inertia:

  repartition of the total inertia between axes

- row.contrib:

  contributions of the rows to the total inertia

- row.abs:

  absolute contributions of the rows (i.e. decomposition per axis)

- row.rel:

  relative contributions of the rows

- row.cum:

  cumulative relative contributions of the rows (i.e. decomposition per
  row)

- col.contrib:

  contributions of the columns to the total inertia

- col.abs:

  absolute contributions of the columns (i.e. decomposition per axis)

- col.rel:

  relative contributions of the columns

- col.cum:

  cumulative relative contributions of the columns (i.e. decomposition
  per column)

- nf:

  the number of kept axes

## References

Lebart, L., Morineau, A. and Tabart, N. (1977) *Techniques de la
description statistique, méthodes et logiciels pour la description des
grands tableaux*, Dunod, Paris, 61–62.  
  
Volle, M. (1981) *Analyse des données*, Economica, Paris, 89–90 and
118  
  
Lebart, L., Morineau, L. and Warwick, K.M. (1984) *Multivariate
descriptive analysis: correspondence and related techniques for large
matrices*, John Wiley and Sons, New York.  
  
Greenacre, M. (1984) *Theory and applications of correspondence
analysis*, Academic Press, London, 66.  
  
Rouanet, H. and Le Roux, B. (1993) *Analyse des données
multidimensionnelles*, Dunod, Paris, 143–144.  
  
Tenenhaus, M. (1994) *Méthodes statistiques en gestion*, Dunod, Paris,
p. 160, 161, 166, 204.  
  
Lebart, L., Morineau, A. and Piron, M. (1995) *Statistique exploratoire
multidimensionnelle*, Dunod, Paris, p. 56,95-96.  

## Details

Contributions are printed in percentage and the sign is the sign of the
coordinates

## Author

Daniel Chessel  
Stéphane Dray <stephane.dray@univ-lyon1.fr>  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(housetasks)
coa1 <- dudi.coa(housetasks, scann = FALSE)
res <- inertia(coa1, col = TRUE, row = FALSE)
res
#> Inertia information:
#> Call: inertia.dudi(x = coa1, row.inertia = FALSE, col.inertia = TRUE)
#> 
#> Decomposition of total inertia:
#>     inertia     cum  cum(%)
#> Ax1  0.5429  0.5429   48.69
#> Ax2  0.4450  0.9879   88.60
#> Ax3  0.1270  1.1149  100.00
#> 
#> Column contributions (%):
#>        Wife Alternating     Husband     Jointly 
#>       27.00       10.57       34.21       28.23 
#> 
#> Column absolute contributions (%):
#>               Axis1   Axis2
#> Wife        44.4620  10.312
#> Alternating  0.1037   2.783
#> Husband     54.2339  17.787
#> Jointly      1.2004  69.118
#> 
#> Signed column relative contributions:
#>               Axis1   Axis2
#> Wife         80.188  -15.24
#> Alternating   0.478  -10.51
#> Husband     -77.203  -20.75
#> Jointly      -2.071   97.73
#> 
#> Cumulative sum of column relative contributions (%):
#>               Axis1 Axis1:2 Axis3:3
#> Wife         80.188   95.43   4.568
#> Alternating   0.478   10.99  89.012
#> Husband      77.203   97.96   2.043
#> Jointly       2.071   99.80   0.200
summary(res)
#> 
#> Total inertia: 1.115
#> 
#> Projected inertia (%):
#>     Ax1     Ax2 
#>   48.69   39.91 
#> 
#> (Only 2 dimensions (out of 3) are shown)
#> 
#> 
#> Column absolute contributions (%):
#>               Axis1   Axis2
#> Husband     54.2339  17.787
#> Wife        44.4620  10.312
#> Jointly      1.2004  69.118
#> Alternating  0.1037   2.783
#> 
#> Column relative contributions (%):
#>               Axis1   Axis2
#> Wife         80.188   15.24
#> Husband      77.203   20.75
#> Jointly       2.071   97.73
#> Alternating   0.478   10.51
```
