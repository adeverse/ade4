# Rao's dissimilarity coefficient

Calculates the root square of Rao's dissimilarity coefficient between
samples.

## Usage

``` r
disc(samples, dis = NULL, structures = NULL)
```

## Arguments

- samples:

  a data frame with elements as rows, samples as columns, and abundance,
  presence-absence or frequencies as entries

- dis:

  an object of class `dist` containing distances or dissimilarities
  among elements. If `dis` is NULL, equidistances are used.

- structures:

  a data frame containing, in the jth row and the kth column, the name
  of the group of level k to which the jth population belongs.

## Value

Returns a list of objects of class `dist`

## References

Rao, C.R. (1982) Diversity and dissimilarity coefficients: a unified
approach. *Theoretical Population Biology*, **21**, 24–43.

## Author

Sandrine Pavoine <pavoine@mnhn.fr>

## Examples

``` r
data(humDNAm)
humDNA.dist <- disc(humDNAm$samples, sqrt(humDNAm$distances), humDNAm$structures)
humDNA.dist
#> $samples
#>           oriental     tharu     wolof      peul      pima      maya   finnish
#> tharu    0.2520200                                                            
#> wolof    0.7821356 0.7965116                                                  
#> peul     0.8506600 0.8632233 0.1251814                                        
#> pima     0.1994968 0.2755218 0.7582823 0.8338317                              
#> maya     0.2559697 0.3023221 0.7177691 0.7857762 0.1406173                    
#> finnish  0.2455583 0.3043545 0.7615230 0.8367302 0.1416780 0.1899101          
#> sicilian 0.2966927 0.3553515 0.7194281 0.7871977 0.2731589 0.2783955 0.2593187
#> israelij 0.3578283 0.4564520 0.7963554 0.8604647 0.3906841 0.4075339 0.3601095
#> israelia 0.4102655 0.4363589 0.5822519 0.6437361 0.3588124 0.3027937 0.2984287
#>           sicilian  israelij
#> tharu                       
#> wolof                       
#> peul                        
#> pima                        
#> maya                        
#> finnish                     
#> sicilian                    
#> israelij 0.3690240          
#> israelia 0.3541134 0.3947386
#> 
#> $regions
#>               africa   america      asia    europe
#> america    0.7609083                              
#> asia       0.8016371 0.2280650                    
#> europe     0.7519837 0.1646208 0.2553667          
#> middleeast 0.6866876 0.3045622 0.3592600 0.2518122
#> 
is.euclid(humDNA.dist$samples)
#> [1] TRUE
is.euclid(humDNA.dist$regions)
#> [1] TRUE

if (FALSE) { # \dontrun{
data(ecomor)
dtaxo <- dist.taxo(ecomor$taxo)
ecomor.dist <- disc(ecomor$habitat, dtaxo)
ecomor.dist
is.euclid(ecomor.dist)
} # }
```
