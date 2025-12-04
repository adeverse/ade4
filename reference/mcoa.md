# Multiple CO-inertia Analysis

performs a multiple CO-inertia analysis, using an object of class
`ktab`.

## Usage

``` r
mcoa(X, option = c("inertia", "lambda1", "uniform", "internal"), 
    scannf = TRUE, nf = 3, tol = 1e-07)
# S3 method for class 'mcoa'
print(x, ...)
# S3 method for class 'mcoa'
summary(object, ...)
# S3 method for class 'mcoa'
plot(x, xax = 1, yax = 2, eig.bottom = TRUE, ...)
```

## Arguments

- X:

  an object of class `ktab`

- option:

  a string of characters for the weightings of the arrays options :

  "inertia"

  :   weighting of group k by the inverse of the total inertia of the
      array k

  "lambda1"

  :   weighting of group k by the inverse of the first eigenvalue of the
      k analysis

  "uniform"

  :   uniform weighting of groups

  "internal"

  :   weighting included in `X$tabw`

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

- tol:

  a tolerance threshold, an eigenvalue is considered positive if it is
  larger than `-tol*lambda1` where `lambda1` is the largest eigenvalue.

- x, object:

  an object of class 'mcoa'

- ...:

  further arguments passed to or from other methods

- xax, yax:

  the numbers of the x-axis and the y-axis

- eig.bottom:

  a logical value indicating whether the eigenvalues bar plot should be
  added

## Value

mcoa returns a list of class 'mcoa' containing :

- pseudoeig:

  a numeric vector with the all pseudo eigenvalues

- call:

  the call-up order

- nf:

  a numeric value indicating the number of kept axes

- SynVar:

  a data frame with the synthetic scores

- axis:

  a data frame with the co-inertia axes

- Tli:

  a data frame with the co-inertia coordinates

- Tl1:

  a data frame with the co-inertia normed scores

- Tax:

  a data frame with the inertia axes onto co-inertia axis

- Tco:

  a data frame with the column coordinates onto synthetic scores

- TL:

  a data frame with the factors for Tli Tl1

- TC:

  a data frame with the factors for Tco

- T4:

  a data frame with the factors for Tax

- lambda:

  a data frame with the all eigenvalues (computed on the separate
  analyses)

- cov2:

  a numeric vector with the all pseudo eigenvalues (synthetic analysis)

## References

Chessel, D. and Hanafi, M. (1996) Analyses de la co-inertie de K nuages
de points, *Revue de Statistique Appliquée*, **44**, 35–60.

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(friday87)
w1 <- data.frame(scale(friday87$fau, scal = FALSE))
w2 <- ktab.data.frame(w1, friday87$fau.blo, tabnames = friday87$tab.names)
mcoa1 <- mcoa(w2, "lambda1", scan = FALSE)
mcoa1
#> Multiple Co-inertia Analysis
#> list of class mcoa
#> 
#> $pseudoeig: 16 pseudo eigen values
#> 6.459 4.07 1.914 1.644 0.98 ...
#> 
#> $call: mcoa(X = w2, option = "lambda1", scannf = FALSE)
#> 
#> $nf: 3 axis saved
#> 
#>    data.frame nrow ncol content                                 
#> 1  $SynVar    16   3    synthetic scores                        
#> 2  $axis      91   3    co-inertia axis                         
#> 3  $Tli       160  3    co-inertia coordinates                  
#> 4  $Tl1       160  3    co-inertia normed scores                
#> 5  $Tax       40   3    inertia axes onto co-inertia axis       
#> 6  $Tco       91   3    columns onto synthetic scores           
#> 7  $TL        160  2    factors for Tli Tl1                     
#> 8  $TC        91   2    factors for Tco                         
#> 9  $T4        40   2    factors for Tax                         
#> 10 $lambda    10   3    eigen values (separate analysis)        
#> 11 $cov2      10   3    pseudo eigen values (synthetic analysis)
#> other elements: NULL
summary(mcoa1)
#> Multiple Co-inertia Analysis
#> Array number 1 Hemiptera Rows 16 Cols 11 
#>   Iner  Iner+ Var   Var+  cos2  cov2 
#> 1 1     1     0.688 0.688 0.68  0.468
#> 2 0.748 1.748 0.979 1.667 0.82  0.803
#> 3 0.384 2.132 0.356 2.023 0.668 0.238
#> 
#> Array number 2 Odonata Rows 16 Cols 7 
#>   Iner  Iner+ Var   Var+  cos2  cov2 
#> 1 1     1     0.839 0.839 0.853 0.715
#> 2 0.856 1.856 0.873 1.712 0.681 0.594
#> 3 0.573 2.43  0.268 1.979 0.444 0.119
#> 
#> Array number 3 Trichoptera Rows 16 Cols 13 
#>   Iner  Iner+ Var   Var+  cos2  cov2 
#> 1 1     1     0.941 0.941 0.76  0.715
#> 2 0.395 1.395 0.361 1.302 0.715 0.258
#> 3 0.238 1.634 0.176 1.478 0.726 0.128
#> 
#> Array number 4 Ephemeroptera Rows 16 Cols 4 
#>   Iner  Iner+ Var   Var+  cos2  cov2 
#> 1 1     1     0.942 0.942 0.915 0.861
#> 2 0.697 1.697 0.752 1.694 0.53  0.399
#> 3 0.079 1.777 0.035 1.728 0.134 0.005
#> 
#> Array number 5 Coleoptera Rows 16 Cols 13 
#>   Iner  Iner+ Var   Var+  cos2  cov2 
#> 1 1     1     0.691 0.691 0.695 0.481
#> 2 0.683 1.683 0.659 1.351 0.663 0.437
#> 3 0.527 2.21  0.579 1.93  0.804 0.466
#> 
#> Array number 6 Diptera Rows 16 Cols 22 
#>   Iner  Iner+ Var   Var+  cos2  cov2 
#> 1 1     1     0.951 0.951 0.854 0.812
#> 2 0.478 1.478 0.393 1.343 0.584 0.23 
#> 3 0.369 1.847 0.239 1.582 0.665 0.159
#> 
#> Array number 7 Hydracarina Rows 16 Cols 4 
#>   Iner  Iner+ Var   Var+  cos2  cov2 
#> 1 1     1     0.915 0.915 0.693 0.634
#> 2 0.87  1.87  0.851 1.766 0.548 0.466
#> 3 0.591 2.461 0.667 2.434 0.86  0.574
#> 
#> Array number 8 Malacostraca Rows 16 Cols 3 
#>   Iner  Iner+ Var   Var+  cos2  cov2 
#> 1 1     1     0.876 0.876 0.751 0.657
#> 2 0.529 1.529 0.653 1.528 0.672 0.438
#> 3 0.154 1.683 0.155 1.683 0.075 0.012
#> 
#> Array number 9 Mollusca Rows 16 Cols 8 
#>   Iner  Iner+ Var   Var+  cos2  cov2 
#> 1 1     1     0.974 0.974 0.773 0.753
#> 2 0.286 1.286 0.261 1.235 0.805 0.21 
#> 3 0.207 1.493 0.173 1.408 0.481 0.083
#> 
#> Array number 10 Oligochaeta Rows 16 Cols 6 
#>   Iner  Iner+ Var   Var+  cos2  cov2 
#> 1 1     1     0.755 0.755 0.482 0.364
#> 2 0.799 1.799 0.443 1.198 0.53  0.234
#> 3 0.383 2.183 0.244 1.442 0.539 0.132
#> 
plot(mcoa1)
#> Error in s.match(dfxy1 = mcoa1$Tl1, dfxy2 = as.data.frame(matrix(kronecker(c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1), as.matrix(mcoa1$SynVar)), nrow = 160L,     ncol = 3L, dimnames = list(c("Q.Hemiptera", "P.Hemiptera",     "R.Hemiptera", "J.Hemiptera", "E.Hemiptera", "C.Hemiptera",     "D.Hemiptera", "K.Hemiptera", "B.Hemiptera", "A.Hemiptera",     "G.Hemiptera", "M.Hemiptera", "L.Hemiptera", "F.Hemiptera",     "H.Hemiptera", "N.Hemiptera", "Q.Odonata", "P.Odonata", "R.Odonata",     "J.Odonata", "E.Odonata", "C.Odonata", "D.Odonata", "K.Odonata",     "B.Odonata", "A.Odonata", "G.Odonata", "M.Odonata", "L.Odonata",     "F.Odonata", "H.Odonata", "N.Odonata", "Q.Trichoptera", "P.Trichoptera",     "R.Trichoptera", "J.Trichoptera", "E.Trichoptera", "C.Trichoptera",     "D.Trichoptera", "K.Trichoptera", "B.Trichoptera", "A.Trichoptera",     "G.Trichoptera", "M.Trichoptera", "L.Trichoptera", "F.Trichoptera",     "H.Trichoptera", "N.Trichoptera", "Q.Ephemeroptera", "P.Ephemeroptera",     "R.Ephemeroptera", "J.Ephemeroptera", "E.Ephemeroptera",     "C.Ephemeroptera", "D.Ephemeroptera", "K.Ephemeroptera",     "B.Ephemeroptera", "A.Ephemeroptera", "G.Ephemeroptera",     "M.Ephemeroptera", "L.Ephemeroptera", "F.Ephemeroptera",     "H.Ephemeroptera", "N.Ephemeroptera", "Q.Coleoptera", "P.Coleoptera",     "R.Coleoptera", "J.Coleoptera", "E.Coleoptera", "C.Coleoptera",     "D.Coleoptera", "K.Coleoptera", "B.Coleoptera", "A.Coleoptera",     "G.Coleoptera", "M.Coleoptera", "L.Coleoptera", "F.Coleoptera",     "H.Coleoptera", "N.Coleoptera", "Q.Diptera", "P.Diptera",     "R.Diptera", "J.Diptera", "E.Diptera", "C.Diptera", "D.Diptera",     "K.Diptera", "B.Diptera", "A.Diptera", "G.Diptera", "M.Diptera",     "L.Diptera", "F.Diptera", "H.Diptera", "N.Diptera", "Q.Hydracarina",     "P.Hydracarina", "R.Hydracarina", "J.Hydracarina", "E.Hydracarina",     "C.Hydracarina", "D.Hydracarina", "K.Hydracarina", "B.Hydracarina",     "A.Hydracarina", "G.Hydracarina", "M.Hydracarina", "L.Hydracarina",     "F.Hydracarina", "H.Hydracarina", "N.Hydracarina", "Q.Malacostraca",     "P.Malacostraca", "R.Malacostraca", "J.Malacostraca", "E.Malacostraca",     "C.Malacostraca", "D.Malacostraca", "K.Malacostraca", "B.Malacostraca",     "A.Malacostraca", "G.Malacostraca", "M.Malacostraca", "L.Malacostraca",     "F.Malacostraca", "H.Malacostraca", "N.Malacostraca", "Q.Mollusca",     "P.Mollusca", "R.Mollusca", "J.Mollusca", "E.Mollusca", "C.Mollusca",     "D.Mollusca", "K.Mollusca", "B.Mollusca", "A.Mollusca", "G.Mollusca",     "M.Mollusca", "L.Mollusca", "F.Mollusca", "H.Mollusca", "N.Mollusca",     "Q.Oligochaeta", "P.Oligochaeta", "R.Oligochaeta", "J.Oligochaeta",     "E.Oligochaeta", "C.Oligochaeta", "D.Oligochaeta", "K.Oligochaeta",     "B.Oligochaeta", "A.Oligochaeta", "G.Oligochaeta", "M.Oligochaeta",     "L.Oligochaeta", "F.Oligochaeta", "H.Oligochaeta", "N.Oligochaeta"    ), c("Axis1", "Axis2", "Axis3")))), xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "Rows"), parrows = list(        angle = 0), plabels = list(alpha = 0, boxes = list(draw = FALSE))): non convenient selection for dfxy1 or dfxy2 (can not be converted to dataframe)
```
