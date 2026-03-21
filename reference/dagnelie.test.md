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
#> W = 0.96925, p-value = 0.01937
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
#>   [1] 0.5535110 2.1111847 0.6670758 1.5903467 0.8096317 1.7782095 1.4189089
#>   [8] 2.1615977 0.9828355 0.1690712 1.5248038 1.1707313 0.3222303 2.2681475
#>  [15] 0.5374474 1.9033979 0.8644053 0.7356276 0.9801687 0.7165373 1.3554173
#>  [22] 1.1642021 1.8980861 2.2497536 1.9486967 0.9399706 0.8379801 1.0710908
#>  [29] 1.9863035 0.4331475 1.0267191 0.4177554 1.9351857 0.7459052 1.7482054
#>  [36] 0.8184868 0.5880801 0.7650213 1.7551036 2.9442810 0.3797974 1.9373420
#>  [43] 0.9750406 1.5377516 1.8022340 1.2610208 1.2275963 0.8874240 0.4406506
#>  [50] 0.4379825 0.5796663 1.5430368 1.4449607 0.2472525 1.2745896 0.3241079
#>  [57] 1.7681244 1.6881133 0.8465860 2.1487794 1.6681068 0.4660349 1.8687249
#>  [64] 1.5779564 0.9144549 1.4533915 1.3821361 2.3479446 0.2586836 0.8267999
#>  [71] 1.0927939 1.2168965 0.8221757 0.4191494 2.0050845 0.5659146 1.7053075
#>  [78] 1.7131770 2.3275202 0.8620697 1.2183618 1.6950322 0.5316685 1.7219435
#>  [85] 1.8982532 2.2765959 1.2883150 1.5602959 1.6441233 0.5042770 0.4951930
#>  [92] 0.8632775 1.9851399 1.2359561 1.3323319 1.8458696 1.1996730 1.8396811
#>  [99] 1.5127227 1.9700471
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
#> W = 0.99039, p-value = 0.9548
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
#>  [1] 2.155455 1.585140 2.987680 3.471312 3.106940 2.280799 3.373521 2.449685
#>  [9] 3.641319 3.486653 3.884743 3.118663 3.039722 2.370332 2.303691 2.613256
#> [17] 2.181152 1.605335 4.056560 3.030667 2.496761 2.743386 3.296350 3.115571
#> [25] 3.197646 3.594263 4.179088 3.664752 3.999952 3.406870 3.144629 3.278512
#> [33] 2.894604 2.852029 2.102800 3.691161 2.724074 2.049781 3.124609 3.458109
#> [41] 3.667658 3.732755 3.568830 4.582348 2.868771 3.168056 3.919014 2.503977
#> [49] 2.584310 2.685861
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
#> W = 0.992, p-value = 0.8213
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
#>   [1] 2.392303 2.301161 3.465157 1.713054 4.348974 3.783714 3.063413 3.743573
#>   [9] 4.232318 2.079291 2.566326 2.774736 2.338626 2.638363 3.121448 3.773440
#>  [17] 3.428166 2.339671 4.246272 3.793167 2.010226 3.679782 4.659620 3.136955
#>  [25] 4.500887 2.881286 3.579416 2.914089 2.702323 3.187336 2.710294 3.925128
#>  [33] 2.842001 3.850498 3.401736 3.232860 3.830096 2.612098 4.115461 3.282594
#>  [41] 2.500853 1.939628 1.618365 1.580582 1.176094 2.379211 2.797775 4.021713
#>  [49] 1.850940 4.032163 2.891425 2.178024 2.461045 2.958014 2.076580 3.747862
#>  [57] 2.850373 3.049696 3.204424 2.976112 2.488772 3.322627 3.430324 2.589760
#>  [65] 2.962779 3.249525 2.677650 3.516631 2.942810 2.961525 2.653683 2.650001
#>  [73] 3.454725 3.986680 2.209140 3.960920 2.972560 3.072318 4.237524 2.493371
#>  [81] 4.119177 2.244684 3.355303 3.188429 4.354805 3.668772 4.003375 2.648060
#>  [89] 2.418492 3.427322 1.947672 3.274953 3.411454 2.648395 3.341783 3.900536
#>  [97] 3.290752 3.163334 2.143457 2.099593
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
#> W = 0.77406, p-value = 2.327e-07
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
#>  [1] 2.2189061 1.3250373 3.9945872 1.6060942 1.4834671 1.1892529 1.0654585
#>  [8] 0.9248985 1.8300294 0.9646850 0.9195319 1.0537544 1.1838149 1.1353442
#> [15] 1.0103690 1.0430118 1.0992026 3.0531567 1.1951302 1.3235974 6.8014193
#> [22] 2.9939775 1.1757258 3.1916608 3.8912089 2.8930487 5.3448837 1.1788844
#> [29] 2.6755254 1.2240797 3.0051139 6.7565931 1.0054198 0.9630585 6.8617694
#> [36] 5.4956056 6.1273193 1.7995962 1.1231441 1.5584474 1.1777885 6.3141205
#> [43] 3.3191766 0.8435798 6.1855065 2.7988081 4.9376299 0.9374449 1.1420309
#> [50] 1.2231743
#> 
 # Plot a histogram of the Mahalanobis distances
 hist(out$D)

```
