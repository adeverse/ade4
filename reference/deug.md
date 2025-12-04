# Exam marks for some students

This data set gives the exam results of 104 students in the second year
of a French University onto 9 subjects.

## Usage

``` r
data(deug)
```

## Format

`deug` is a list of three components.

- tab:

  is a data frame with 104 students and 9 subjects : Algebra, Analysis,
  Proba, Informatic, Economy, Option1, Option2, English, Sport.

- result:

  is a factor of 104 components giving the final exam levels (A+, A, B,
  B-, C-, D).

- cent:

  is a vector of required marks by subject to get exactly 10/20 with a
  coefficient.

## Source

University of Lyon 1

## Examples

``` r
data(deug)
# decentred PCA
pca1 <- dudi.pca(deug$tab, scal = FALSE, center = deug$cent, scan = FALSE)
  
if(adegraphicsLoaded()) {
  g1 <- s.class(pca1$li, deug$result, plot = FALSE)
  g2 <- s.arrow(40 * pca1$c1, plot = FALSE)
  G <- superpose(g1, g2, plot = TRUE)
  
} else {
  s.class(pca1$li, deug$result)
  s.arrow(40 * pca1$c1, add.plot = TRUE)
}
```
