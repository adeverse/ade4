# Monte-Carlo Test on the between-groups inertia percentage (in R).

Performs a Monte-Carlo test on the between-groups inertia percentage.

## Usage

``` r
# S3 method for class 'between'
rtest(xtest, nrepet = 99, ...)
```

## Arguments

- xtest:

  an object of class `between`

- nrepet:

  the number of permutations

- ...:

  further arguments passed to or from other methods

## Value

a list of the class `rtest`

## Author

Daniel Chessel

## References

Romesburg, H. C. (1985) Exploring, confirming and randomization tests.
*Computers and Geosciences*, **11**, 19–37.

## Examples

``` r
data(meaudret)
pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 3)
rand1 <- rtest(bca(pca1, meaudret$design$season, scan = FALSE), 99)
rand1
#> Monte-Carlo test
#> Call: rtest.between(xtest = bca(pca1, meaudret$design$season, scan = FALSE), 
#>     nrepet = 99)
#> 
#> Observation: 0.3722686 
#> 
#> Based on 99 replicates
#> Simulated p-value: 0.01 
#> Alternative hypothesis: greater 
#> 
#>     Std.Obs Expectation    Variance 
#> 3.771460875 0.158979218 0.003198301 
plot(rand1, main = "Monte-Carlo test")
```
