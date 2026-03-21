# Functions to compute the fourth-corner statistic

These functions allow to compute the fourth-corner statistic for
abundance or presence-absence data. The fourth-corner statistic has been
developed by Legendre et al (1997) and extended in Dray and Legendre
(2008). The statistic measures the link between three tables: a table L
(n x p) containing the abundances of p species at n sites, a second
table R (n x m) containing the measurements of m environmental variables
for the n sites, and a third table Q (p x s) describing s species traits
for the p species.

## Usage

``` r
fourthcorner(tabR, tabL, tabQ, modeltype = 6, nrepet = 999, tr01 = FALSE, 
    p.adjust.method.G = p.adjust.methods, p.adjust.method.D = p.adjust.methods, 
    p.adjust.D = c("global", "levels"), ...)

fourthcorner2(tabR, tabL, tabQ, modeltype = 6, nrepet = 999, tr01 = FALSE, 
    p.adjust.method.G = p.adjust.methods, ...)

# S3 method for class '4thcorner'
print(x, varQ = 1:length(x$varnames.Q), 
    varR = 1:length(x$varnames.R), stat = c("D", "D2"), ...)

# S3 method for class '4thcorner'
summary(object,...)

# S3 method for class '4thcorner'
plot(x, stat = c("D", "D2", "G"), type = c("table", "biplot"), 
    xax = 1, yax = 2, x.rlq = NULL, alpha = 0.05, 
    col = c("lightgrey", "red", "deepskyblue", "purple"), ...)

fourthcorner.rlq(xtest, nrepet = 999, modeltype = 6, 
    typetest = c("axes", "Q.axes", "R.axes"), p.adjust.method.G = p.adjust.methods, 
    p.adjust.method.D = p.adjust.methods, p.adjust.D = c("global", "levels"), ...)
```

## Arguments

- tabR:

  a dataframe containing the measurements (numeric values or factors) of
  m environmental variables (columns) for the n sites (rows).

- tabL:

  a dataframe containing the abundances of p species (columns) at n
  sites (rows).

- tabQ:

  a dataframe containing numeric values or factors describing s species
  traits (columns) for the p species (rows).

- modeltype:

  an integer (1-6) indicating the permutation model used in the testing
  procedure (see details).

- nrepet:

  the number of permutations

- tr01:

  a logical indicating if data in `tabL` must be transformed to
  presence-absence data (FALSE by default)

- object:

  an object of the class 4thcorner

- x:

  an object of the class 4thcorner

- varR:

  a vector containing indices for variables in `tabR`

- varQ:

  a vector containing indices for variables in `tabQ`

- type:

  results are represented by a table or on a biplot (see x.rlq)

- alpha:

  a value of significance level

- p.adjust.method.G:

  a string indicating a method for multiple adjustment used for output
  tabG, see [`p.adjust.methods`](https://rdrr.io/r/stats/p.adjust.html)
  for possible choices

- p.adjust.method.D:

  a string indicating a method for multiple adjustment used for output
  tabD/tabD2, see `p.adjust.methods` for possible choices

- p.adjust.D:

  a string indicating if multiple adjustment for tabD/tabD2 should be
  done globally or only between levels of a factor ("levels", as in the
  original paper of Legendre et al. 1997)

- stat:

  a character to specify if results should be plotted for cells (D and
  D2) or variables (G)

- xax:

  an integer indicating which rlq axis should be plotted on the x-axis

- yax:

  an integer indicating which rlq axis should be plotted on the y-axis

- x.rlq:

  an object created by the `rlq` function. Used to represent results on
  a biplot (type should be "biplot" and object created by the
  `fourthcorner` functions)

- col:

  a vector of length 4 containing four colors used for the graphical
  representations. The first is used to represent non-significant
  associations, the second positive significant, the third negative
  significant. For the 'biplot' method and objects created by the
  `fourthcorner.rlq` function, the second corresponds to variables
  significantly linked to the x-axis, the third for the y-axis and the
  fourth for both axes

- xtest:

  an object created by the `rlq` function

- typetest:

  a string indicating which tests should be performed

- ...:

  further arguments passed to or from other methods

## Details

For the `fourthcorner` function, the link is measured by a Pearson
correlation coefficient for two quantitative variables (trait and
environmental variable), by a Pearson Chi2 and G statistic for two
qualitative variables and by a Pseudo-F and Pearson r for one
quantitative variable and one qualitative variable. The fourthcorner2
function offers a multivariate statistic (equal to the sum of
eigenvalues of RLQ analysis) and measures the link between two variables
by a square correlation coefficient (quant/quant), a Chi2/sum(L)
(qual/qual) and a correlation ratio (quant/qual). The significance is
tested by a permutation procedure. Different models are available:

- model 1 (`modeltype`=1): Permute values for each species independently
  (i.e., permute within each column of table L)

- model 2 (`modeltype`=2): Permute values of sites (i.e., permute entire
  rows of table L)

- model 3 (`modeltype`=3): Permute values for each site independently
  (i.e., permute within each row of table L)

- model 4 (`modeltype`=4): Permute values of species (i.e., permute
  entire columns of table L)

- model 5 (`modeltype`=5): Permute values of species and after (or
  before) permute values of sites (i.e., permute entire columns and
  after (or before) entire rows of table L)

- model 6 (`modeltype`=6): combination of the outputs of models 2 and 4.
  Dray and Legendre (2008) and ter Braak et al. (20012) showed that all
  models (except model 6) have inflated type I error.

Note that the model 5 is strictly equivalent to permuting simultaneously
the rows of tables R and Q, as proposed by Doledec et al. (1996).

The function `summary` returns results for variables (G). The function
`print` returns results for cells (D and D2). In the case of qualitative
variables, Holm's corrected pvalues are also provided.

The function `plot` produces a graphical representation of the results
(white for non significant, light grey for negative significant and dark
grey for positive significant relationships). Results can be plotted for
variables (G) or for cells (D and D2). In the case of qualitative /
quantitative association, homogeneity (D) or correlation (D2) are
plotted.

## Value

The `fourthcorner` function returns a a list where:

- `tabD` is a `krandtest` object giving the results of tests for cells
  of the fourth-corner (homogeneity for quant./qual.).

- `tabD2` is a `krandtest` object giving the results of tests for cells
  of the fourth-corner (Pearson r for quant./qual.).

- `tabG` is a `krandtest` object giving the results of tests for
  variables (Pearson's Chi2 for qual./qual.).

The `fourthcorner2` function returns a list where:

- `tabG` is a `krandtest` object giving the results of tests for
  variables.

- `trRLQ` is a `krandtest` object giving the results of tests for the
  multivariate statistic (i.e. equivalent to `randtest.rlq` function).

## References

Doledec, S., Chessel, D., ter Braak, C.J.F. and Champely, S. (1996)
Matching species traits to environmental variables: a new three-table
ordination method. *Environmental and Ecological Statistics*, **3**,
143–166.

Legendre, P., R. Galzin, and M. L. Harmelin-Vivien. (1997) Relating
behavior to habitat: solutions to the fourth-corner problem. *Ecology*,
**78**, 547–562.

Dray, S. and Legendre, P. (2008) Testing the species traits-environment
relationships: the fourth-corner problem revisited. *Ecology*, **89**,
3400–3412.

ter Braak, C., Cormont, A., and Dray, S. (2012) Improved testing of
species traits-environment relationships in the fourth corner problem.
*Ecology*, **93**, 1525–1526.

Dray, S., Choler, P., Doledec, S., Peres-Neto, P.R., Thuiller, W.,
Pavoine, S. and ter Braak, C.J.F (2014) Combining the fourth-corner and
the RLQ methods for assessing trait responses to environmental
variation. *Ecology*, **95**, 14–21. doi:10.1890/13-0196.1

## Author

Stéphane Dray <stephane.dray@univ-lyon1.fr>

## See also

[`rlq`](rlq.md), [`combine.4thcorner`](combine.4thcorner.md),
[`p.adjust.methods`](https://rdrr.io/r/stats/p.adjust.html)

## Examples

``` r
data(aviurba)

## Version using the sequential test (ter Braak et al 2012)
## as recommended in Dray et al (2013), 
## using Holm correction of P-values (only 99 permutations here)
four.comb.default <- fourthcorner(aviurba$mil,aviurba$fau,aviurba$traits,nrepet=99)
summary(four.comb.default)
#> Fourth-corner Statistics
#> ------------------------
#> Permutation method  Comb. 2 and 4  ( 99  permutations)
#> 
#> Adjustment method for multiple comparisons:   holm 
#>                      Test Stat          Obs     Std.Obs   Alter Pvalue
#> 1        farms / feed.hab Chi2   4.36429268  1.56087440 greater   0.09
#> 2    small.bui / feed.hab Chi2   5.57481613  2.35447089 greater   0.04
#> 3     high.bui / feed.hab Chi2   3.11706174  0.80753196 greater   0.15
#> 4     industry / feed.hab Chi2   2.05615534  0.18657462 greater   0.27
#> 5       fields / feed.hab Chi2  14.01139382  0.01587947 greater   0.36
#> 6    grassland / feed.hab Chi2   1.27966991 -0.27049787 greater   0.52
#> 7      scrubby / feed.hab Chi2   2.87647118  0.99403402 greater   0.14
#> 8    deciduous / feed.hab Chi2   2.56301663  0.41013645 greater   0.26
#> 9      conifer / feed.hab Chi2   0.67773900 -0.63151584 greater   0.64
#> 10       noisy / feed.hab Chi2   8.04038367 -0.10370159 greater   0.45
#> 11   veg.cover / feed.hab Chi2  29.48926101 -0.24754824 greater   0.55
#> 12     farms / feed.strat Chi2   4.29284964  0.25988328 greater   0.34
#> 13 small.bui / feed.strat Chi2  13.59643807  3.02576397 greater   0.03
#> 14  high.bui / feed.strat Chi2   8.13102044  1.59705808 greater   0.08
#> 15  industry / feed.strat Chi2   1.60089833 -0.41105820 greater   0.57
#> 16    fields / feed.strat Chi2   7.89491358  1.31018587 greater   0.11
#> 17 grassland / feed.strat Chi2   2.11779967 -0.34769650 greater   0.56
#> 18   scrubby / feed.strat Chi2   5.17033389  0.71915112 greater   0.22
#> 19 deciduous / feed.strat Chi2   4.27795300  0.26846000 greater   0.25
#> 20   conifer / feed.strat Chi2   3.27694136  0.03158244 greater   0.35
#> 21     noisy / feed.strat Chi2   6.75501319  0.90623837 greater   0.14
#> 22 veg.cover / feed.strat Chi2  78.31693213  2.82198434 greater   0.02
#> 23       farms / breeding Chi2   3.23430156 -0.59395510 greater   0.66
#> 24   small.bui / breeding Chi2  27.79316236  2.07240650 greater   0.04
#> 25    high.bui / breeding Chi2  12.43543038  1.57218462 greater   0.11
#> 26    industry / breeding Chi2  22.28586480  3.20618256 greater   0.03
#> 27      fields / breeding Chi2  38.33899311  1.74871835 greater   0.08
#> 28   grassland / breeding Chi2  16.69969331  1.66338951 greater   0.09
#> 29     scrubby / breeding Chi2   7.93877813  0.25828663 greater   0.29
#> 30   deciduous / breeding Chi2  36.37422465  6.77846693 greater   0.01
#> 31     conifer / breeding Chi2   8.13155633  0.56589136 greater   0.25
#> 32       noisy / breeding Chi2  22.81746753  1.22387736 greater   0.13
#> 33   veg.cover / breeding Chi2 118.24035270  5.43023816 greater   0.01
#> 34      farms / migratory Chi2   3.19878341  2.22349324 greater   0.05
#> 35  small.bui / migratory Chi2   0.98799705  0.18275687 greater   0.27
#> 36   high.bui / migratory Chi2   0.62908910 -0.23006340 greater   0.44
#> 37   industry / migratory Chi2   0.98753393  0.17182282 greater   0.30
#> 38     fields / migratory Chi2   5.39284445 -0.19129813 greater   0.35
#> 39  grassland / migratory Chi2   0.09775421 -0.68415537 greater   0.76
#> 40    scrubby / migratory Chi2   3.40196612  2.02022480 greater   0.05
#> 41  deciduous / migratory Chi2   0.00146756 -0.84220932 greater   0.97
#> 42    conifer / migratory Chi2   0.18177435 -0.67104944 greater   0.69
#> 43      noisy / migratory Chi2   0.99220442 -0.10863722 greater   0.39
#> 44  veg.cover / migratory Chi2   9.14414536  0.76897839 greater   0.21
#>    Pvalue.adj  
#> 1        1.00  
#> 2        1.00  
#> 3        1.00  
#> 4        1.00  
#> 5        1.00  
#> 6        1.00  
#> 7        1.00  
#> 8        1.00  
#> 9        1.00  
#> 10       1.00  
#> 11       1.00  
#> 12       1.00  
#> 13       1.00  
#> 14       1.00  
#> 15       1.00  
#> 16       1.00  
#> 17       1.00  
#> 18       1.00  
#> 19       1.00  
#> 20       1.00  
#> 21       1.00  
#> 22       0.82  
#> 23       1.00  
#> 24       1.00  
#> 25       1.00  
#> 26       1.00  
#> 27       1.00  
#> 28       1.00  
#> 29       1.00  
#> 30       0.44  
#> 31       1.00  
#> 32       1.00  
#> 33       0.44  
#> 34       1.00  
#> 35       1.00  
#> 36       1.00  
#> 37       1.00  
#> 38       1.00  
#> 39       1.00  
#> 40       1.00  
#> 41       1.00  
#> 42       1.00  
#> 43       1.00  
#> 44       1.00  
#> 
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 
plot(four.comb.default, stat = "G")


## using fdr correction of P-values
four.comb.fdr <- fourthcorner(aviurba$mil, aviurba$fau, aviurba$traits,
nrepet = 99, p.adjust.method.G = 'fdr', p.adjust.method.D = 'fdr')  
summary(four.comb.fdr)
#> Fourth-corner Statistics
#> ------------------------
#> Permutation method  Comb. 2 and 4  ( 99  permutations)
#> 
#> Adjustment method for multiple comparisons:   fdr 
#>                      Test Stat          Obs     Std.Obs   Alter Pvalue
#> 1        farms / feed.hab Chi2   4.36429268  0.08444920 greater   0.39
#> 2    small.bui / feed.hab Chi2   5.57481613 -0.56245485 greater   0.63
#> 3     high.bui / feed.hab Chi2   3.11706174 -0.69931944 greater   0.73
#> 4     industry / feed.hab Chi2   2.05615534 -0.27089109 greater   0.53
#> 5       fields / feed.hab Chi2  14.01139382  0.01585856 greater   0.37
#> 6    grassland / feed.hab Chi2   1.27966991 -0.90002289 greater   0.80
#> 7      scrubby / feed.hab Chi2   2.87647118  0.14874735 greater   0.33
#> 8    deciduous / feed.hab Chi2   2.56301663 -0.75412800 greater   0.72
#> 9      conifer / feed.hab Chi2   0.67773900 -0.77044266 greater   0.77
#> 10       noisy / feed.hab Chi2   8.04038367 -0.10955155 greater   0.51
#> 11   veg.cover / feed.hab Chi2  29.48926101 -0.31871265 greater   0.57
#> 12     farms / feed.strat Chi2   4.29284964  0.10793165 greater   0.32
#> 13 small.bui / feed.strat Chi2  13.59643807  0.84406222 greater   0.22
#> 14  high.bui / feed.strat Chi2   8.13102044  0.66374667 greater   0.21
#> 15  industry / feed.strat Chi2   1.60089833 -0.43596531 greater   0.54
#> 16    fields / feed.strat Chi2   7.89491358 -0.43961301 greater   0.57
#> 17 grassland / feed.strat Chi2   2.11779967 -0.49403371 greater   0.63
#> 18   scrubby / feed.strat Chi2   5.17033389  1.14639007 greater   0.14
#> 19 deciduous / feed.strat Chi2   4.27795300 -0.13570810 greater   0.47
#> 20   conifer / feed.strat Chi2   3.27694136  0.92459971 greater   0.17
#> 21     noisy / feed.strat Chi2   6.75501319 -0.21024895 greater   0.49
#> 22 veg.cover / feed.strat Chi2  78.31693213  2.92822358 greater   0.02
#> 23       farms / breeding Chi2   3.23430156 -0.65859532 greater   0.72
#> 24   small.bui / breeding Chi2  27.79316236  1.76629982 greater   0.08
#> 25    high.bui / breeding Chi2  12.43543038  0.58935710 greater   0.31
#> 26    industry / breeding Chi2  22.28586480  2.24498500 greater   0.06
#> 27      fields / breeding Chi2  38.33899311  1.39180530 greater   0.09
#> 28   grassland / breeding Chi2  16.69969331  1.91881467 greater   0.07
#> 29     scrubby / breeding Chi2   7.93877813  0.18231271 greater   0.37
#> 30   deciduous / breeding Chi2  36.37422465  4.62627399 greater   0.01
#> 31     conifer / breeding Chi2   8.13155633  0.31347821 greater   0.27
#> 32       noisy / breeding Chi2  22.81746753  1.14946772 greater   0.14
#> 33   veg.cover / breeding Chi2 118.24035270  3.43046783 greater   0.02
#> 34      farms / migratory Chi2   3.19878341  0.51243250 greater   0.21
#> 35  small.bui / migratory Chi2   0.98799705 -0.61512396 greater   0.66
#> 36   high.bui / migratory Chi2   0.62908910 -0.66947687 greater   0.72
#> 37   industry / migratory Chi2   0.98753393 -0.31724978 greater   0.53
#> 38     fields / migratory Chi2   5.39284445 -0.10085539 greater   0.41
#> 39  grassland / migratory Chi2   0.09775421 -0.68397948 greater   0.76
#> 40    scrubby / migratory Chi2   3.40196612  0.76937961 greater   0.15
#> 41  deciduous / migratory Chi2   0.00146756 -0.77391304 greater   0.99
#> 42    conifer / migratory Chi2   0.18177435 -0.61336604 greater   0.64
#> 43      noisy / migratory Chi2   0.99220442 -0.51612418 greater   0.57
#> 44  veg.cover / migratory Chi2   9.14414536 -0.54359751 greater   0.67
#>    Pvalue.adj  
#> 1     0.80300  
#> 2     0.80300  
#> 3     0.80300  
#> 4     0.80300  
#> 5     0.80300  
#> 6     0.81860  
#> 7     0.76421  
#> 8     0.80300  
#> 9     0.80667  
#> 10    0.80300  
#> 11    0.80300  
#> 12    0.76421  
#> 13    0.60500  
#> 14    0.60500  
#> 15    0.80300  
#> 16    0.80300  
#> 17    0.80300  
#> 18    0.55000  
#> 19    0.80300  
#> 20    0.57538  
#> 21    0.80300  
#> 22    0.14667  
#> 23    0.80300  
#> 24    0.44000  
#> 25    0.76421  
#> 26    0.18857  
#> 27    0.44000  
#> 28    0.19250  
#> 29    0.47882  
#> 30    0.14667  
#> 31    0.40966  
#> 32    0.55000  
#> 33    0.14667  
#> 34    0.60500  
#> 35    0.80300  
#> 36    0.80300  
#> 37    0.80300  
#> 38    0.80300  
#> 39    0.80667  
#> 40    0.55000  
#> 41    0.99000  
#> 42    0.80300  
#> 43    0.80300  
#> 44    0.80300  
#> 
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 
plot(four.comb.fdr, stat = "G")

## Explicit procedure to combine the results of two models
## proposed in Dray and Legendre (2008);the above does this implicitly
four2 <- fourthcorner(aviurba$mil,aviurba$fau,aviurba$traits,nrepet=99,modeltype=2)
four4 <- fourthcorner(aviurba$mil,aviurba$fau,aviurba$traits,nrepet=99,modeltype=4)
four.comb <- combine.4thcorner(four2, four4)
summary(four.comb)
#> Fourth-corner Statistics
#> ------------------------
#> Permutation method  Comb. 2 and 4  ( 99  permutations)
#> 
#> Adjustment method for multiple comparisons:   holm 
#>                      Test Stat          Obs      Std.Obs   Alter Pvalue
#> 1        farms / feed.hab Chi2   4.36429268  1.772923100 greater   0.08
#> 2    small.bui / feed.hab Chi2   5.57481613 -0.399943628 greater   0.57
#> 3     high.bui / feed.hab Chi2   3.11706174  0.749742625 greater   0.20
#> 4     industry / feed.hab Chi2   2.05615534  0.191832523 greater   0.31
#> 5       fields / feed.hab Chi2  14.01139382  0.076776654 greater   0.38
#> 6    grassland / feed.hab Chi2   1.27966991 -0.251632434 greater   0.46
#> 7      scrubby / feed.hab Chi2   2.87647118  0.865325650 greater   0.12
#> 8    deciduous / feed.hab Chi2   2.56301663  0.553225900 greater   0.20
#> 9      conifer / feed.hab Chi2   0.67773900 -0.611164174 greater   0.74
#> 10       noisy / feed.hab Chi2   8.04038367 -0.103092634 greater   0.41
#> 11   veg.cover / feed.hab Chi2  29.48926101 -0.211120806 greater   0.51
#> 12     farms / feed.strat Chi2   4.29284964  0.538062185 greater   0.23
#> 13 small.bui / feed.strat Chi2  13.59643807  0.434536385 greater   0.24
#> 14  high.bui / feed.strat Chi2   8.13102044  1.307090757 greater   0.12
#> 15  industry / feed.strat Chi2   1.60089833 -0.567452153 greater   0.71
#> 16    fields / feed.strat Chi2   7.89491358  2.061937072 greater   0.06
#> 17 grassland / feed.strat Chi2   2.11779967 -0.254530348 greater   0.48
#> 18   scrubby / feed.strat Chi2   5.17033389  0.635419257 greater   0.18
#> 19 deciduous / feed.strat Chi2   4.27795300  0.252059758 greater   0.24
#> 20   conifer / feed.strat Chi2   3.27694136 -0.004285558 greater   0.37
#> 21     noisy / feed.strat Chi2   6.75501319  1.055741945 greater   0.09
#> 22 veg.cover / feed.strat Chi2  78.31693213  2.271444296 greater   0.04
#> 23       farms / breeding Chi2   3.23430156 -0.451190525 greater   0.61
#> 24   small.bui / breeding Chi2  27.79316236  1.591234205 greater   0.10
#> 25    high.bui / breeding Chi2  12.43543038  1.078922685 greater   0.11
#> 26    industry / breeding Chi2  22.28586480  2.975074748 greater   0.02
#> 27      fields / breeding Chi2  38.33899311  1.581865812 greater   0.08
#> 28   grassland / breeding Chi2  16.69969331  2.001497202 greater   0.07
#> 29     scrubby / breeding Chi2   7.93877813  0.350146560 greater   0.33
#> 30   deciduous / breeding Chi2  36.37422465  5.283761734 greater   0.02
#> 31     conifer / breeding Chi2   8.13155633  0.314074536 greater   0.30
#> 32       noisy / breeding Chi2  22.81746753  1.254935621 greater   0.11
#> 33   veg.cover / breeding Chi2 118.24035270  5.766599014 greater   0.01
#> 34      farms / migratory Chi2   3.19878341  2.429138820 greater   0.06
#> 35  small.bui / migratory Chi2   0.98799705  0.102422159 greater   0.32
#> 36   high.bui / migratory Chi2   0.62908910 -0.360852256 greater   0.49
#> 37   industry / migratory Chi2   0.98753393 -0.186837026 greater   0.41
#> 38     fields / migratory Chi2   5.39284445 -0.146690057 greater   0.37
#> 39  grassland / migratory Chi2   0.09775421 -0.655215841 greater   0.72
#> 40    scrubby / migratory Chi2   3.40196612  2.740580924 greater   0.04
#> 41  deciduous / migratory Chi2   0.00146756 -0.689265187 greater   0.97
#> 42    conifer / migratory Chi2   0.18177435 -0.538937155 greater   0.59
#> 43      noisy / migratory Chi2   0.99220442 -0.048754914 greater   0.32
#> 44  veg.cover / migratory Chi2   9.14414536  0.911176423 greater   0.15
#>    Pvalue.adj  
#> 1        1.00  
#> 2        1.00  
#> 3        1.00  
#> 4        1.00  
#> 5        1.00  
#> 6        1.00  
#> 7        1.00  
#> 8        1.00  
#> 9        1.00  
#> 10       1.00  
#> 11       1.00  
#> 12       1.00  
#> 13       1.00  
#> 14       1.00  
#> 15       1.00  
#> 16       1.00  
#> 17       1.00  
#> 18       1.00  
#> 19       1.00  
#> 20       1.00  
#> 21       1.00  
#> 22       1.00  
#> 23       1.00  
#> 24       1.00  
#> 25       1.00  
#> 26       0.72  
#> 27       1.00  
#> 28       1.00  
#> 29       1.00  
#> 30       0.72  
#> 31       1.00  
#> 32       1.00  
#> 33       0.44  
#> 34       1.00  
#> 35       1.00  
#> 36       1.00  
#> 37       1.00  
#> 38       1.00  
#> 39       1.00  
#> 40       1.00  
#> 41       1.00  
#> 42       1.00  
#> 43       1.00  
#> 44       1.00  
#> 
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 
plot(four.comb, stat = "G")

```
