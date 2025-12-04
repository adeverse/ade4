# Principal Component Analysis with respect to orthogonal instrumental variables

performs a Principal Component Analysis with respect to orthogonal
instrumental variables.

## Usage

``` r
pcaivortho(dudi, df, scannf = TRUE, nf = 2)
# S3 method for class 'pcaivortho'
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

- object:

  an object of class `pcaiv`

- ...:

  further arguments passed to or from other methods

## Value

an object of class 'pcaivortho' sub-class of class `dudi`

- rank:

  an integer indicating the rank of the studied matrix

- nf:

  an integer indicating the number of kept axes

- eig:

  a vector with the all eigenvalues

- lw:

  a numeric vector with the row weigths (from `dudi`)

- cw:

  a numeric vector with the column weigths (from `dudi`)

- Y:

  a data frame with the dependant variables

- X:

  a data frame with the explanatory variables

- tab:

  a data frame with the modified array (projected variables)

- c1:

  a data frame with the Pseudo Principal Axes (PPA)

- as:

  a data frame with the Principal axis of `dudi$tab` on PAP

- ls:

  a data frame with the projection of lines of `dudi$tab` on PPA

- li:

  a data frame `dudi$ls` with the predicted values by X

- l1:

  a data frame with the Constraint Principal Components (CPC)

- co:

  a data frame with the inner product between the CPC and Y

- param:

  a data frame containing a summary

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## References

Rao, C. R. (1964) The use and interpretation of principal component
analysis in applied research. *Sankhya*, **A 26**, 329–359.  
  
Sabatier, R., Lebreton J. D. and Chessel D. (1989) Principal component
analysis with instrumental variables as a tool for modelling composition
data. In R. Coppi and S. Bolasco, editors. *Multiway data analysis*,
Elsevier Science Publishers B.V., North-Holland, 341–352

## Examples

``` r
if (FALSE) { # \dontrun{
data(avimedi)
cla <- avimedi$plan$reg:avimedi$plan$str
# simple ordination
coa1 <- dudi.coa(avimedi$fau, scan = FALSE, nf = 3)
# within region
w1 <- wca(coa1, avimedi$plan$reg, scan = FALSE)
# no region the same result
pcaivnonA <- pcaivortho(coa1, avimedi$plan$reg, scan = FALSE)
summary(pcaivnonA)
# region + strate
interAplusB <- pcaiv(coa1, avimedi$plan, scan = FALSE)

if(adegraphicsLoaded()) {
  g1 <- s.class(coa1$li, cla, psub.text = "Sans contrainte", plot = FALSE)
  g21 <- s.match(w1$li, w1$ls, plab.cex = 0, psub.text = "Intra Région", plot = FALSE)
  g22 <- s.class(w1$li, cla, plot = FALSE)
  g2 <- superpose(g21, g22)
  g31 <- s.match(pcaivnonA$li, pcaivnonA$ls, plab.cex = 0, psub.tex = "Contrainte Non A", 
    plot = FALSE)
  g32 <- s.class(pcaivnonA$li, cla, plot = FALSE)
  g3 <- superpose(g31, g32)
  g41 <- s.match(interAplusB$li, interAplusB$ls, plab.cex = 0, psub.text = "Contrainte A + B", 
    plot = FALSE)
  g42 <- s.class(interAplusB$li, cla, plot = FALSE)
  g4 <- superpose(g41, g42)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))

} else {
  par(mfrow = c(2, 2))
  s.class(coa1$li, cla, sub = "Sans contrainte")
  s.match(w1$li, w1$ls, clab = 0, sub = "Intra Région")
  s.class(w1$li, cla, add.plot = TRUE)
  s.match(pcaivnonA$li, pcaivnonA$ls, clab = 0, sub = "Contrainte Non A")
  s.class(pcaivnonA$li, cla, add.plot = TRUE)
  s.match(interAplusB$li, interAplusB$ls, clab = 0, sub = "Contrainte A + B")
  s.class(interAplusB$li, cla, add.plot = TRUE)
  par(mfrow = c(1,1))
}} # }
```
