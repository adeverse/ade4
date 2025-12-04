# RLQ analysis

RLQ analysis performs a double inertia analysis of two arrays (R and Q)
with a link expressed by a contingency table (L). The rows of L
correspond to the rows of R and the columns of L correspond to the rows
of Q.

## Usage

``` r
rlq(dudiR, dudiL, dudiQ, scannf = TRUE, nf = 2)
# S3 method for class 'rlq'
print(x, ...)
# S3 method for class 'rlq'
plot(x, xax = 1, yax = 2, ...)
# S3 method for class 'rlq'
summary(object, ...)
# S3 method for class 'rlq'
randtest(xtest,nrepet = 999, modeltype = 6,...)
```

## Arguments

- dudiR:

  a duality diagram providing from one of the functions dudi.hillsmith,
  dudi.pca, ...

- dudiL:

  a duality diagram of the function dudi.coa

- dudiQ:

  a duality diagram providing from one of the functions dudi.hillsmith,
  dudi.pca, ...

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

- x:

  an rlq object

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

- object:

  an rlq object

- xtest:

  an rlq object

- nrepet:

  the number of permutations

- modeltype:

  the model used to permute data(2: permute rows of R, 4: permute rows
  of Q, 5: permute both, 6: sequential approach, see ter Braak et al.
  2012)

- ...:

  further arguments passed to or from other methods

## Value

Returns a list of class 'dudi', sub-class 'rlq' containing:

- call:

  call

- rank:

  rank

- nf:

  a numeric value indicating the number of kept axes

- RV:

  a numeric value, the RV coefficient

- eig:

  a numeric vector with all the eigenvalues

- lw:

  a numeric vector with the rows weigths (crossed array)

- cw:

  a numeric vector with the columns weigths (crossed array)

- tab:

  a crossed array (CA)

- li:

  R col = CA row: coordinates

- l1:

  R col = CA row: normed scores

- co:

  Q col = CA column: coordinates

- c1:

  Q col = CA column: normed scores

- lR:

  the row coordinates (R)

- mR:

  the normed row scores (R)

- lQ:

  the row coordinates (Q)

- mQ:

  the normed row scores (Q)

- aR:

  the axis onto co-inertia axis (R)

- aQ:

  the axis onto co-inertia axis (Q)

## References

Doledec, S., Chessel, D., ter Braak, C.J.F. and Champely, S. (1996)
Matching species traits to environmental variables: a new three-table
ordination method. *Environmental and Ecological Statistics*, **3**,
143–166.

Dray, S., Pettorelli, N., Chessel, D. (2002) Matching data sets from two
different spatial samplings. *Journal of Vegetation Science*, **13**,
867–874.

Dray, S. and Legendre, P. (2008) Testing the species traits-environment
relationships: the fourth-corner problem revisited. *Ecology*, **89**,
3400–3412.

ter Braak, C., Cormont, A., Dray, S. (2012) Improved testing of species
traits-environment relationships in the fourth corner problem.
*Ecology*, **93**, 1525–1526.

## Author

Stéphane Dray <stephane.dray@univ-lyon1.fr>

## WARNING

IMPORTANT : row weights for `dudiR` and `dudiQ` must be taken from
`dudiL`.

## Note

A testing procedure based on the total coinertia of the RLQ analysis is
available by the function `randtest.rlq`. The function allows to deal
with various analyses for tables R and Q. Means and variances are
recomputed for each permutation (PCA); for MCA, tables are recentred and
column weights are recomputed.The case of decentred PCA (PCA where
centers are entered by the user) for R or Q is not yet implemented. If
you want to use the testing procedure for this case, you must firstly
center the table and then perform a non-centered PCA on the modified
table.

## See also

[`coinertia`](coinertia.md), [`fourthcorner`](fourthcorner.md)

## Examples

``` r
   data(aviurba)
   coa1 <- dudi.coa(aviurba$fau, scannf = FALSE, nf = 2)
   dudimil <- dudi.hillsmith(aviurba$mil, scannf = FALSE, nf = 2, row.w = coa1$lw)
   duditrait <- dudi.hillsmith(aviurba$traits, scannf = FALSE, nf = 2, row.w = coa1$cw)
   rlq1 <- rlq(dudimil, coa1, duditrait, scannf = FALSE, nf = 2)
   plot(rlq1)
#> Error in s.label(dfxy = rlq1$lR, xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, psub = list(text = "R row scores"), plabels = list(        cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
   summary(rlq1)
#> RLQ analysis
#> 
#> Class: rlq dudi
#> Call: rlq(dudiR = dudimil, dudiL = coa1, dudiQ = duditrait, scannf = FALSE, 
#>     nf = 2)
#> 
#> Total inertia: 0.7278
#> 
#> Eigenvalues:
#>      Ax1      Ax2      Ax3      Ax4      Ax5 
#> 0.478283 0.141851 0.074261 0.023929 0.005514 
#> 
#> Projected inertia (%):
#>     Ax1     Ax2     Ax3     Ax4     Ax5 
#> 65.7131 19.4894 10.2031  3.2877  0.7576 
#> 
#> Cumulative projected inertia (%):
#>     Ax1   Ax1:2   Ax1:3   Ax1:4   Ax1:5 
#>   65.71   85.20   95.41   98.69   99.45 
#> 
#> (Only 5 dimensions (out of 8) are shown)
#> 
#> 
#> Eigenvalues decomposition:
#>         eig     covar      sdR      sdQ      corr
#> 1 0.4782826 0.6915798 1.558312 1.158357 0.3831293
#> 2 0.1418508 0.3766308 1.308050 1.219367 0.2361331
#> 
#> Inertia & coinertia R (dudimil):
#>     inertia      max     ratio
#> 1  2.428337 2.996911 0.8102800
#> 12 4.139332 5.345110 0.7744148
#> 
#> Inertia & coinertia Q (duditrait):
#>     inertia      max     ratio
#> 1  1.341791 2.603139 0.5154512
#> 12 2.828648 4.202981 0.6730098
#> 
#> Correlation L (coa1):
#>        corr       max     ratio
#> 1 0.3831293 0.6435487 0.5953384
#> 2 0.2361331 0.5220054 0.4523576
   randtest(rlq1)
#> Error in eval(expr, p): object 'dudimil' not found
   fourthcorner.rlq(rlq1,type="Q.axes")
#> Error in eval(expr, p): object 'dudimil' not found
   fourthcorner.rlq(rlq1,type="R.axes")
#> Error in eval(expr, p): object 'dudimil' not found
```
