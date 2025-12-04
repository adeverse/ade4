# Principal component analysis with respect to instrumental variables

performs a principal component analysis with respect to instrumental
variables. It includes redundancy analysis (RDA, if `dudi` argument is
created with `dudi.pca`) and canonical correspondence analysis (CCA, if
`dudi` argument is created with `dudi.coa`) as special cases.

## Usage

``` r
pcaiv(dudi, df, scannf = TRUE, nf = 2)
# S3 method for class 'pcaiv'
plot(x, xax = 1, yax = 2, ...) 
# S3 method for class 'pcaiv'
print(x, ...)
# S3 method for class 'pcaiv'
summary(object, ...)
```

## Arguments

- dudi:

  a duality diagram, object of class `dudi`

- df:

  a data frame with the same rows

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

  

- x, object:

  an object of class `pcaiv`

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

- ...:

  further arguments passed to or from other methods

## Value

returns an object of class `pcaiv`, sub-class of class `dudi`

- tab:

  a data frame with the modified array (projected variables)

- cw:

  a numeric vector with the column weigths (from `dudi`)

- lw:

  a numeric vector with the row weigths (from `dudi`)

- eig:

  a vector with the all eigenvalues

- rank:

  an integer indicating the rank of the studied matrix

- nf:

  an integer indicating the number of kept axes

- c1:

  a data frame with the Pseudo Principal Axes (PPA)

- li:

  a data frame with the predicted values by X

- co:

  a data frame with the inner products between the CPC and Y

- l1:

  data frame with the Constrained Principal Components (CPC)

- call:

  the matched call

- X:

  a data frame with the explanatory variables

- Y:

  a data frame with the dependant variables

- ls:

  a data frame with the projections of lines of `dudi$tab` on PPA

- param:

  a table containing information about contributions of the analyses :
  absolute (1) and cumulative (2) contributions of the decomposition of
  inertia of the dudi object, absolute (3) and cumulative (4) variances
  of the projections, the ration (5) between the cumulative variances of
  the projections (4) and the cumulative contributions (2), the square
  coefficient of correlation (6) and the eigenvalues of the pcaiv (7)

- as:

  a data frame with the Principal axes of `dudi$tab` on PPA

- fa:

  a data frame with the loadings (Constraint Principal Components as
  linear combinations of X

- cor:

  a data frame with the correlations between the CPC and X

## References

Rao, C. R. (1964) The use and interpretation of principal component
analysis in applied research. *Sankhya*, **A 26**, 329–359.  
  
Obadia, J. (1978) L'analyse en composantes explicatives. *Revue de
Statistique Appliquee*, **24**, 5–28.  
  
Lebreton, J. D., Sabatier, R., Banco G. and Bacou A. M. (1991) Principal
component and correspondence analyses with respect to instrumental
variables : an overview of their role in studies of structure-activity
and species- environment relationships. In J. Devillers and W. Karcher,
editors. *Applied Multivariate Analysis in SAR and Environmental
Studies*, Kluwer Academic Publishers, 85–114.

Ter Braak, C. J. F. (1986) Canonical correspondence analysis : a new
eigenvector technique for multivariate direct gradient analysis.
*Ecology*, **67**, 1167–1179.  
  
Ter Braak, C. J. F. (1987) The analysis of vegetation-environment
relationships by canonical correspondence analysis. *Vegetatio*, **69**,
69–77.  
  
Chessel, D., Lebreton J. D. and Yoccoz N. (1987) Propriétés de l'analyse
canonique des correspondances. Une utilisation en hydrobiologie. *Revue
de Statistique Appliquée*, **35**, 55–72.  
  

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
# example for the pcaiv
data(rhone)
pca1 <- dudi.pca(rhone$tab, scan = FALSE, nf = 3)
iv1 <- pcaiv(pca1, rhone$disch, scan = FALSE)
summary(iv1)
#> Principal component analysis with instrumental variables
#> 
#> Class: pcaiv dudi
#> Call: pcaiv(dudi = pca1, df = rhone$disch, scannf = FALSE)
#> 
#> Total inertia: 7.543
#> 
#> Eigenvalues:
#>     Ax1     Ax2     Ax3 
#>  3.7031  3.5381  0.3015 
#> 
#> Projected inertia (%):
#>     Ax1     Ax2     Ax3 
#>  49.095  46.907   3.998 
#> 
#> Cumulative projected inertia (%):
#>     Ax1   Ax1:2   Ax1:3 
#>    49.1    96.0   100.0 
#> 
#> Total unconstrained inertia (pca1): 15
#> 
#> Inertia of pca1 explained by rhone$disch (%): 50.28
#> 
#> Decomposition per axis:
#>   iner inercum inerC inercumC ratio    R2 lambda
#> 1 6.27    6.27  5.52     5.52 0.879 0.671   3.70
#> 2 4.14   10.42  4.74    10.25 0.984 0.747   3.54
plot(iv1)
#> Error in s.arrow(dfxy = na.omit(iv1$fa), xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "X loadings"),     plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)

# example for the caiv
data(rpjdl)
millog <- log(rpjdl$mil + 1)
coa1 <- dudi.coa(rpjdl$fau, scann = FALSE)
caiv1 <- pcaiv(coa1, millog, scan = FALSE)

if(adegraphicsLoaded()) {
  G1 <- plot(caiv1)
  
  # analysis with c1 - as - li -ls
  # projections of inertia axes on PCAIV axes
  G2 <- s.corcircle(caiv1$as)
  
  # Species positions
  g31 <- s.label(caiv1$c1, xax = 2, yax = 1, plab.cex = 0.5, xlim = c(-4, 4), plot = FALSE)
  # Sites positions at the weighted mean of present species
  g32 <- s.label(caiv1$ls, xax = 2, yax = 1, plab.cex = 0, plot = FALSE)
  G3 <- superpose(g31, g32, plot = TRUE)
  
  # Prediction of the positions by regression on environmental variables
  G4 <- s.match(caiv1$ls, caiv1$li, xax = 2, yax = 1, plab.cex = 0.5)
  
  # analysis with fa - l1 - co -cor
  # canonical weights giving unit variance combinations
  G5 <- s.arrow(caiv1$fa)
  
  # sites position by environmental variables combinations
  # position of species by averaging
  g61 <- s.label(caiv1$l1, xax = 2, yax = 1, plab.cex = 0, ppoi.cex = 1.5, plot = FALSE)
  g62 <- s.label(caiv1$co, xax = 2, yax = 1, plot = FALSE)
  G6 <- superpose(g61, g62, plot = TRUE)
  
  G7 <- s.distri(caiv1$l1, rpjdl$fau, xax = 2, yax = 1, ellipseSize = 0, starSize = 0.33)
  
  # coherence between weights and correlations
  g81 <- s.corcircle(caiv1$cor, xax = 2, yax = 1, plot = FALSE)
  g82 <- s.arrow(caiv1$fa, xax = 2, yax = 1, plot = FALSE)
  G8 <- cbindADEg(g81, g82, plot = TRUE)

} else {
  plot(caiv1)
  
  # analysis with c1 - as - li -ls
  # projections of inertia axes on PCAIV axes
  s.corcircle(caiv1$as)
  
  # Species positions
  s.label(caiv1$c1, 2, 1, clab = 0.5, xlim = c(-4, 4))
  # Sites positions at the weighted mean of present species
  s.label(caiv1$ls, 2, 1, clab = 0, cpoi = 1, add.p = TRUE)
  
  # Prediction of the positions by regression on environmental variables
  s.match(caiv1$ls, caiv1$li, 2, 1, clab = 0.5)
  
  # analysis with fa - l1 - co -cor
  # canonical weights giving unit variance combinations
  s.arrow(caiv1$fa)
  
  # sites position by environmental variables combinations
  # position of species by averaging
  s.label(caiv1$l1, 2, 1, clab = 0, cpoi = 1.5)
  s.label(caiv1$co, 2, 1, add.plot = TRUE)
  
  s.distri(caiv1$l1, rpjdl$fau, 2, 1, cell = 0, csta = 0.33)
  s.label(caiv1$co, 2, 1, clab = 0.75, add.plot = TRUE)
  
  # coherence between weights and correlations
  par(mfrow = c(1, 2))
  s.corcircle(caiv1$cor, 2, 1)
  s.arrow(caiv1$fa, 2, 1)
  par(mfrow = c(1, 1))
}
#> Error in s.arrow(dfxy = na.omit(caiv1$fa), xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "X loadings"),     plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
