# Double principal coordinate analysis

Performs a double principal coordinate analysis

## Usage

``` r
dpcoa(df, dis = NULL, scannf = TRUE, nf = 2, full = FALSE, tol = 1e-07,
RaoDecomp = TRUE)
# S3 method for class 'dpcoa'
plot(x, xax = 1, yax = 2, ...)
# S3 method for class 'dpcoa'
print (x, ...)
# S3 method for class 'dpcoa'
summary (object, ...)
```

## Arguments

- df:

  a data frame with samples as rows and categories (i.e. species) as
  columns and abundance or presence-absence as entries. Previous
  releases of ade4 (\<=1.6-2) considered the transposed matrix as
  argument.

- dis:

  an object of class `dist` containing the distances between the
  categories.

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- RaoDecomp:

  a logical value indicating whether Rao diversity decomposition should
  be performed

- nf:

  if scannf is FALSE, an integer indicating the number of kept axes

- full:

  a logical value indicating whether all non null eigenvalues should be
  kept

- tol:

  a tolerance threshold for null eigenvalues (a value less than tol
  times the first one is considered as null)

- x, object:

  an object of class `dpcoa`

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

- ...:

  `...` further arguments passed to or from other methods

## Value

Returns a list of class `dpcoa` containing:

- call:

  call

- nf:

  a numeric value indicating the number of kept axes

- dw:

  a numeric vector containing the weights of the elements (was `w1` in
  previous releases of ade4)

- lw:

  a numeric vector containing the weights of the samples (was `w2` in
  previous releases of ade4)

- eig:

  a numeric vector with all the eigenvalues

- RaoDiv:

  a numeric vector containing diversities within samples

- RaoDis:

  an object of class `dist` containing the dissimilarities between
  samples

- RaoDecodiv:

  a data frame with the decomposition of the diversity

- dls:

  a data frame with the coordinates of the elements (was `l1` in
  previous releases of ade4)

- li:

  a data frame with the coordinates of the samples (was `l2` in previous
  releases of ade4)

- c1:

  a data frame with the scores of the principal axes of the elements

## References

Pavoine, S., Dufour, A.B. and Chessel, D. (2004) From dissimilarities
among species to dissimilarities among communities: a double principal
coordinate analysis. *Journal of Theoretical Biology*, **228**, 523–537.

## Author

Daniel Chessel  
Sandrine Pavoine <pavoine@mnhn.fr>  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
data(humDNAm)
dpcoahum <- dpcoa(data.frame(t(humDNAm$samples)), sqrt(humDNAm$distances), scan = FALSE, nf = 2)
dpcoahum
#> Double principal coordinate analysis
#> call: dpcoa(df = data.frame(t(humDNAm$samples)), dis = sqrt(humDNAm$distances), 
#>     scannf = FALSE, nf = 2)
#> class: dpcoa 
#> 
#> $nf (axis saved) : 2
#> $rank:  9
#> 
#> eigen values: 0.1018 0.01035 0.006281 0.005602 0.003179 ...
#> 
#>   vector length mode    content           
#> 1 $dw    56     numeric category weights  
#> 2 $lw    10     numeric collection weights
#> 3 $eig   9      numeric eigen values      
#> 
#>   data.frame nrow ncol content                                       
#> 1 $dls       56   2    coordinates of the categories                 
#> 2 $li        10   2    coordinates of the collections                
#> 3 $c1        34   2    scores of the principal axes of the categories
if(adegraphicsLoaded()) {
  g1 <- plot(dpcoahum)
} else {
  plot(dpcoahum)
}
#> Error in s.corcircle(dfxy = dpcoahum$c1, xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "Principal axes",         position = "topleft"), pbackground = list(box = FALSE),     plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
  
if (FALSE) { # \dontrun{
data(ecomor)
dtaxo <- dist.taxo(ecomor$taxo)
dpcoaeco <- dpcoa(data.frame(t(ecomor$habitat)), dtaxo, scan = FALSE, nf = 2)
dpcoaeco

if(adegraphicsLoaded()) {
  g1 <- plot(dpcoaeco)
} else {
  plot(dpcoaeco)
}
} # }
```
