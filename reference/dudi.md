# Duality Diagram

`as.dudi` is called by many functions (`dudi.pca`, `dudi.coa`,
`dudi.acm`, ...) and not directly by the user. It creates duality
diagrams.

`t.dudi` returns an object of class '`dudi`' where the rows are the
columns and the columns are the rows of the initial `dudi`.

`is.dudi` returns TRUE if the object is of class `dudi`

`redo.dudi` computes again an analysis, eventually changing the number
of kept axes. Used by other functions.  

## Usage

``` r
as.dudi(df, col.w, row.w, scannf, nf, call, type, tol = 1e-07, 
    full = FALSE) 
# S3 method for class 'dudi'
print(x, ...) 
is.dudi(x) 
redo.dudi(dudi, newnf = 2) 
# S3 method for class 'dudi'
t(x)
# S3 method for class 'dudi'
summary(object, ...) 
# S3 method for class 'dudi'
x[i, j]
```

## Arguments

- df:

  a data frame with *n* rows and *p* columns

- col.w:

  a numeric vector containing the row weights

- row.w:

  a numeric vector containing the column weights

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

- call:

  generally [`match.call()`](https://rdrr.io/r/base/match.call.html)

- type:

  a string of characters : the returned list will be of class
  `c(type, "dudi")`

- tol:

  a tolerance threshold for null eigenvalues (a value less than tol
  times the first one is considered as null)

- full:

  a logical value indicating whether all non null eigenvalues should be
  kept

- x, dudi, object:

  objects of class `dudi`

- ...:

  further arguments passed to or from other methods

- newnf:

  an integer indicating the number of kept axes

- i,j:

  elements to extract (integer or empty): index of rows (i) and columns
  (j)

## Value

as.dudi and all the functions that use it return a list with the
following components :

- tab:

  a data frame with n rows and p columns

- cw:

  column weights, a vector with n components

- lw:

  row (lines) weights, a vector with p components

- eig:

  eigenvalues, a vector with min(n,p) components

- nf:

  integer, number of kept axes

- c1:

  principal axes, data frame with p rows and nf columns

- l1:

  principal components, data frame with n rows and nf columns

- co:

  column coordinates, data frame with p rows and nf columns

- li:

  row coordinates, data frame with n rows and nf columns

- call:

  original call

## References

Escoufier, Y. (1987) The duality diagram : a means of better practical
applications In *Development in numerical ecology*, Legendre, P. &
Legendre, L. (Eds.) NATO advanced Institute, Serie G. Springer Verlag,
Berlin, 139–156.

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
data(deug)
dd1 <- dudi.pca(deug$tab, scannf = FALSE)
dd1
#> Duality diagramm
#> class: pca dudi
#> $call: dudi.pca(df = deug$tab, scannf = FALSE)
#> 
#> $nf: 2 axis-components saved
#> $rank: 9
#> eigen values: 3.101 1.363 1.032 0.9341 0.7398 ...
#>   vector length mode    content       
#> 1 $cw    9      numeric column weights
#> 2 $lw    104    numeric row weights   
#> 3 $eig   9      numeric eigen values  
#> 
#>   data.frame nrow ncol content             
#> 1 $tab       104  9    modified array      
#> 2 $li        104  2    row coordinates     
#> 3 $l1        104  2    row normed scores   
#> 4 $co        9    2    column coordinates  
#> 5 $c1        9    2    column normed scores
#> other elements: cent norm 
t(dd1)
#> Duality diagramm
#> class: transpo dudi
#> $call: t.dudi(x = dd1)
#> 
#> $nf: 2 axis-components saved
#> $rank: 9
#> eigen values: 3.101 1.363 1.032 0.9341 0.7398 ...
#>   vector length mode    content       
#> 1 $cw    104    numeric column weights
#> 2 $lw    9      numeric row weights   
#> 3 $eig   9      numeric eigen values  
#> 
#>   data.frame nrow ncol content             
#> 1 $tab       9    104  modified array      
#> 2 $li        9    2    row coordinates     
#> 3 $l1        9    2    row normed scores   
#> 4 $co        104  2    column coordinates  
#> 5 $c1        104  2    column normed scores
#> other elements: NULL
is.dudi(dd1)
#> [1] TRUE
redo.dudi(dd1,3)
#> Duality diagramm
#> class: pca dudi
#> $call: dudi.pca(df = deug$tab, scannf = FALSE, nf = 3)
#> 
#> $nf: 3 axis-components saved
#> $rank: 9
#> eigen values: 3.101 1.363 1.032 0.9341 0.7398 ...
#>   vector length mode    content       
#> 1 $cw    9      numeric column weights
#> 2 $lw    104    numeric row weights   
#> 3 $eig   9      numeric eigen values  
#> 
#>   data.frame nrow ncol content             
#> 1 $tab       104  9    modified array      
#> 2 $li        104  3    row coordinates     
#> 3 $l1        104  3    row normed scores   
#> 4 $co        9    3    column coordinates  
#> 5 $c1        9    3    column normed scores
#> other elements: cent norm 
summary(dd1)
#> Class: pca dudi
#> Call: dudi.pca(df = deug$tab, scannf = FALSE)
#> 
#> Total inertia: 9
#> 
#> Eigenvalues:
#>     Ax1     Ax2     Ax3     Ax4     Ax5 
#>  3.1014  1.3630  1.0323  0.9341  0.7398 
#> 
#> Projected inertia (%):
#>     Ax1     Ax2     Ax3     Ax4     Ax5 
#>  34.460  15.144  11.470  10.378   8.219 
#> 
#> Cumulative projected inertia (%):
#>     Ax1   Ax1:2   Ax1:3   Ax1:4   Ax1:5 
#>   34.46   49.60   61.07   71.45   79.67 
#> 
#> (Only 5 dimensions (out of 9) are shown)
#> 
```
