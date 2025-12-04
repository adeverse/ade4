# Monte-Carlo test on a Costatis analysis (in C).

Performs a Monte-Carlo test on a Costatis analysis.

## Usage

``` r
costatis.randtest(KTX, KTY, nrepet = 999, ...)
```

## Arguments

- KTX:

  an objet of class ktab

- KTY:

  an objet of class ktab

- nrepet:

  the number of permutations

- ...:

  further arguments passed to or from other methods

## Value

a list of the class `randtest`

## References

Thioulouse J. (2011). Simultaneous analysis of a sequence of paired
ecological tables: a comparison of several methods. *Annals of Applied
Statistics*, **5**, 2300-2325.

## Author

Jean Thioulouse <Jean.Thioulouse@univ-lyon1.fr>

## Examples

``` r
data(meau)
wit1 <- withinpca(meau$env, meau$design$season, scan = FALSE, scal = "total")
pcaspe <- dudi.pca(meau$spe, scale = FALSE, scan = FALSE, nf = 2)
wit2 <- wca(pcaspe, meau$design$season, scan = FALSE, nf = 2)
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kta2 <- ktab.within(wit2, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
costatis1 <- costatis(kta1, kta2, scan = FALSE)
costatis.randtest(kta1, kta2)
#> Monte-Carlo test
#> Call: randtest.coinertia(xtest = res, nrepet = nrepet)
#> 
#> Observation: 0.8204725 
#> 
#> Based on 999 replicates
#> Simulated p-value: 0.003 
#> Alternative hypothesis: greater 
#> 
#>     Std.Obs Expectation    Variance 
#>  2.69777374  0.50186607  0.01394755 
```
