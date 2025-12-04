# Discriminant Correspondence Analysis

performs a discriminant correspondence analysis.

## Usage

``` r
discrimin.coa(df, fac, scannf = TRUE, nf = 2)
```

## Arguments

- df:

  a data frame containing positive or null values

- fac:

  a factor defining the classes of discriminant analysis

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

## Value

a list of class `discrimin`. See [`discrimin`](discrimin.md)

## References

Perriere, G.,Lobry, J. R. and Thioulouse J. (1996) Correspondence
discriminant analysis: a multivariate method for comparing classes of
protein and nucleic acid sequences. *CABIOS*, **12**, 519–524.  

Perriere, G. and Thioulouse, J. (2003) Use of Correspondence
Discriminant Analysis to predict the subcellular location of bacterial
proteins. *Computer Methods and Programs in Biomedicine*, **70**, 2,
99–105.

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(perthi02)
plot(discrimin.coa(perthi02$tab, perthi02$cla, scan = FALSE))
```
