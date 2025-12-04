# Mantel test (correlation between two distance matrices (in C).)

Performs a Mantel test between two distance matrices.

## Usage

``` r
mantel.randtest(m1, m2, nrepet = 999, ...)
```

## Arguments

- m1:

  an object of class `dist`

- m2:

  an object of class `dist`

- nrepet:

  the number of permutations

- ...:

  further arguments passed to or from other methods

## Value

an object of class `randtest` (randomization tests)

## References

Mantel, N. (1967) The detection of disease clustering and a generalized
regression approach. *Cancer Research*, **27**, 209–220.

## Author

Jean Thioulouse <Jean.Thioulouse@univ-lyon1.fr>

## Examples

``` r
data(yanomama)
gen <- quasieuclid(as.dist(yanomama$gen))
geo <- quasieuclid(as.dist(yanomama$geo))
plot(r1 <- mantel.randtest(geo,gen), main = "Mantel's test")

r1
#> Monte-Carlo test
#> Call: mantel.randtest(m1 = geo, m2 = gen)
#> 
#> Observation: 0.5095199 
#> 
#> Based on 999 replicates
#> Simulated p-value: 0.002 
#> Alternative hypothesis: greater 
#> 
#>      Std.Obs  Expectation     Variance 
#>  3.295987674 -0.003492398  0.024226151 
```
