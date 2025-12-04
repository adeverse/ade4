# Between-Class Analysis

Outputs and graphical representations of the results of a between-class
analysis.

## Usage

``` r
# S3 method for class 'between'
plot(x, xax = 1, yax = 2, ...) 
# S3 method for class 'between'
print(x, ...)
# S3 method for class 'betcoi'
plot(x, xax = 1, yax = 2, ...)
# S3 method for class 'betcoi'
print(x, ...)
# S3 method for class 'between'
summary(object, ...)
```

## Arguments

- x,object:

  an object of class `between` or `betcoi`

- xax, yax:

  the column index of the x-axis and the y-axis

- ...:

  further arguments passed to or from other methods

## References

Dolédec, S. and Chessel, D. (1987) Rythmes saisonniers et composantes
stationnelles en milieu aquatique I- Description d'un plan
d'observations complet par projection de variables. *Acta Oecologica,
Oecologia Generalis*, **8**, 3, 403–426.

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## See also

[`bca.dudi`](bca.md), [`bca.coinertia`](bca.coinertia.md)

## Examples

``` r
data(meaudret)

pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 4)
pca2 <- dudi.pca(meaudret$spe, scal = FALSE, scan = FALSE, nf = 4)
bet1 <- bca(pca1, meaudret$design$site, scan = FALSE, nf = 2)
bet2 <- bca(pca2, meaudret$design$site, scan = FALSE, nf = 2)

if(adegraphicsLoaded()) {
  g1 <- s.class(pca1$li, meaudret$design$site, psub.text = "Principal Component Analysis (env)", 
    plot = FALSE)
  g2 <- s.class(pca2$li, meaudret$design$site, psub.text = "Principal Component Analysis (spe)", 
    plot = FALSE)
  g3 <- s.class(bet1$ls, meaudret$design$site, psub.text = "Between sites PCA (env)", 
    plot = FALSE)
  g4 <- s.class(bet2$ls, meaudret$design$site, psub.text = "Between sites PCA (spe)", 
    plot = FALSE)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  
} else {
  par(mfrow = c(2, 2))
  s.class(pca1$li, meaudret$design$site, sub = "Principal Component Analysis (env)", csub = 1.75)
  s.class(pca2$li, meaudret$design$site, sub = "Principal Component Analysis (spe)", csub = 1.75)
  s.class(bet1$ls, meaudret$design$site, sub = "Between sites PCA (env)", csub = 1.75)
  s.class(bet2$ls, meaudret$design$site, sub = "Between sites PCA (spe)", csub = 1.75)
  par(mfrow = c(1,1))
}


coib <- coinertia(bet1, bet2, scann = FALSE)
plot(coib)
#> Error in s.corcircle(dfxy = coib$aX, xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, psub = list(text = "Unconstrained axes (X)"), pbackground = list(        box = FALSE), plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
