# Monte-Carlo Test on the between-groups inertia percentage (in C).

Performs a Monte-Carlo test on the between-groups inertia percentage.

## Usage

``` r
# S3 method for class 'between'
randtest(xtest, nrepet = 999, ...)
```

## Arguments

- xtest:

  an object of class `between`

- nrepet:

  the number of permutations

- ...:

  further arguments passed to or from other methods

## Value

a list of the class `randtest`

## References

Romesburg, H. C. (1985) Exploring, confirming and randomization tests.
*Computers and Geosciences*, **11**, 19–37.

## Author

Jean Thioulouse <Jean.Thioulouse@univ-lyon1.fr>

## Examples

``` r
data(meaudret)
pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 3)
rand1 <- randtest(bca(pca1, meaudret$design$season, scan = FALSE), 99)
rand1
#> Monte-Carlo test
#> Call: randtest.between(xtest = bca(pca1, meaudret$design$season, scan = FALSE), 
#>     nrepet = 99)
#> 
#> Observation: 0.3722686 
#> 
#> Based on 99 replicates
#> Simulated p-value: 0.02 
#> Alternative hypothesis: greater 
#> 
#>     Std.Obs Expectation    Variance 
#> 3.146051911 0.159352208 0.004580222 
plot(rand1, main = "Monte-Carlo test")
```
