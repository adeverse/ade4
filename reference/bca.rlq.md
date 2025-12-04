# Between-Class RLQ analysis

Performs a particular RLQ analysis where a partition of sites (rows of
R) is taken into account. The between-class RLQ analysis search for
linear combinations of traits and environmental variables maximizing the
covariances between the traits and the average environmental conditions
of classes.

## Usage

``` r
# S3 method for class 'rlq'
bca(x, fac, scannf = TRUE, nf = 2, ...)
# S3 method for class 'betrlq'
plot(x, xax = 1, yax = 2, ...)
# S3 method for class 'betrlq'
print(x, ...)
```

## Arguments

- x:

  an object of class rlq (created by the `rlq` function) for the
  `bca.rlq` function. An object of class `betrlq` for the `print` and
  `plot` functions

- fac:

  a factor partitioning the rows of R

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

- ...:

  further arguments passed to or from other methods

## Value

The `bca.rlq` function returns an object of class 'betrlq' (sub-class of
'dudi'). See the outputs of the `print` function for more details.

## References

Wesuls, D., Oldeland, J. and Dray, S. (2012) Disentangling plant trait
responses to livestock grazing from spatio-temporal variation: the
partial RLQ approach. *Journal of Vegetation Science*, **23**, 98–113.

## Author

Stéphane Dray <stephane.dray@univ-lyon1.fr>

## See also

[`rlq`](rlq.md), [`bca`](bca.md), [`wca.rlq`](wca.rlq.md)

## Examples

``` r
data(piosphere)
afcL <- dudi.coa(log(piosphere$veg + 1), scannf = FALSE)
acpR <- dudi.pca(piosphere$env, scannf = FALSE, row.w = afcL$lw)
acpQ <- dudi.hillsmith(piosphere$traits, scannf = FALSE, row.w =
  afcL$cw)
rlq1 <- rlq(acpR, afcL, acpQ, scannf = FALSE)

brlq1 <- bca(rlq1, fac = piosphere$habitat, scannf = FALSE)
brlq1
#> Between RLQ analysis
#> call: bca.rlq(x = rlq1, fac = piosphere$habitat, scannf = FALSE)
#> class: betrlq dudi 
#> 
#> $rank (rank): 3
#> $nf (axis saved): 2
#> 
#> eigen values: 1.726 0.5024 0.1789
#> 
#>   vector length mode    content                    
#> 1 $eig   3      numeric eigen values               
#> 2 $lw    25     numeric row weigths (crossed array)
#> 3 $cw    54     numeric col weigths (crossed array)
#> 
#>    data.frame nrow ncol content                           
#> 1  $tab       25   54   crossed array (CA)                
#> 2  $li        25   2    R col = CA row: coordinates       
#> 3  $l1        25   2    R col = CA row: normed scores     
#> 4  $co        54   2    Q col = CA column: coordinates    
#> 5  $c1        54   2    Q col = CA column: normed scores  
#> 6  $lR        4    2    class coordinates (R)             
#> 7  $lsR       378  2    supplementary row coordinates (R) 
#> 8  $mR        4    2    class normed scores (R)           
#> 9  $lQ        87   2    row coordinates (Q)               
#> 10 $mQ        87   2    normed row scores (Q)             
#> 11 $aR        2    2    axes onto between-RLQ axes (R)    
#> 12 $aQ        2    2    axes onto between-RLQ axes (Q)    
#> 13 $acR       2    2    RLQ axes onto between-RLQ axes (R)
#> 14 $acQ       2    2    RLQ axes onto between-RLQ axes (Q)
#> 
plot(brlq1)
#> Error in s.class(dfxy = brlq1$lsR, fac = piosphere$habitat, xax = 1, yax = 2,     plot = FALSE, storeData = TRUE, pos = -3, psub = list(text = "R row scores and classes"),     plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
