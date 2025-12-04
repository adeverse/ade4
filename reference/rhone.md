# Physico-Chemistry Data

This data set gives for 39 water samples a physico-chemical description
with the number of sample date and the flows of three tributaries.

## Usage

``` r
data(rhone)
```

## Format

`rhone` is a list of 3 components.

- tab:

  is a data frame with 39 water samples and 15 physico-chemical
  variables.

- date:

  is a vector of the sample date (in days).

- disch:

  is a data frame with 39 water samples and the flows of the three
  tributaries.

## Source

Carrel, G., Barthelemy, D., Auda, Y. and Chessel, D. (1986) Approche
graphique de l'analyse en composantes principales normée : utilisation
en hydrobiologie. *Acta Oecologica, Oecologia Generalis*, **7**,
189–203.

## Examples

``` r
data(rhone)
pca1 <- dudi.pca(rhone$tab, nf = 2, scann = FALSE)
rh1 <- reconst(pca1, 1)
rh2 <- reconst(pca1, 2)
par(mfrow = c(4,4))
par(mar = c(2.6,2.6,1.1,1.1))
for (i in 1:15) {
    plot(rhone$date, rhone$tab[,i])
    lines(rhone$date, rh1[,i], lwd = 2)
    lines(rhone$date, rh2[,i])
    ade4:::scatterutil.sub(names(rhone$tab)[i], 2, "topright")
}
par(mfrow = c(1,1))
```
