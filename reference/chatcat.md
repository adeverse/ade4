# Qualitative Weighted Variables

This data set gives the age, the fecundity and the number of litters for
26 groups of cats.

## Usage

``` r
data(chatcat)
```

## Format

`chatcat` is a list of two objects :

- tab:

  is a data frame with 3 factors (age, feco, nport).

- eff:

  is a vector of numbers.

## Details

One row of `tab` corresponds to one group of cats.  
The value in `eff` is the number of cats in this group.

## Source

Pontier, D. (1984) *Contribution à la biologie et à la génétique des
populations de chats domestiques (Felis catus).* Thèse de 3ème cycle.
Université Lyon 1, p. 67.

## Examples

``` r
data(chatcat)
summary(chatcat$tab)
#>   age       feco    nport 
#>  1  :5   1-2  : 3   1: 9  
#>  2-3:6   3-6  :10   2:17  
#>  4-5:5   7-8  : 6         
#>  6-7:5   9-12 : 5         
#>  >=8:5   13-14: 2         
w <- acm.disjonctif(chatcat$tab) #  Disjonctive table
names(w) <- c(paste("A", 1:5, sep = ""), paste("B", 1:5, sep = ""), 
    paste("C", 1:2, sep = ""))
w <- t(w*chatcat$num) %*% as.matrix(w)
w <- data.frame(w)
w # BURT table
#>    A1 A2 A3 A4 A5 B1 B2 B3 B4 B5 C1 C2
#> A1 32  0  0  0  0  7 23  1  1  0 25  7
#> A2  0 47  0  0  0  3 24 14  4  2 17 30
#> A3  0  0 18  0  0  0  4  8  6  0  4 14
#> A4  0  0  0 19  0  0  8  5  4  2  3 16
#> A5  0  0  0  0 18  2  6  5  5  0  5 13
#> B1  7  3  0  0  2 12  0  0  0  0 12  0
#> B2 23 24  4  8  6  0 65  0  0  0 41 24
#> B3  1 14  8  5  5  0  0 33  0  0  1 32
#> B4  1  4  6  4  5  0  0  0 20  0  0 20
#> B5  0  2  0  2  0  0  0  0  0  4  0  4
#> C1 25 17  4  3  5 12 41  1  0  0 54  0
#> C2  7 30 14 16 13  0 24 32 20  4  0 80
```
