# Multiple Factorial Analysis

performs a multiple factorial analysis, using an object of class `ktab`.

## Usage

``` r
mfa(X, option = c("lambda1", "inertia", "uniform", "internal"), 
    scannf = TRUE, nf = 3)
# S3 method for class 'mfa'
plot(x, xax = 1, yax = 2, option.plot = 1:4, ...) 
# S3 method for class 'mfa'
print(x, ...) 
# S3 method for class 'mfa'
summary(object, ...)
```

## Arguments

- X:

  K-tables, an object of class `ktab`

- option:

  a string of characters for the weighting of arrays options :

  `lambda1`

  :   weighting of group k by the inverse of the first eigenvalue of the
      k analysis

  `inertia`

  :   weighting of group k by the inverse of the total inertia of the
      array k

  `uniform`

  :   uniform weighting of groups

  `internal`

  :   weighting included in `X$tabw`

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

- x, object:

  an object of class 'mfa'

- xax, yax:

  the numbers of the x-axis and the y-axis

- option.plot:

  an integer between 1 and 4, otherwise the 4 components of the plot are
  displayed

- ...:

  further arguments passed to or from other methods

## Value

Returns a list including :

- tab:

  a data frame with the modified array

- rank:

  a vector of ranks for the analyses

- eig:

  a numeric vector with the all eigenvalues

- li:

  a data frame with the coordinates of rows

- TL:

  a data frame with the factors associated to the rows (indicators of
  table)

- co:

  a data frame with the coordinates of columns

- TC:

  a data frame with the factors associated to the columns (indicators of
  table)

- blo:

  a vector indicating the number of variables for each table

- lisup:

  a data frame with the projections of normalized scores of rows for
  each table

- link:

  a data frame containing the projected inertia and the links between
  the arrays and the reference array

## References

Escofier, B. and Pagès, J. (1994) Multiple factor analysis (AFMULT
package), *Computational Statistics and Data Analysis*, **18**, 121–140.

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(friday87)
w1 <- data.frame(scale(friday87$fau, scal = FALSE))
w2 <- ktab.data.frame(w1, friday87$fau.blo, 
    tabnames = friday87$tab.names)
mfa1 <- mfa(w2, scann = FALSE)
mfa1
#> Multiple Factorial Analysis
#> list of class mfa list of class list
#> $call: mfa(X = w2, scannf = FALSE)
#> $nf: 3 axis-components saved
#> 
#>   vector     length mode      content      
#> 1 $tab.names 10     character tab names    
#> 2 $blo       10     numeric   column number
#> 3 $rank      1      numeric   tab rank     
#> 4 $eig       15     numeric   eigen values 
#> 5 $lw        16     numeric   row weights  
#> 6 $tabw      0      NULL      array weights
#> 
#>    data.frame nrow ncol content                        
#> 1  $tab       16   91   modified array                 
#> 2  $li        16   3    row coordinates                
#> 3  $l1        16   3    row normed scores              
#> 4  $co        91   3    column coordinates             
#> 5  $c1        91   3    column normed scores           
#> 6  $lisup     160  3    row coordinates from each table
#> 7  $TL        160  2    factors for li l1              
#> 8  $TC        91   2    factors for co c1              
#> 9  $T4        40   2    factors for T4comp             
#> 10 $T4comp    40   3    component projection           
#> 11 $link      10   3    link array-total               
#> other elements: NULL
plot(mfa1)
#> Error in eval(thecall$fac, envir = sys.frame(sys.nframe() + pos)): object 'mfa1' not found

data(escopage)
w <- data.frame(scale(escopage$tab))
w <- ktab.data.frame(w, escopage$blo, tabnames = escopage$tab.names)
plot(mfa(w, scann = FALSE))
#> Error in eval(thecall$fac, envir = sys.frame(sys.nframe() + pos)): object 'w' not found
```
