# Dagnelie multinormality test

Compute Dagnelie test of multivariate normality on a data table of n
objects (rows) and p variables (columns), with n \> (p+1).

## Usage

``` r
dagnelie.test(x)
```

## Arguments

- x:

  Multivariate data table (`matrix` or `data.frame`).

## Value

A list containing the following results:

- Shapiro.Wilk:

  W statistic and p-value

- dim:

  dimensions of the data matrix, n and p

- rank:

  the rank of the covariance matrix

- D:

  Vector containing the Mahalanobis distances of the objects to the
  multivariate centroid

## Details

Dagnelie's goodness-of-fit test of multivariate normality is applicable
to multivariate data. Mahalanobis generalized distances are computed
between each object and the multivariate centroid of all objects.
Dagnelie’s approach is that, for multinormal data, the generalized
distances should be normally distributed. The function computes a
Shapiro-Wilk test of normality of the Mahalanobis distances; this is our
improvement of Dagnelie’s method. The null hypothesis (H0) is that the
data are multinormal, a situation where the Mahalanobis distances should
be normally distributed. In that case, the test should not reject H0,
subject to type I error at the selected significance level.  

Numerical simulations by D. Borcard have shown that the test had correct
levels of type I error for values of n between 3p and 8p, where n is the
number of objects and p is the number of variables in the data matrix
(simulations with 1 \<= p \<= 100). Outside that range of n values, the
results were too liberal, meaning that the test rejected too often the
null hypothesis of normality. For p = 2, the simulations showed the test
to be valid for 6 \<= n \<= 13 and too liberal outside that range. If H0
is not rejected in a situation where the test is too liberal, the result
is trustworthy.  

Calculation of the Mahalanobis distances requires that n \> p+1
(actually, n \> rank+1). With fewer objects (n), all points are at equal
Mahalanobis distances from the centroid in the resulting space, which
has `min(rank,(n-1))` dimensions. For data matrices that happen to be
collinear, the function uses `ginv` for inversion.  

This test is not meant to be used with univariate data; in simulations,
the type I error rate was higher than the 5% significance level for all
values of n. Function `shapiro.test` should be used in that situation.

## References

Dagnelie, P. 1975. L'analyse statistique a plusieurs variables. Les
Presses agronomiques de Gembloux, Gembloux, Belgium.  

Legendre, P. and L. Legendre. 2012. Numerical ecology, 3rd English
edition. Elsevier Science BV, Amsterdam, The Netherlands.  

## Author

Daniel Borcard and Pierre Legendre

## Examples

``` r
 # Example 1: 2 variables, n = 100
 n <- 100; p <- 2
 mat <- matrix(rnorm(n*p), n, p)
 (out <- dagnelie.test(mat))
#> Warning: Test too liberal, n > 8*p
#> Warning: Test too liberal, p = 2, n > 13
#> $Shapiro.Wilk
#> 
#>  Shapiro-Wilk normality test
#> 
#> data:  D
#> W = 0.94868, p-value = 0.0006795
#> 
#> 
#> $dim
#>   n   p 
#> 100   2 
#> 
#> $rank
#> [1] 2
#> 
#> $D
#>   [1] 1.63094440 1.89093073 1.06850561 1.55115932 0.96826146 1.08346893
#>   [7] 0.74003259 2.27601624 0.04195293 1.04875933 0.65721995 1.51316594
#>  [13] 0.91305561 1.49248994 0.57821443 0.91353832 0.41234663 1.66408208
#>  [19] 0.47762322 2.93966877 1.50027325 0.99574548 0.41006601 0.97900343
#>  [25] 1.28677979 0.59719570 1.51469150 0.31240733 1.65567229 1.14803089
#>  [31] 1.02926755 0.61370659 1.11565346 0.84169126 0.83081718 1.23505409
#>  [37] 2.03192676 0.76242361 0.23924818 2.86470781 1.21862318 1.41409564
#>  [43] 1.49384225 1.19496876 1.25188150 1.03742055 0.62553642 0.78882719
#>  [49] 1.10304776 2.62766719 2.66738032 1.03989712 0.85004838 1.43878817
#>  [55] 2.02944870 0.84375116 2.48180198 1.48587103 1.12255560 1.37337122
#>  [61] 1.00506255 0.65390383 1.64042829 0.24514406 0.91401161 0.58476659
#>  [67] 1.36224518 0.99437370 1.31317830 1.30541453 0.52895610 0.56239780
#>  [73] 1.10371289 0.58610533 1.96544357 1.66611633 1.31847687 0.63450296
#>  [79] 1.25309790 0.22189027 2.60280494 1.78737146 2.29351027 2.51691062
#>  [85] 1.37110660 0.79639661 2.34090968 1.16782217 2.21888472 1.16477198
#>  [91] 1.70143554 1.44390375 0.48918958 0.75870102 0.84143827 1.45918507
#>  [97] 0.79702599 3.24858384 1.21958452 0.37648040
#> 

 # Example 2: 10 variables, n = 50
 n <- 50; p <- 10
 mat <- matrix(rnorm(n*p), n, p)
 (out <- dagnelie.test(mat))
#> Warning: Test too liberal, n > 8*p
#> $Shapiro.Wilk
#> 
#>  Shapiro-Wilk normality test
#> 
#> data:  D
#> W = 0.9548, p-value = 0.0539
#> 
#> 
#> $dim
#>  n  p 
#> 50 10 
#> 
#> $rank
#> [1] 10
#> 
#> $D
#>  [1] 2.982941 2.499717 2.324695 3.239122 4.080598 4.233473 3.503733 3.223963
#>  [9] 3.947625 2.086792 2.705997 2.418646 2.480147 2.395558 3.529252 2.939068
#> [17] 1.977943 3.258038 2.141438 4.367838 3.749765 3.213342 2.815072 3.408722
#> [25] 2.291271 3.675192 3.646739 2.296899 3.933074 2.920086 2.512797 2.896804
#> [33] 2.671421 3.418794 2.007475 3.497908 2.725308 2.280538 3.711928 3.621082
#> [41] 3.930047 4.042625 3.783851 3.057676 4.086071 2.946090 2.888217 1.987689
#> [49] 2.377746 2.019824
#> 

 # Example 3: 10 variables, n = 100
 n <- 100; p <- 10
 mat <- matrix(rnorm(n*p), n, p)
 (out <- dagnelie.test(mat))
#> Warning: Test too liberal, n > 8*p
#> $Shapiro.Wilk
#> 
#>  Shapiro-Wilk normality test
#> 
#> data:  D
#> W = 0.98641, p-value = 0.399
#> 
#> 
#> $dim
#>   n   p 
#> 100  10 
#> 
#> $rank
#> [1] 10
#> 
#> $D
#>   [1] 3.358540 3.081322 3.747632 2.657183 2.970503 3.499478 3.770273 3.817320
#>   [9] 3.155442 3.117439 2.331254 3.588218 2.694866 3.500442 1.458891 2.826820
#>  [17] 2.183989 3.015159 2.345796 3.532315 3.341591 2.851331 3.239158 3.096472
#>  [25] 3.250550 3.963005 2.926613 2.471130 3.245057 2.721967 2.950153 2.691303
#>  [33] 4.240487 2.092875 2.622773 2.378713 3.129056 2.381641 3.722073 3.813385
#>  [41] 3.383902 2.473297 3.718014 3.296913 3.581499 4.723389 3.032238 2.925233
#>  [49] 3.455788 3.402161 2.581082 2.422973 4.901725 2.286821 3.146711 2.414125
#>  [57] 2.889677 2.636652 3.711871 3.022434 3.150879 2.431359 2.624719 4.112568
#>  [65] 3.733789 2.832707 3.826711 3.328434 4.165288 4.394543 2.441709 2.463219
#>  [73] 2.911228 2.943938 2.467351 3.531863 2.578056 4.373624 3.499025 2.806816
#>  [81] 1.925170 2.551102 2.394488 1.962291 3.032202 3.005993 3.387403 2.794250
#>  [89] 2.102035 3.437318 3.824340 3.799565 4.156528 2.737391 3.216511 2.469742
#>  [97] 2.725538 2.305617 2.431617 3.366925
#> 
 # Plot a histogram of the Mahalanobis distances
hist(out$D)


 # Example 4: 10 lognormal random variables, n = 50
 n <- 50; p <- 10
 mat <- matrix(round(exp(rnorm((n*p), mean = 0, sd = 2.5))), n, p)
 (out <- dagnelie.test(mat))
#> Warning: Test too liberal, n > 8*p
#> $Shapiro.Wilk
#> 
#>  Shapiro-Wilk normality test
#> 
#> data:  D
#> W = 0.79025, p-value = 5.265e-07
#> 
#> 
#> $dim
#>  n  p 
#> 50 10 
#> 
#> $rank
#> [1] 10
#> 
#> $D
#>  [1] 1.1738462 3.7762757 1.3270182 6.5825578 1.1315532 1.2543027 1.1163972
#>  [8] 2.3734394 1.2666631 2.4916495 1.9324971 1.1581411 6.6388390 1.7328371
#> [15] 1.6771756 1.1771640 2.5688386 1.3966760 2.6512138 4.1826632 6.8873022
#> [22] 1.3540875 1.1516766 1.0468957 1.1869017 3.0068398 1.1720626 4.2801618
#> [29] 0.9876805 6.1115159 1.0666022 1.1929179 1.3389546 1.6058780 0.8515767
#> [36] 4.1690810 1.1017821 3.2679705 1.2536251 1.1208294 6.1252940 1.1553250
#> [43] 5.3577986 3.8429473 1.1894511 2.7191506 6.3416120 2.1903492 2.1776401
#> [50] 4.6354175
#> 
 # Plot a histogram of the Mahalanobis distances
 hist(out$D)

```
