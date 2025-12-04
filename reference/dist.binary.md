# Computation of Distance Matrices for Binary Data

computes for binary data some distance matrice.

## Usage

``` r
dist.binary(df, method = NULL, diag = FALSE, upper = FALSE)
```

## Arguments

- df:

  a matrix or a data frame with positive or null numeric values. Used
  with `as.matrix(1 * (df > 0))`

- method:

  an integer between 1 and 10 . If NULL the choice is made with a
  console message. See details

- diag:

  a logical value indicating whether the diagonal of the distance matrix
  should be printed by \`print.dist'

- upper:

  a logical value indicating whether the upper triangle of the distance
  matrix should be printed by \`print.dist'

## Details

Let be the contingency table of binary data such as \\n\_{11} = a\\,
\\n\_{10} = b\\, \\n\_{01} = c\\ and \\n\_{00} = d\\. All these
distances are of type \\d=\sqrt{1-s}\\ with *s* a similarity
coefficient.

- 1 = Jaccard index (1901):

  S3 coefficient of Gower & Legendre \\s_1 = \frac{a}{a+b+c}\\

- 2 = Simple matching coefficient of Sokal & Michener (1958):

  S4 coefficient of Gower & Legendre \\s_2 =\frac{a+d}{a+b+c+d}\\

- 3 = Sokal & Sneath(1963):

  S5 coefficient of Gower & Legendre \\s_3 =\frac{a}{a+2(b+c)}\\

- 4 = Rogers & Tanimoto (1960):

  S6 coefficient of Gower & Legendre \\s_4 =\frac{a+d}{(a+2(b+c)+d)}\\

- 5 = Dice (1945) or Sorensen (1948):

  S7 coefficient of Gower & Legendre \\s_5 =\frac{2a}{2a+b+c}\\

- 6 = Hamann coefficient:

  S9 index of Gower & Legendre (1986) \\s_6 =\frac{a-(b+c)+d}{a+b+c+d}\\

- 7 = Ochiai (1957):

  S12 coefficient of Gower & Legendre \\s_7
  =\frac{a}{\sqrt{(a+b)(a+c)}}\\

- 8 = Sokal & Sneath (1963):

  S13 coefficient of Gower & Legendre \\s_8
  =\frac{ad}{\sqrt{(a+b)(a+c)(d+b)(d+c)}}\\

- 9 = Phi of Pearson:

  S14 coefficient of Gower & Legendre \\s_9
  =\frac{ad-bc}{\sqrt{(a+b)(a+c)(b+d)(d+c)}}\\

- 10 = S2 coefficient of Gower & Legendre:

  \\s_1 = \frac{a}{a+b+c+d}\\

## Value

returns a distance matrix of class `dist` between the rows of the data
frame

## References

Gower, J.C. and Legendre, P. (1986) Metric and Euclidean properties of
dissimilarity coefficients. *Journal of Classification*, **3**, 5–48.

## Author

Daniel Chessel  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
data(aviurba)
for (i in 1:10) {
    d <- dist.binary(aviurba$fau, method = i)
    cat(attr(d, "method"), is.euclid(d), "\n")}
#> JACCARD S3 TRUE 
#> SOKAL & MICHENER S4 TRUE 
#> SOKAL & SNEATH S5 TRUE 
#> ROGERS & TANIMOTO S6 TRUE 
#> CZEKANOWSKI S7 TRUE 
#> GOWER & LEGENDRE S9 TRUE 
#> OCHIAI S12 TRUE 
#> SOKAL & SNEATH S13 TRUE 
#> Phi of PEARSON S14 TRUE 
#> GOWER & LEGENDRE S2 TRUE 
```
