# Partial Triadic Analysis of a K-tables

performs a partial triadic analysis of a K-tables, using an object of
class `ktab`.

## Usage

``` r
pta(X, scannf = TRUE, nf = 2)
# S3 method for class 'pta'
plot(x, xax = 1, yax = 2, option = 1:4, ...)
# S3 method for class 'pta'
print(x, ...)
```

## Arguments

- X:

  an object of class `ktab` where the arrays have 1) the same
  dimensions 2) the same names for columns 3) the same column weightings

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

- x:

  an object of class 'pta'

- xax, yax:

  the numbers of the x-axis and the y-axis

- option:

  an integer between 1 and 4, otherwise the 4 components of the plot are
  displayed

- ...:

  further arguments passed to or from other methods

## Value

returns a list of class 'pta', sub-class of 'dudi' containing :

- RV:

  a matrix with the all RV coefficients

- RV.eig:

  a numeric vector with the all eigenvalues (interstructure)

- RV.coo:

  a data frame with the scores of the arrays

- tab.names:

  a vector of characters with the array names

- nf:

  an integer indicating the number of kept axes

- rank:

  an integer indicating the rank of the studied matrix

- tabw:

  a numeric vector with the array weights

- cw:

  a numeric vector with the column weights

- lw:

  a numeric vector with the row weights

- eig:

  a numeric vector with the all eigenvalues (compromis)

- cos2:

  a numeric vector with the \\\cos^2\\ between compromise and arrays

- tab:

  a data frame with the modified array

- li:

  a data frame with the row coordinates

- l1:

  a data frame with the row normed scores

- co:

  a data frame with the column coordinates

- c1:

  a data frame with the column normed scores

- Tli:

  a data frame with the row coordinates (each table)

- Tco:

  a data frame with the column coordinates (each table)

- Tcomp:

  a data frame with the principal components (each table)

- Tax:

  a data frame with the principal axes (each table)

- TL:

  a data frame with the factors for Tli

- TC:

  a data frame with the factors for Tco

- T4:

  a data frame with the factors for Tax and Tcomp

## References

Blanc, L., Chessel, D. and Dolédec, S. (1998) Etude de la stabilité
temporelle des structures spatiales par Analyse d'une série de tableaux
faunistiques totalement appariés. *Bulletin Français de la Pêche et de
la Pisciculture*, **348**, 1–21.  
  
Thioulouse, J., and D. Chessel. 1987. Les analyses multi-tableaux en
écologie factorielle. I De la typologie d'état à la typologie de
fonctionnement par l'analyse triadique. *Acta Oecologica, Oecologia
Generalis*, **8**, 463–480.

## Author

Pierre Bady <pierre.bady@univ-lyon1.fr>  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(meaudret)
wit1 <- withinpca(meaudret$env, meaudret$design$season, scan = FALSE, scal = "partial")
kta1 <- ktab.within(wit1, colnames = rep(c("S1", "S2", "S3", "S4", "S5"), 4))
kta2 <- t(kta1)
pta1 <- pta(kta2, scann = FALSE)
pta1
#> Partial Triadic Analysis
#> class:pta dudi 
#> table number: 4 
#> row number: 5   column number: 9 
#> 
#>      **** Interstructure ****
#> 
#> eigen values: 2.812 0.7541 0.2537 0.18
#>  $RV       matrix       4      4     RV coefficients
#>  $RV.eig   vector       4       eigenvalues
#>  $RV.coo   data.frame   4      4    array scores
#>  $tab.names    vector       4        array names
#> 
#>       **** Compromise ****
#> 
#> eigen values: 17.2 7.298 0.6099 0.2008
#> 
#>  $nf: 2 axis-components saved
#>  $rank: 4 
#> 
#>  vector length mode    content                               
#>  $tabw  4      numeric array weights                         
#>  $cw    9      numeric column weights                        
#>  $lw    5      numeric row weights                           
#>  $eig   4      numeric eigen values                          
#>  $cos2  4      numeric cosine^2 between compromise and arrays
#> 
#>  data.frame nrow ncol content             
#>  $tab       5    9    modified array      
#>  $li        5    2    row coordinates     
#>  $l1        5    2    row normed scores   
#>  $co        9    2    column coordinates  
#>  $c1        9    2    column normed scores
#> 
#>      **** Intrastructure ****
#> 
#>  data.frame nrow ncol content                          
#>  $Tli       20   2    row coordinates (each table)     
#>  $Tco       36   2    col coordinates (each table)     
#>  $Tcomp     16   2    principal components (each table)
#>  $Tax       16   2    principal axis (each table)      
#>  $TL        20   2    factors for Tli                  
#>  $TC        36   2    factors for Tco                  
#>  $T4        16   2    factors for Tax Tcomp            
#> 
plot(pta1)
#> Error in s.corcircle(dfxy = pta1$RV.coo, xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "Interstructure",         position = "topleft"), pbackground = list(box = FALSE),     plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
