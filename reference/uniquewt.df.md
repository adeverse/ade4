# Elimination of Duplicated Rows in a Array

An utility function to eliminate the duplicated rows in a array.

## Usage

``` r
uniquewt.df(x)
```

## Arguments

- x:

  a data frame which contains duplicated rows

## Value

The function returns a `y` which contains once each duplicated row of
`x`.  
`y` is an attribut 'factor' which gives the number of the row of `y` in
which each row of `x` is found  
`y` is an attribut 'length.class' which gives the number of duplicates
in `x` with an attribut of each row of `y` with an attribut

## Author

Daniel Chessel

## Examples

``` r
data(ecomor)
forsub.r <- uniquewt.df(ecomor$forsub)
attr(forsub.r, "factor")
#>   [1] 1  1  1  2  1  3  3  4  4  4  5  5  4  4  6  6  4  5  7  5  4  4  5  8  1 
#>  [26] 4  6  6  9  5  1  10 4  4  4  5  5  5  4  4  4  4  4  5  4  3  11 12 13 5 
#>  [51] 10 7  4  4  5  5  5  5  4  4  4  7  13 13 13 14 8  7  12 15 5  1  5  5  5 
#>  [76] 5  5  5  9  5  12 5  7  16 7  7  8  12 12 12 12 12 12 12 12 17 18 5  5  5 
#> [101] 5  5  4  19 19 5  5  4  5  5  6  2  1  7  2  2  13 13 20 4  14 21 14 21 14
#> [126] 14 22 22 4 
#> Levels: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
forsub.r[1,]
#>      foliage ground twig bush trunk aerial
#> E033       1      0    0    1     0      0
ecomor$forsub[126,] #idem
#>      foliage ground twig bush trunk aerial
#> E072       0      0    1    0     1      0

dudi.pca(ecomor$forsub, scale = FALSE, scann = FALSE)$eig
#> [1] 0.37533941 0.24104252 0.15616250 0.09072903 0.07514625 0.04457409
# [1] 0.36845 0.24340 0.15855 0.09052 0.07970 0.04490
w1 <- attr(forsub.r, "len.class") / sum(attr(forsub.r,"len.class"))
dudi.pca(forsub.r, row.w = w1, scale = FALSE, scann = FALSE)$eig
#> [1] 0.37533941 0.24104252 0.15616250 0.09072903 0.07514625 0.04457409
# [1] 0.36845 0.24340 0.15855 0.09052 0.07970 0.04490
```
