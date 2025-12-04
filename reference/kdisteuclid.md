# a way to obtain Euclidean distance matrices

a way to obtain Euclidean distance matrices

## Usage

``` r
kdisteuclid(obj, method = c("lingoes", "cailliez", "quasi"))
```

## Arguments

- obj:

  an object of class `kdist`

- method:

  a method to convert a distance matrix in a Euclidean one

## Value

returns an object of class `kdist` with all distances Euclidean.

## References

Gower, J.C. and Legendre, P. (1986) Metric and Euclidean properties of
dissimilarity coefficients. *Journal of Classification*, **3**, 5–48.

Cailliez, F. (1983) The analytical solution of the additive constant
problem. *Psychometrika*, **48**, 305–310.

Lingoes, J.C. (1971) Somme boundary conditions for a monotone analysis
of symmetric matrices. *Psychometrika*, **36**, 195–203.

Legendre, P. and Anderson, M.J. (1999) Distance-based redundancy
analysis: testing multispecies responses in multifactorial ecological
experiments. *Ecological Monographs*, **69**, 1–24.

Legendre, P., and L. Legendre. (1998) Numerical ecology, 2nd English
edition edition. Elsevier Science BV, Amsterdam.

## Author

Daniel Chessel  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
w <- c(0.8, 0.8, 0.377350269, 0.8, 0.377350269, 0.377350269) # see ref.
w <- kdist(w)
w1 <- c(kdisteuclid(kdist(w), "lingoes"), kdisteuclid(kdist(w), "cailliez"), 
  kdisteuclid(kdist(w), "quasi"))
#> [1] "Lingoes constant = 0.0532050808642207"
#> [1] "Cailliez constant = 0.20000000044866"
#> [1] "First ev = 0.32 Last ev = -0.0532050808642208"
print(w, print = TRUE)
#> List of distances matrices
#> call: kdist(w)
#> class: kdist
#> number of distances: 1
#> size: 4
#> labels:
#> [1] "1" "2" "3" "4"
#> w: non euclidean distance
#>   1         2         3         4
#> 1                                
#> 2 0.8000000                      
#> 3 0.8000000 0.8000000            
#> 4 0.3773503 0.3773503 0.3773503  
#> 
print(w1, print = TRUE)
#> List of distances matrices
#> call: c.kdist(kdisteuclid(kdist(w), "lingoes"), kdisteuclid(kdist(w), 
#>     "cailliez"), kdisteuclid(kdist(w), "quasi"))
#> class: kdist
#> number of distances: 3
#> size: 4
#> labels:
#> [1] "1" "2" "3" "4"
#> list(c(0.863950323646239, 0.863950323646239, 0.49880195192362, 0.863950323646239, 0.49880195192362, 0.49880195192362)).w: euclidean distance
#>   1         2         3         4
#> 1                                
#> 2 0.8639503                      
#> 3 0.8639503 0.8639503            
#> 4 0.4988020 0.4988020 0.4988020  
#> 
#> list(c(1.00000000044866, 1.00000000044866, 0.57735026944866, 1.00000000044866, 0.57735026944866, 0.57735026944866)).w: euclidean distance
#>   1         2         3         4
#> 1                                
#> 2 1.0000000                      
#> 3 1.0000000 1.0000000            
#> 4 0.5773503 0.5773503 0.5773503  
#> 
#> list(c(0.8, 0.8, 0.461880215351701, 0.8, 0.461880215351701, 0.461880215351701)).w: euclidean distance
#>   1         2         3         4
#> 1                                
#> 2 0.8000000                      
#> 3 0.8000000 0.8000000            
#> 4 0.4618802 0.4618802 0.4618802  
#> 

data(eurodist)
par(mfrow = c(1, 3))
eu1 <- kdist(eurodist) # an object of class 'dist'
plot(data.frame(unclass(c(eu1, kdisteuclid(eu1, "quasi")))), asp = 1)
#> [1] "First ev = 19538377.0895428 Last ev = -2251844.33173616"
title(main = "Quasi")
abline(0,1)
plot(data.frame(unclass(c(eu1, kdisteuclid(eu1, "lingoes")))), asp = 1)
#> [1] "Lingoes constant = 2251844.33173615"
title(main = "Lingoes")
abline(0,1)
plot(data.frame(unclass(c(eu1, kdisteuclid(eu1, "cailliez")))), asp = 1)
#> [1] "Cailliez constant = 2132.67849519795"
title(main = "Cailliez")
abline(0,1)
```
