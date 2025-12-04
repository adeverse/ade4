# Within-Class Analysis

Outputs and graphical representations of the results of a within-class
analysis.

## Usage

``` r
# S3 method for class 'within'
plot(x, xax = 1, yax = 2, ...) 
# S3 method for class 'within'
print(x, ...)
# S3 method for class 'witcoi'
plot(x, xax = 1, yax = 2, ...)
# S3 method for class 'witcoi'
print(x, ...)
# S3 method for class 'within'
summary(object, ...)
```

## Arguments

- x,object:

  an object of class `within` or `witcoi`

- xax:

  the column index for the x-axis

- yax:

  the column index for the y-axis

- ...:

  further arguments passed to or from other methods

## References

Benzécri, J. P. (1983) Analyse de l'inertie intra-classe par l'analyse
d'un tableau de correspondances. *Les Cahiers de l'Analyse des données*,
**8**, 351–358.  
  
Dolédec, S. and Chessel, D. (1987) Rythmes saisonniers et composantes
stationnelles en milieu aquatique I- Description d'un plan
d'observations complet par projection de variables. *Acta Oecologica,
Oecologia Generalis*, **8**, 3, 403–426.

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## See also

[`wca.dudi`](wca.md), [`wca.coinertia`](wca.coinertia.md)

## Examples

``` r
data(meaudret)
pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 4)
wit1 <- wca(pca1, meaudret$design$site, scan = FALSE, nf = 2)

if(adegraphicsLoaded()) {
  g1 <- s.traject(pca1$li, meaudret$design$site, psub.text = "Principal Component Analysis", 
    plines.lty = 1:length(levels(meaudret$design$site)), plot = FALSE)
  g2 <- s.traject(wit1$li, meaudret$design$site, psub.text = 
    "Within site Principal Component Analysis", 
    plines.lty = 1:length(levels(meaudret$design$site)), plot = FALSE)
  g3 <- s.corcircle (wit1$as, plot = FALSE)
  G <- ADEgS(list(g1, g2, g3), layout = c(2, 2))
  
} else {
  par(mfrow = c(2, 2))
  s.traject(pca1$li, meaudret$design$site, sub = "Principal Component Analysis", csub = 1.5)
  s.traject(wit1$li, meaudret$design$site, sub = "Within site Principal Component Analysis", 
    csub = 1.5)
  s.corcircle (wit1$as)
  par(mfrow = c(1, 1))
}


plot(wit1)
#> Error in s.arrow(dfxy = wit1$c1, xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, psub = list(text = "Loadings"), plabels = list(        cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
