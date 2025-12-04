# Linear Discriminant Analysis (descriptive statistic)

performs a linear discriminant analysis.

## Usage

``` r
discrimin(dudi, fac, scannf = TRUE, nf = 2)
# S3 method for class 'discrimin'
plot(x, xax = 1, yax = 2, ...) 
# S3 method for class 'discrimin'
print(x, ...)
```

## Arguments

- dudi:

  a duality diagram, object of class `dudi`

- fac:

  a factor defining the classes of discriminant analysis

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

  

- x:

  an object of class 'discrimin'

- xax:

  the column number of the x-axis

- yax:

  the column number of the y-axis

- ...:

  further arguments passed to or from other methods

## Value

returns a list of class 'discrimin' containing :

- nf:

  a numeric value indicating the number of kept axes

- eig:

  a numeric vector with all the eigenvalues

- fa:

  a matrix with the loadings: the canonical weights

- li:

  a data frame which gives the canonical scores

- va:

  a matrix which gives the cosines between the variables and the
  canonical scores

- cp:

  a matrix which gives the cosines between the components and the
  canonical scores

- gc:

  a data frame which gives the class scores

## See also

`lda` in package `MASS`

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(chazeb)
dis1 <- discrimin(dudi.pca(chazeb$tab, scan = FALSE), chazeb$cla, 
    scan = FALSE)
dis1
#> Discriminant analysis
#> call: discrimin(dudi = dudi.pca(chazeb$tab, scan = FALSE), fac = chazeb$cla, 
#>     scannf = FALSE)
#> class: discrimin 
#> 
#> $nf (axis saved) : 1
#> 
#> eigen values: 0.8451
#> 
#>   data.frame nrow ncol content                          
#> 1 $fa        6    1    loadings / canonical weights     
#> 2 $li        23   1    canonical scores                 
#> 3 $va        6    1    cos(variables, canonical scores) 
#> 4 $cp        6    1    cos(components, canonical scores)
#> 5 $gc        2    1    class scores                     
#> 
if(!adegraphicsLoaded())
  plot(dis1)
#> Error in plot.discrimin(dis1): One axis only : not yet implemented

data(skulls)
plot(discrimin(dudi.pca(skulls, scan = FALSE), gl(5,30), 
    scan = FALSE))
```
