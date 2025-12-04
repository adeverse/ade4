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
#> 1        farms / feed.hab Chi2   4.36429268  1.47044895 greater   0.08
#> 2    small.bui / feed.hab Chi2   5.57481613  1.92964858 greater   0.04
#> 3     high.bui / feed.hab Chi2   3.11706174  0.49737198 greater   0.20
#> 4     industry / feed.hab Chi2   2.05615534  0.38207662 greater   0.30
#> 5       fields / feed.hab Chi2  14.01139382  0.17778577 greater   0.39
#> 6    grassland / feed.hab Chi2   1.27966991 -0.31437919 greater   0.48
#> 7      scrubby / feed.hab Chi2   2.87647118  0.49470626 greater   0.26
#> 8    deciduous / feed.hab Chi2   2.56301663  0.89795624 greater   0.21
#> 9      conifer / feed.hab Chi2   0.67773900 -0.64513542 greater   0.73
#> 10       noisy / feed.hab Chi2   8.04038367 -0.04308534 greater   0.47
#> 11   veg.cover / feed.hab Chi2  29.48926101 -0.20732202 greater   0.50
#> 12     farms / feed.strat Chi2   4.29284964  0.25863484 greater   0.30
#> 13 small.bui / feed.strat Chi2  13.59643807  0.59494119 greater   0.21
#> 14  high.bui / feed.strat Chi2   8.13102044  1.56937970 greater   0.09
#> 15  industry / feed.strat Chi2   1.60089833 -0.45666411 greater   0.59
#> 16    fields / feed.strat Chi2   7.89491358  1.43431195 greater   0.07
#> 17 grassland / feed.strat Chi2   2.11779967 -0.31063666 greater   0.48
#> 18   scrubby / feed.strat Chi2   5.17033389  0.40204166 greater   0.25
#> 19 deciduous / feed.strat Chi2   4.27795300  0.44648285 greater   0.21
#> 20   conifer / feed.strat Chi2   3.27694136 -0.03133941 greater   0.35
#> 21     noisy / feed.strat Chi2   6.75501319  0.93969752 greater   0.16
#> 22 veg.cover / feed.strat Chi2  78.31693213  2.55253518 greater   0.03
#> 23       farms / breeding Chi2   3.23430156 -0.35381060 greater   0.60
#> 24   small.bui / breeding Chi2  27.79316236  1.11689516 greater   0.14
#> 25    high.bui / breeding Chi2  12.43543038  0.87799625 greater   0.11
#> 26    industry / breeding Chi2  22.28586480  2.72799261 greater   0.04
#> 27      fields / breeding Chi2  38.33899311  1.43288500 greater   0.10
#> 28   grassland / breeding Chi2  16.69969331  2.10394232 greater   0.04
#> 29     scrubby / breeding Chi2   7.93877813  0.35925168 greater   0.26
#> 30   deciduous / breeding Chi2  36.37422465  6.40428616 greater   0.01
#> 31     conifer / breeding Chi2   8.13155633  0.27989049 greater   0.24
#> 32       noisy / breeding Chi2  22.81746753  1.29660280 greater   0.13
#> 33   veg.cover / breeding Chi2 118.24035270  2.71174382 greater   0.03
#> 34      farms / migratory Chi2   3.19878341  1.51673588 greater   0.08
#> 35  small.bui / migratory Chi2   0.98799705  0.14955495 greater   0.26
#> 36   high.bui / migratory Chi2   0.62908910 -0.24106656 greater   0.43
#> 37   industry / migratory Chi2   0.98753393  0.06861460 greater   0.26
#> 38     fields / migratory Chi2   5.39284445  2.72670910 greater   0.05
#> 39  grassland / migratory Chi2   0.09775421 -0.70923993 greater   0.72
#> 40    scrubby / migratory Chi2   3.40196612  1.46140502 greater   0.10
#> 41  deciduous / migratory Chi2   0.00146756 -0.80847750 greater   0.97
#> 42    conifer / migratory Chi2   0.18177435 -0.63984920 greater   0.69
#> 43      noisy / migratory Chi2   0.99220442 -0.05884608 greater   0.36
#> 44  veg.cover / migratory Chi2   9.14414536  0.77632059 greater   0.20
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
#> 26       1.00  
#> 27       1.00  
#> 28       1.00  
#> 29       1.00  
#> 30       0.44  
#> 31       1.00  
#> 32       1.00  
#> 33       1.00  
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
#> 1        farms / feed.hab Chi2   4.36429268  0.21983769 greater   0.30
#> 2    small.bui / feed.hab Chi2   5.57481613 -0.42155454 greater   0.56
#> 3     high.bui / feed.hab Chi2   3.11706174 -0.57464143 greater   0.62
#> 4     industry / feed.hab Chi2   2.05615534 -0.22297946 greater   0.49
#> 5       fields / feed.hab Chi2  14.01139382  0.22468885 greater   0.33
#> 6    grassland / feed.hab Chi2   1.27966991 -0.77843441 greater   0.77
#> 7      scrubby / feed.hab Chi2   2.87647118  0.17763999 greater   0.31
#> 8    deciduous / feed.hab Chi2   2.56301663 -0.52024529 greater   0.58
#> 9      conifer / feed.hab Chi2   0.67773900 -0.76015969 greater   0.74
#> 10       noisy / feed.hab Chi2   8.04038367 -0.15287620 greater   0.48
#> 11   veg.cover / feed.hab Chi2  29.48926101 -0.13771174 greater   0.48
#> 12     farms / feed.strat Chi2   4.29284964  0.30373352 greater   0.26
#> 13 small.bui / feed.strat Chi2  13.59643807  0.63102781 greater   0.21
#> 14  high.bui / feed.strat Chi2   8.13102044  0.59730374 greater   0.23
#> 15  industry / feed.strat Chi2   1.60089833 -0.40337641 greater   0.58
#> 16    fields / feed.strat Chi2   7.89491358 -0.41694746 greater   0.57
#> 17 grassland / feed.strat Chi2   2.11779967 -0.49361061 greater   0.68
#> 18   scrubby / feed.strat Chi2   5.17033389  1.38960050 greater   0.12
#> 19 deciduous / feed.strat Chi2   4.27795300 -0.16417181 greater   0.43
#> 20   conifer / feed.strat Chi2   3.27694136  1.23476326 greater   0.16
#> 21     noisy / feed.strat Chi2   6.75501319 -0.09658378 greater   0.45
#> 22 veg.cover / feed.strat Chi2  78.31693213  2.47152676 greater   0.04
#> 23       farms / breeding Chi2   3.23430156 -0.55073564 greater   0.63
#> 24   small.bui / breeding Chi2  27.79316236  1.38830117 greater   0.14
#> 25    high.bui / breeding Chi2  12.43543038  0.50710154 greater   0.34
#> 26    industry / breeding Chi2  22.28586480  2.66605923 greater   0.04
#> 27      fields / breeding Chi2  38.33899311  1.26641577 greater   0.14
#> 28   grassland / breeding Chi2  16.69969331  1.85736371 greater   0.07
#> 29     scrubby / breeding Chi2   7.93877813  1.55811209 greater   0.10
#> 30   deciduous / breeding Chi2  36.37422465  4.65140561 greater   0.02
#> 31     conifer / breeding Chi2   8.13155633  0.24065201 greater   0.26
#> 32       noisy / breeding Chi2  22.81746753  1.29038398 greater   0.14
#> 33   veg.cover / breeding Chi2 118.24035270  3.25419489 greater   0.01
#> 34      farms / migratory Chi2   3.19878341  0.75016832 greater   0.21
#> 35  small.bui / migratory Chi2   0.98799705 -0.61194596 greater   0.70
#> 36   high.bui / migratory Chi2   0.62908910 -0.63618057 greater   0.67
#> 37   industry / migratory Chi2   0.98753393 -0.17227226 greater   0.41
#> 38     fields / migratory Chi2   5.39284445 -0.10459945 greater   0.35
#> 39  grassland / migratory Chi2   0.09775421 -0.78392585 greater   0.80
#> 40    scrubby / migratory Chi2   3.40196612  1.59720437 greater   0.10
#> 41  deciduous / migratory Chi2   0.00146756 -0.83580140 greater   0.99
#> 42    conifer / migratory Chi2   0.18177435 -0.47918681 greater   0.57
#> 43      noisy / migratory Chi2   0.99220442 -0.61507722 greater   0.56
#> 44  veg.cover / migratory Chi2   9.14414536 -0.45339920 greater   0.63
#>    Pvalue.adj  
#> 1     0.70000  
#> 2     0.74919  
#> 3     0.74919  
#> 4     0.74919  
#> 5     0.70000  
#> 6     0.80667  
#> 7     0.70000  
#> 8     0.74919  
#> 9     0.79415  
#> 10    0.74919  
#> 11    0.74919  
#> 12    0.67294  
#> 13    0.61600  
#> 14    0.63250  
#> 15    0.74919  
#> 16    0.74919  
#> 17    0.76718  
#> 18    0.51333  
#> 19    0.74919  
#> 20    0.54154  
#> 21    0.74919  
#> 22    0.29333  
#> 23    0.74919  
#> 24    0.51333  
#> 25    0.70000  
#> 26    0.14667  
#> 27    0.51333  
#> 28    0.19250  
#> 29    0.51333  
#> 30    0.17600  
#> 31    0.38323  
#> 32    0.51333  
#> 33    0.11000  
#> 34    0.61600  
#> 35    0.77000  
#> 36    0.76718  
#> 37    0.74919  
#> 38    0.70000  
#> 39    0.81860  
#> 40    0.51333  
#> 41    0.99000  
#> 42    0.74919  
#> 43    0.74919  
#> 44    0.74919  
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
#>                      Test Stat          Obs     Std.Obs   Alter Pvalue
#> 1        farms / feed.hab Chi2   4.36429268  1.83160009 greater   0.08
#> 2    small.bui / feed.hab Chi2   5.57481613 -0.42152279 greater   0.56
#> 3     high.bui / feed.hab Chi2   3.11706174  0.66266577 greater   0.23
#> 4     industry / feed.hab Chi2   2.05615534  0.26548417 greater   0.29
#> 5       fields / feed.hab Chi2  14.01139382  0.16762752 greater   0.32
#> 6    grassland / feed.hab Chi2   1.27966991 -0.17049393 greater   0.38
#> 7      scrubby / feed.hab Chi2   2.87647118  0.68261666 greater   0.20
#> 8    deciduous / feed.hab Chi2   2.56301663  0.71806243 greater   0.23
#> 9      conifer / feed.hab Chi2   0.67773900 -0.49866678 greater   0.55
#> 10       noisy / feed.hab Chi2   8.04038367 -0.16926715 greater   0.49
#> 11   veg.cover / feed.hab Chi2  29.48926101 -0.22169729 greater   0.50
#> 12     farms / feed.strat Chi2   4.29284964  0.22442150 greater   0.23
#> 13 small.bui / feed.strat Chi2  13.59643807  0.94214154 greater   0.16
#> 14  high.bui / feed.strat Chi2   8.13102044  1.69467551 greater   0.05
#> 15  industry / feed.strat Chi2   1.60089833 -0.47504381 greater   0.59
#> 16    fields / feed.strat Chi2   7.89491358  1.44532170 greater   0.11
#> 17 grassland / feed.strat Chi2   2.11779967 -0.34934427 greater   0.48
#> 18   scrubby / feed.strat Chi2   5.17033389  0.44167475 greater   0.23
#> 19 deciduous / feed.strat Chi2   4.27795300  0.56741372 greater   0.22
#> 20   conifer / feed.strat Chi2   3.27694136  0.27112249 greater   0.30
#> 21     noisy / feed.strat Chi2   6.75501319  0.99290322 greater   0.14
#> 22 veg.cover / feed.strat Chi2  78.31693213  7.09217364 greater   0.01
#> 23       farms / breeding Chi2   3.23430156 -0.55356074 greater   0.69
#> 24   small.bui / breeding Chi2  27.79316236  1.34525655 greater   0.10
#> 25    high.bui / breeding Chi2  12.43543038  1.69084138 greater   0.10
#> 26    industry / breeding Chi2  22.28586480  3.81982042 greater   0.01
#> 27      fields / breeding Chi2  38.33899311  1.14419769 greater   0.17
#> 28   grassland / breeding Chi2  16.69969331  1.87692221 greater   0.06
#> 29     scrubby / breeding Chi2   7.93877813  0.36391300 greater   0.26
#> 30   deciduous / breeding Chi2  36.37422465  6.53404529 greater   0.01
#> 31     conifer / breeding Chi2   8.13155633  0.57813152 greater   0.19
#> 32       noisy / breeding Chi2  22.81746753  1.10381195 greater   0.15
#> 33   veg.cover / breeding Chi2 118.24035270  2.93271697 greater   0.02
#> 34      farms / migratory Chi2   3.19878341  1.78990001 greater   0.08
#> 35  small.bui / migratory Chi2   0.98799705  0.10224520 greater   0.24
#> 36   high.bui / migratory Chi2   0.62908910 -0.35450956 greater   0.44
#> 37   industry / migratory Chi2   0.98753393  0.16733461 greater   0.24
#> 38     fields / migratory Chi2   5.39284445 -0.04847707 greater   0.33
#> 39  grassland / migratory Chi2   0.09775421 -0.63791494 greater   0.69
#> 40    scrubby / migratory Chi2   3.40196612  2.12003415 greater   0.09
#> 41  deciduous / migratory Chi2   0.00146756 -0.71676567 greater   0.98
#> 42    conifer / migratory Chi2   0.18177435 -0.53716782 greater   0.58
#> 43      noisy / migratory Chi2   0.99220442 -0.08916338 greater   0.39
#> 44  veg.cover / migratory Chi2   9.14414536  1.07923006 greater   0.15
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
#> 22       0.44  
#> 23       1.00  
#> 24       1.00  
#> 25       1.00  
#> 26       0.44  
#> 27       1.00  
#> 28       1.00  
#> 29       1.00  
#> 30       0.44  
#> 31       1.00  
#> 32       1.00  
#> 33       0.80  
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
