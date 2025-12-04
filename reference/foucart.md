# K-tables Correspondence Analysis with the same rows and the same columns

K tables have the same rows and the same columns.  
Each table is transformed by P = X/sum(X). The average of P is
computing.  
A correspondence analysis is realized on this average.  
The initial rows and the initial columns are projected in supplementary
elements.

## Usage

``` r
foucart(X, scannf = TRUE, nf = 2)
# S3 method for class 'foucart'
plot(x, xax = 1, yax = 2, clab = 1, csub = 2, 
    possub = "bottomright", ...) 
# S3 method for class 'foucart'
print(x, ...)
```

## Arguments

- X:

  a list of data frame where the row names and the column names are the
  same for each table

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

  

- x:

  an object of class 'foucart'

- xax:

  the column number of the x-axis

- yax:

  the column number of the y-axis

- clab:

  if not NULL, a character size for the labels, used with
  `par("cex")*clab`

- csub:

  a character size for the legend, used with `par("cex")*csub`

- possub:

  a string of characters indicating the sub-title position ("topleft",
  "topright", "bottomleft", "bottomright")

- ...:

  further arguments passed to or from other methods

## Value

`foucart` returns a list of the classes 'dudi', 'coa' and 'foucart'

- call:

  origine

- nf:

  axes-components saved

- rank:

  rank

- blo:

  useful vector

- cw:

  vector: column weights

- lw:

  vector: row weights

- eig:

  vector: eigen values

- tab:

  data.frame: modified array

- li:

  data.frame: row coordinates

- l1:

  data.frame: row normed scores

- co:

  data.frame: column coordinates

- c1:

  data.frame: column normed scores

- Tli:

  data.frame: row coordinates (each table)

- Tco:

  data.frame: col coordinates (each table)

- TL:

  data.frame: factors for Tli

- TC:

  data.frame: factors for Tco

## References

Foucart, T. (1984) *Analyse factorielle de tableaux multiples*, Masson,
Paris.

## Author

Pierre Bady <pierre.bady@univ-lyon1.fr>  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(bf88)
fou1 <- foucart(bf88, scann = FALSE, nf = 3)
fou1
#> Foucart's  COA
#> class: foucart coa dudi
#> $call: foucart(X = bf88, scannf = FALSE, nf = 3)
#> table  number: 6 
#> 
#> $nf: 3 axis-components saved
#> $rank: 3
#> eigen values: 0.5278 0.3591 0.3235
#> blo    vector       6      blocks
#>  vector length mode    content       
#>  $cw    4      numeric column weights
#>  $lw    79     numeric row weights   
#>  $eig   3      numeric eigen values  
#> 
#>  data.frame nrow ncol content             
#>  $tab       79   4    modified array      
#>  $li        79   3    row coordinates     
#>  $l1        79   3    row normed scores   
#>  $co        4    3    column coordinates  
#>  $c1        4    3    column normed scores
#> 
#>      **** Intrastructure ****
#> 
#>  data.frame nrow ncol content                     
#>  $Tli       474  3    row coordinates (each table)
#>  $Tco       24   3    col coordinates (each table)
#>  $TL        474  2    factors for Tli             
#>  $TC        24   2    factors for Tco             
#> 
plot(fou1)
#> Error in s.label(dfxy = fou1$li, xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, psub = list(text = "Rows (Base)"), xlim = c(-1.86402627934217,     1.65117536933363), ylim = c(-1.70842679418408, 1.80677485449171    ), plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)

data(meaudret)
l1 <- split(meaudret$spe, meaudret$design$season)
l1 <- lapply(l1, function(x) 
    {row.names(x) <- paste("Sit",1:5,sep="");x})
fou2 <- foucart(l1, scan = FALSE)

if(adegraphicsLoaded()) {
  kplot(fou2, row.plabels.cex = 2)
} else {
  kplot(fou2, clab.r = 2)
}
#> Error in s.label(dfxy = fou2$Tli, facets = fou2$TL[, 1], xax = 1, yax = 2,     plot = FALSE, storeData = TRUE, pos = -3, plabels = list(        cex = 1), xlim = c(-1.44332717078107, 1.56353854303784    ), ylim = c(-1.54372648934993, 1.46313922446898), plabels = list(        cex = 1.25), clab = list(r = 2)): non convenient selection for dfxy (can not be converted to dataframe)
```
