# Partition of the variation of a response multivariate table by 2 explanatory tables

The function partitions the variation of a response table (usually
community data) with respect to two explanatory tables. The function
performs the variation partitioning based on redundancy analysis (RDA,
if `dudiY` is obtained by `dudi.pca`) or canonical correspondance
analysis (CCA, if `dudiY` is obtained by `dudi.coa`) and computes
unadjusted and adjusted R-squared. The significance of R-squared are
evaluated by a randomization procedure where the rows of the explanatory
tables are permuted.

## Usage

``` r
varipart(Y, X, W = NULL, nrepet = 999, type = c("simulated", "parametric"),
scale = FALSE, ...)
# S3 method for class 'varipart'
print(x, ...)
```

## Arguments

- Y:

  a vector, matrix or data frame or an object of class `dudi`. If not a
  `dudi` object, the data are trated by a principal component analysis
  (`dudi.pca`).

- X, W:

  dataframes or matrices of explanatory (co)variables (numeric and/or
  factor variables). By default, no covariables are considered (`W` is
  `NULL`) and this case corresponds to simple caonical ordination.

- nrepet:

  an integer indicating the number of permutations.

- type:

  a character specifying the algorithm which should be used to adjust
  R-squared (either `"simulated"` or `"parametric"`).

- scale:

  If `Y` is not a dudi, a `logical` indicating if variables should be
  scaled

- ...:

  further arguments passed to `as.krandtest` or `as.randtest` (if no
  covariables are considered) for function `varipart`.

- x:

  an object of class `varipart`

## Value

It returns an object of class `varipart`. It is a `list` with:

- `test`:

  the significance test of fractions \[ab\], \[bc\], and \[abc\] based
  on randomization procedure. An object of class `krandtest`

- `R2`:

  unadjusted estimations of fractions \[a\], \[b\], \[c\], and \[d\]

- `R2.adj`:

  adjusted estimations of fractions \[a\], \[b\], \[c\], and \[d\]

- `call`:

  the matched call

## Details

Two types of algorithm are provided to adjust R-squared. The "simulated"
procedure estimates the unadjusted R-squared expected under the null
hypothesis H0 and uses it to adjust the observed R-squared as follows:
R2.adj = 1 - (1 - R2) / (1 - E(R2\|H0)) with R2.adj the adjusted
R-squared and R2 the unadjusted R-squared. The "parametric" procedure
performs the Ezekiel's adjustement on the unadjusted R-squared as:
R2.adj = 1 - (1 - R2) / (1 - p / (n - 1)) where n is the number of
sites, and p the number of predictors.

## References

Borcard, D., P. Legendre, and P. Drapeau. 1992. Partialling out the
spatial component of ecological variation. Ecology 73:1045.

Peres-Neto, P. R., P. Legendre, S. Dray, and D. Borcard. 2006. Variation
partitioning of species data matrices: estimation and comparison of
fractions. Ecology 87:2614-2625.

Ezekiel, M. 1930. Methods of correlation analysis. John Wiley and Sons,
New York.

## See also

[`pcaiv`](pcaiv.md)

## Author

Stephane Dray <stephane.dray@univ-lyon1.fr> and Sylvie Clappe
<sylvie.clappe@univ-lyon1.fr>

## Examples

``` r
data(mafragh)

# PCA on response table Y
Y <- mafragh$flo
dudiY <- dudi.pca(Y, scannf = FALSE, scale = FALSE)

# Variation partitioning based on RDA
# without covariables
vprda <- varipart(dudiY,  mafragh$env)
vprda
#> Variation Partitioning
#> class: varipart list 
#> 
#> Test of fractions:
#> Monte-Carlo test
#> Call: varipart(Y = dudiY, X = mafragh$env)
#> 
#> Observation: 0.2366554 
#> 
#> Based on 999 replicates
#> Simulated p-value: 0.001 
#> Alternative hypothesis: greater 
#> 
#>      Std.Obs  Expectation     Variance 
#> 8.3772329451 0.1141957726 0.0002136902 
#> 
#> Adjusted fractions:
#> [1] 0.1382468
# Variation partitioning based on RDA
# with covariables and parametric estimation
vprda <- varipart(dudiY,  mafragh$env, mafragh$xy, type = "parametric")
vprda
#> Variation Partitioning
#> class: varipart list 
#> 
#> Test of fractions:
#> class: krandtest lightkrandtest 
#> Monte-Carlo tests
#> Call: varipart(Y = dudiY, X = mafragh$env, W = mafragh$xy, type = "parametric")
#> 
#> Number of tests:   3 
#> 
#> Adjustment method for multiple comparisons:   none 
#> Permutation number:   999 
#>      Test       Obs   Std.Obs   Alter Pvalue
#> 1   ab(X) 0.2366554  8.059125 greater  0.001
#> 2   bc(W) 0.1192681 15.511157 greater  0.001
#> 3 abc(XW) 0.3051848 10.941404 greater  0.001
#> 
#> 
#> Individual fractions:
#>          a          b          c          d 
#> 0.18591660 0.05073878 0.06852937 0.69481525 
#> 
#> Adjusted fractions:
#>          a          b          c          d 
#> 0.09582909 0.04204052 0.05848865 0.80364173 
names(vprda)
#> [1] "R2"     "R2.adj" "test"   "call"  
```
