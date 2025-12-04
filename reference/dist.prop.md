# Computation of Distance Matrices of Percentage Data

computes for percentage data some distance matrices.

## Usage

``` r
dist.prop(df, method = NULL, diag = FALSE, upper = FALSE)
```

## Arguments

- df:

  a data frame containing only positive or null values, used as row
  percentages

- method:

  an integer between 1 and 5. If NULL the choice is made with a console
  message. See details

- diag:

  a logical value indicating whether the diagonal of the distance matrix
  should be printed by \`print.dist'

- upper:

  a logical value indicating whether the upper triangle of the distance
  matrix should be printed by \`print.dist'

## Details

- 1 = Manly:

  \\d_1=\frac{1}{2} \sum\_{i=1}^{K}{\|{p_i-q_i}\|}\\

- 2 = Overlap index Manly:

  \\d_2=1-\frac{\sum\_{i=1}^{K}{p_i
  q_i}}{\sqrt{\sum\_{i=1}^{K}{p_i^2}}{\sqrt{\sum\_{i=1}^{K}{q_i^2}}}}\\

- 3 = Rogers 1972 (one locus):

  \\d_3=\sqrt{\frac{1}{2} \sum\_{i=1}^{K}{(p_i-q_i)^2}}\\

- 4 = Nei 1972 (one locus):

  \\d_4=\ln{\frac{\sum\_{i=1}^{K}{p_i
  q_i}}{\sqrt{\sum\_{i=1}^{K}{p_i^2}}{\sqrt{\sum\_{i=1}^{K}{q_i^2}}}}}\\

- 5 = Edwards 1971 (one locus):

  \\d_5=\sqrt{1-\sum\_{i=1}^{K}{\sqrt{p_1 q_i}}}\\

## Value

returns a distance matrix, object of class `dist`

## References

Edwards, A. W. F. (1971) Distance between populations on the basis of
gene frequencies. *Biometrics*, **27**, 873–881.

Manly, B. F. (1994) *Multivariate Statistical Methods. A primer.*,
Second edition. Chapman & Hall, London.

Nei, M. (1972) Genetic distances between populations. *The American
Naturalist*, **106**, 283–292.

## Author

Daniel Chessel  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
data(microsatt)
w <- microsatt$tab[1:microsatt$loci.eff[1]]

if(adegraphicsLoaded()) {
  g1 <- scatter(dudi.pco(lingoes(dist.prop(w, 1)), scann = FALSE), plot = FALSE)
  g2 <- scatter(dudi.pco(lingoes(dist.prop(w, 2)), scann = FALSE), plot = FALSE)
  g3 <- scatter(dudi.pco(dist.prop(w, 3), scann = FALSE), plot = FALSE)
  g4 <- scatter(dudi.pco(lingoes(dist.prop(w, 4)), scann = FALSE), plot = FALSE)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  
} else {
  par(mfrow = c(2, 2))
  scatter(dudi.pco(lingoes(dist.prop(w, 1)), scann = FALSE))
  scatter(dudi.pco(lingoes(dist.prop(w, 2)), scann = FALSE))
  scatter(dudi.pco(dist.prop(w, 3), scann = FALSE))
  scatter(dudi.pco(lingoes(dist.prop(w, 4)), scann = FALSE))
  par(mfrow = c(1, 1))
}
#> Error in s.label(dfxy = dudi.pco(lingoes(dist.prop(w, 1)), scann = FALSE)$li,     xax = 1, yax = 2, plot = FALSE, storeData = TRUE, pos = -3): non convenient selection for dfxy (can not be converted to dataframe)
```
