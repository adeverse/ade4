# the class of objects 'ktab' (K-tables)

an object of class `ktab` is a list of data frames with the same
row.names in common.  
a list of class 'ktab' contains moreover :

- blo:

  : the vector of the numbers of columns for each table

- lw:

  : the vector of the row weightings in common for all tables

- cw:

  : the vector of the column weightings

- TL:

  : a data frame of two components to manage the parameter positions
  associated with the rows of tables

- TC:

  : a data frame of two components to manage the parameter positions
  associated with the columns of tables

- T4:

  : a data frame of two components to manage the parameter positions of
  4 components associated to an array

## Usage

``` r
# S3 method for class 'ktab'
c(...)
# S3 method for class 'ktab'
x[i, j, k]
is.ktab(x)
# S3 method for class 'ktab'
t(x)
# S3 method for class 'ktab'
row.names(x)
# S3 method for class 'ktab'
col.names(x)
tab.names(x)
col.names(x)
ktab.util.names(x)
```

## Arguments

- x:

  an object of the class `ktab`

- ...:

  a sequence of objects of the class `ktab`

- i,j,k:

  elements to extract (integer or empty): index of tables (i), rows (j)
  and columns (k)

## Details

A 'ktab' object can be created with :  
a list of data frame : [`ktab.list.df`](ktab.list.df.md)  
a list of `dudi` objects : [`ktab.list.dudi`](ktab.list.dudi.md)  
a data.frame : [`ktab.data.frame`](ktab.data.frame.md)  
an object `within` : [`ktab.within`](ktab.within.md)  
a couple of `ktab`s : [`ktab.match2ktabs`](ktab.match2ktabs.md)  

## Value

`c.ktab` returns an object `ktab`. It concatenates K-tables with the
same rows in common.  
`t.ktab` returns an object `ktab`. It permutes each data frame into a
K-tables. All tables have the same column names and the same column
weightings (a data cube).  
`"["` returns an object `ktab`. It allows to select some arrays in a
K-tables.  
`is.ktab` returns TRUE if x is a K-tables.  
`row.names` returns the vector of the row names common with all the
tables of a K-tables and allowes to modifie them.  
`col.names` returns the vector of the column names of a K-tables and
allowes to modifie them.  
`tab.names` returns the vector of the array names of a K-tables and
allowes to modifie them.  
`ktab.util.names` is a useful function.

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr> Stéphane Dray
<stephane.dray@univ-lyon1.fr>

## Examples

``` r
data(friday87)
wfri <- data.frame(scale(friday87$fau, scal = FALSE))
wfri <- ktab.data.frame(wfri, friday87$fau.blo)
wfri[2:4, 1:5, 1:3]
#> class: ktab 
#> 
#> tab number:   3 
#>   data.frame    nrow ncol
#> 1 Odonata       5    3   
#> 2 Trichoptera   5    3   
#> 3 Ephemeroptera 5    3   
#> 
#>   vector length mode    content       
#> 4 $lw    5      numeric row weigths   
#> 5 $cw    9      numeric column weights
#> 6 $blo   3      numeric column numbers
#> 7 $tabw  0      NULL    array weights 
#> 
#>    data.frame nrow ncol content                         
#> 8  $TL        15   2    Factors Table number Line number
#> 9  $TC        9    2    Factors Table number Col number 
#> 10 $T4        12   2    Factors Table number 1234       
#> 
#> 11 $call: `[.ktab`(x = wfri, i = 2:4, j = 1:5, k = 1:3)
#> 
#> names :
#> Odonata : B1 B2 B3 
#> Trichoptera : C1 C2 C3 
#> Ephemeroptera : D1 D2 D3 
#> 
#> Col weigths :
#> Odonata : 1 1 1 
#> Trichoptera : 1 1 1 
#> Ephemeroptera : 1 1 1 
#> 
#> Row weigths :
#> 0.2 0.2 0.2 0.2 0.2
c(wfri[2:4], wfri[5])
#> class: ktab 
#> 
#> tab number:   4 
#>   data.frame    nrow ncol
#> 1 Odonata       16   7   
#> 2 Trichoptera   16   13  
#> 3 Ephemeroptera 16   4   
#> 4 Coleoptera    16   13  
#> 
#>   vector length mode    content       
#> 5 $lw    16     numeric row weigths   
#> 6 $cw    37     numeric column weights
#> 7 $blo   4      numeric column numbers
#> 8 $tabw  0      NULL    array weights 
#> 
#>    data.frame nrow ncol content                         
#> 9  $TL        64   2    Factors Table number Line number
#> 10 $TC        37   2    Factors Table number Col number 
#> 11 $T4        16   2    Factors Table number 1234       
#> 
#> 12 $call: c.ktab(wfri[2:4], wfri[5])
#> 
#> names :
#> Odonata : B1 B2 B3 B4 B5 B6 B7 
#> Trichoptera : C1 C2 C3 C4 C5 C6 C7 C8 C9 Ca Cb Cc Cd 
#> Ephemeroptera : D1 D2 D3 D4 
#> Coleoptera : E1 E2 E3 E4 E5 E6 E7 E8 E9 Ea Eb Ec Ed 
#> 
#> Col weigths :
#> Odonata : 1 1 1 1 1 1 1 
#> Trichoptera : 1 1 1 1 1 1 1 1 1 1 1 1 1 
#> Ephemeroptera : 1 1 1 1 
#> Coleoptera : 1 1 1 1 1 1 1 1 1 1 1 1 1 
#> 
#> Row weigths :
#> 0.0625 0.0625 0.0625 0.0625 0.0625 0.0625 0.0625 0.0625 0.0625 0.0625 0.0625 0.0625 0.0625 0.0625 0.0625 0.0625

data(meaudret)
wit1 <- withinpca(meaudret$env, meaudret$design$season, scan = FALSE, 
    scal = "partial")
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5"), 4))
kta2 <- t(kta1)

if(adegraphicsLoaded()) {
  kplot(sepan(kta2), row.plab.cex = 1.5, col.plab.cex = 0.75)
} else {
  kplot(sepan(kta2), clab.r = 1.5, clab.c = 0.75)
}
#> Error in s.label(dfxy = sepan(kta2)$Li, labels = sepan(kta2)$TL[, 2],     facets = sepan(kta2)$TL[, 1], xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(position = "bottomright"),     samelimits = FALSE, clab = list(r = 1.5, c = 0.75)): non convenient selection for dfxy (can not be converted to dataframe)
```
