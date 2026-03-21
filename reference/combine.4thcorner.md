# Functions to combine and adjust the outputs 3-table methods

Functions to combine and adjust the outputs of the `fourthcorner` and
`randtest.rlq` functions created using permutational models 2 and 4
(sequential approach).

## Usage

``` r
combine.randtest.rlq(obj1, obj2, ...)
combine.4thcorner(four1,four2)
p.adjust.4thcorner(x, p.adjust.method.G = p.adjust.methods,
p.adjust.method.D = p.adjust.methods, p.adjust.D = c("global",
"levels"))
```

## Arguments

- four1:

  an object of the class 4thcorner created with modeltype = 2 (or 4)

- four2:

  an object of the class 4thcorner created with modeltype = 4 (or 2)

- obj1:

  an object created with `randtest.rlq` and modeltype = 2 (or 4)

- obj2:

  an object created with `randtest.rlq` and modeltype = 4 (or 2)

- x:

  an object of the class 4thcorner

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

- ...:

  further arguments passed to or from other methods

## Details

The functions combines the outputs of two objects (created by
`fourthcorner` and `randtest.rlq` functions) as described in Dray and
Legendre (2008) and ter Braak et al (2012).

## Value

The functions return objects of the same class than their argument. They
simply create a new object where pvalues are equal to the maximum of
pvalues of the two arguments.

## References

Dray, S. and Legendre, P. (2008) Testing the species traits-environment
relationships: the fourth-corner problem revisited. *Ecology*, **89**,
3400–3412.

ter Braak, C., Cormont, A., and Dray, S. (2012) Improved testing of
species traits-environment relationships in the fourth corner problem.
*Ecology*, **93**, 1525–1526.

## Author

Stéphane Dray <stephane.dray@univ-lyon1.fr>

## See also

[`rlq`](rlq.md), [`fourthcorner`](fourthcorner.md),
[`p.adjust.methods`](https://rdrr.io/r/stats/p.adjust.html)

## Examples

``` r
data(aravo)
four2 <- fourthcorner(aravo$env, aravo$spe, aravo$traits, nrepet=99,modeltype=2)
four4 <- fourthcorner(aravo$env, aravo$spe, aravo$traits, nrepet=99,modeltype=4)
four.comb <- combine.4thcorner(four2,four4)
## or directly :
## four.comb <- fourthcorner(aravo$env, aravo$spe, aravo$traits, nrepet=99,modeltype=6)
summary(four.comb)
#> Fourth-corner Statistics
#> ------------------------
#> Permutation method  Comb. 2 and 4  ( 99  permutations)
#> 
#> Adjustment method for multiple comparisons:   holm 
#>               Test Stat           Obs     Std.Obs     Alter Pvalue Pvalue.adj  
#> 1  Aspect / Height    r  -0.045735104 -1.07962114 two-sided   0.32       1.00  
#> 2   Slope / Height    r   0.094917344  1.94978334 two-sided   0.08       1.00  
#> 3    Form / Height    F  15.219879474  3.23795242   greater   0.02       0.72  
#> 4   PhysD / Height    r   0.113164322  1.98108834 two-sided   0.04       1.00  
#> 5   ZoogD / Height    F  15.227717714  1.67606996   greater   0.11       1.00  
#> 6    Snow / Height    r  -0.271739531 -2.80497356 two-sided   0.02       0.72  
#> 7  Aspect / Spread    r  -0.044170141 -1.55510898 two-sided   0.11       1.00  
#> 8   Slope / Spread    r  -0.017325425 -0.77364418 two-sided   0.47       1.00  
#> 9    Form / Spread    F   5.548173196  0.22476723   greater   0.27       1.00  
#> 10  PhysD / Spread    r  -0.051680330 -0.93941452 two-sided   0.30       1.00  
#> 11  ZoogD / Spread    F   0.120114487 -1.01756970   greater   0.93       1.00  
#> 12   Snow / Spread    r   0.065634673  0.73407808 two-sided   0.49       1.00  
#> 13  Aspect / Angle    r  -0.090837201 -1.90874050 two-sided   0.07       1.00  
#> 14   Slope / Angle    r   0.100281966  2.29945221 two-sided   0.04       1.00  
#> 15    Form / Angle    F  30.664664234  7.89119483   greater   0.01       0.48  
#> 16   PhysD / Angle    r   0.221380084  4.55626644 two-sided   0.01       0.48  
#> 17   ZoogD / Angle    F  28.051040522  3.16689819   greater   0.02       0.72  
#> 18    Snow / Angle    r  -0.269613756 -2.60618791 two-sided   0.02       0.72  
#> 19   Aspect / Area    r   0.031237858  0.74372511 two-sided   0.56       1.00  
#> 20    Slope / Area    r  -0.003864605 -0.03480649 two-sided   0.98       1.00  
#> 21     Form / Area    F  13.609309880  2.64227747   greater   0.03       0.93  
#> 22    PhysD / Area    r  -0.134371361 -2.07282497 two-sided   0.03       0.93  
#> 23    ZoogD / Area    F  49.672266332 14.29032202   greater   0.01       0.48  
#> 24     Snow / Area    r  -0.024574466 -0.43634412 two-sided   0.59       1.00  
#> 25  Aspect / Thick    r  -0.058466142 -1.38136315 two-sided   0.17       1.00  
#> 26   Slope / Thick    r   0.074151819  1.49324698 two-sided   0.14       1.00  
#> 27    Form / Thick    F  14.204346501  9.41120270   greater   0.01       0.48  
#> 28   PhysD / Thick    r   0.143161734  2.40103522 two-sided   0.02       0.72  
#> 29   ZoogD / Thick    F   2.825887968  0.57502021   greater   0.19       1.00  
#> 30    Snow / Thick    r  -0.154660144 -1.67889659 two-sided   0.11       1.00  
#> 31    Aspect / SLA    r  -0.007694551  0.05042614 two-sided   0.97       1.00  
#> 32     Slope / SLA    r  -0.235864886 -3.71571891 two-sided   0.01       0.48  
#> 33      Form / SLA    F 100.787472071 17.10157728   greater   0.01       0.48  
#> 34     PhysD / SLA    r  -0.275524984 -4.78051167 two-sided   0.01       0.48  
#> 35     ZoogD / SLA    F   0.984301951 -0.87404483   greater   0.89       1.00  
#> 36      Snow / SLA    r   0.481181824  7.94830614 two-sided   0.01       0.48  
#> 37 Aspect / N_mass    r  -0.061575524 -0.92404445 two-sided   0.36       1.00  
#> 38  Slope / N_mass    r  -0.201308154 -3.61596658 two-sided   0.01       0.48  
#> 39   Form / N_mass    F  70.042280400 13.06958338   greater   0.01       0.48  
#> 40  PhysD / N_mass    r  -0.212434381 -3.96829951 two-sided   0.01       0.48  
#> 41  ZoogD / N_mass    F  10.300092724  0.72853295   greater   0.17       1.00  
#> 42   Snow / N_mass    r   0.429271163  7.98893996 two-sided   0.01       0.48  
#> 43   Aspect / Seed    r   0.011598435  0.23319198 two-sided   0.85       1.00  
#> 44    Slope / Seed    r   0.077073974  1.63665889 two-sided   0.07       1.00  
#> 45     Form / Seed    F   5.561841954  0.50422249   greater   0.20       1.00  
#> 46    PhysD / Seed    r   0.078156305  1.37549602 two-sided   0.19       1.00  
#> 47    ZoogD / Seed    F   3.369068338  1.27476528   greater   0.12       1.00  
#> 48     Snow / Seed    r  -0.177640721 -1.92068825 two-sided   0.05       1.00  
#> 
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 
plot(four.comb, stat = "G")

```
