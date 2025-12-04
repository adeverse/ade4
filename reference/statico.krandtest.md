# Monte-Carlo test on a Statico analysis (in C).

Performs the series of Monte-Carlo coinertia tests of a Statico analysis
(one for each couple of tables).

## Usage

``` r
statico.krandtest(KTX, KTY, nrepet = 999, ...)
```

## Arguments

- KTX:

  an objet of class ktab containing the environmental data

- KTY:

  an objet of class ktab containing the species data

- nrepet:

  the number of permutations

- ...:

  further arguments passed to or from other methods

## Details

This function takes 2 ktabs and does a coinertia analysis with
[coinertia](coinertia.md) on each pair of tables. It then uses the
[randtest](randtest.md) function to do a permutation test on each of
these coinertia analyses.

## Value

krandtest, a list of randtest objects. See [krandtest](krandtest.md)

## References

Thioulouse J. (2011). Simultaneous analysis of a sequence of paired
ecological tables: a comparison of several methods. *Annals of Applied
Statistics*, **5**, 2300-2325.

## Author

Jean Thioulouse <jean.thioulouse@univ-lyon1.fr>

## WARNING

IMPORTANT : KTX and KTY must have the same k-tables structure, the same
number of columns, and the same column weights.

## Examples

``` r
data(meau)
wit1 <- withinpca(meau$env, meau$design$season, scan = FALSE, scal = "total")
spepca <- dudi.pca(meau$spe, scale = FALSE, scan = FALSE, nf = 2)
wit2 <- wca(spepca, meau$design$season, scan = FALSE, nf = 2)
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
kta2 <- ktab.within(wit2, colnames = rep(c("S1","S2","S3","S4","S5","S6"), 4))
statico1 <- statico(kta1, kta2, scan = FALSE)
kr1 <- statico.krandtest(kta1, kta2)
plot(kr1)
```
