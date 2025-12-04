# Separated Analyses in a K-tables

performs K separated multivariate analyses of an object of class `ktab`
containing K tables.

## Usage

``` r
sepan(X, nf = 2)
# S3 method for class 'sepan'
plot(x, mfrow = NULL, csub = 2, ...)
# S3 method for class 'sepan'
summary(object, ...)
# S3 method for class 'sepan'
print(x, ...)
```

## Arguments

- X:

  an object of class `ktab`

- nf:

  an integer indicating the number of kept axes for each separated
  analysis

- x, object:

  an object of class 'sepan'

- mfrow:

  a vector of the form "c(nr,nc)", otherwise computed by a special own
  function `n2mfrow`

- csub:

  a character size for the sub-titles, used with `par("cex")*csub`

- ...:

  further arguments passed to or from other methods

## Value

returns a list of class 'sepan' containing :

- call:

  a call order

- tab.names:

  a vector of characters with the names of tables

- blo:

  a numeric vector with the numbers of columns for each table

- rank:

  a numeric vector with the rank of the studied matrix for each table

- Eig:

  a numeric vector with all the eigenvalues

- Li:

  a data frame with the row coordinates

- L1:

  a data frame with the row normed scores

- Co:

  a data frame with the column coordinates

- C1:

  a data frame with the column normed coordinates

- TL:

  a data frame with the factors for Li L1

- TC:

  a data frame with the factors for Co C1

## Details

The function plot on a `sepan` object allows to compare inertias and
structures between arrays. In black, the eigenvalues of kept axes in the
object 'sepan'.

## Author

Daniel Chessel

## Examples

``` r
data(escopage)
w <- data.frame(scale(escopage$tab))
w <- ktab.data.frame(w, escopage$blo, tabnames = escopage$tab.names)
sep1 <- sepan(w)
sep1
#> class: sepan list 
#> $call: sepan(X = w)
#>   vector     length mode      content             
#> 1 $tab.names 4      character tab names           
#> 2 $blo       4      numeric   column number       
#> 3 $rank      4      numeric   tab rank            
#> 4 $Eig       27     numeric   All the eigen values
#>   data.frame nrow ncol content                  
#> 1 $Li        84   2    row coordinates          
#> 2 $L1        84   2    row normed scores        
#> 3 $Co        27   2    column coordinates       
#> 4 $C1        27   2    column normed coordinates
#> 5 $TL        84   2    factors for Li L1        
#> 6 $TC        27   2    factors for Co C1        
summary(sep1)
#> Separate Analyses of a 'ktab' object
#>   names    nrow ncol rank lambda1 lambda2 lambda3 lambda4    
#> 1 repos    21   5    5    2.135   1.444   0.777   0.268   ...
#> 2 visual   21   3    3    2.7     0.144   0.014              
#> 3 olfactif 21   10   10   4.478   2.365   0.996   0.729   ...
#> 4 general  21   9    9    5.373   1.706   0.642   0.334   ...
plot(sep1)
#> Error in plot.sepan(sep1): object 'sep1' not found
```
