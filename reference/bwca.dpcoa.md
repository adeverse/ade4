# Between- and within-class double principal coordinate analysis

These functions allow to study the variations in diversity among
communities (as in dpcoa) taking into account a partition in classes

## Usage

``` r
bwca.dpcoa(x, fac, cofac, scannf = TRUE, nf = 2, ...)
# S3 method for class 'dpcoa'
bca(x, fac, scannf = TRUE, nf = 2, ...) 
# S3 method for class 'dpcoa'
wca(x, fac, scannf = TRUE, nf = 2, ...) 
# S3 method for class 'betwit'
randtest(xtest, nrepet = 999, ...)
# S3 method for class 'betwit'
summary(object, ...)
# S3 method for class 'witdpcoa'
print(x, ...)
# S3 method for class 'betdpcoa'
print(x, ...)
```

## Arguments

- x:

  an object of class [`dpcoa`](dpcoa.md)

- fac:

  a factor partitioning the collections in classes

- scannf:

  a logical value indicating whether the eigenvalues barplot should be
  displayed

- nf:

  if scannf FALSE, a numeric value indicating the number of kept axes

- ...:

  further arguments passed to or from other methods

- cofac:

  a cofactor partitioning the collections in classes used as a
  covariable

- nrepet:

  the number of permutations

- xtest, object:

  an object of class `betwit` created by a call to the function
  `bwca.dpcoa`

## Value

Objects of class `betdpcoa`, `witdpcoa` or `betwit`

## References

Dray, S., Pavoine, S. and Aguirre de Carcer, D. (2015) Considering
external information to improve the phylogenetic comparison of microbial
communities: a new approach based on constrained Double Principal
Coordinates Analysis (cDPCoA). *Molecular Ecology Resources*, **15**,
242–249. doi:10.1111/1755-0998.12300

## Author

Stéphane Dray <stephane.dray@univ-lyon1.fr>

## See also

[`dpcoa`](dpcoa.md)

## Examples

``` r
if (FALSE) { # \dontrun{

## First example of Dray et al (2015) paper

con <- url("https://pbil.univ-lyon1.fr/datasets/dray/MER2014/soilmicrob.rda")
load(con)
close(con)

## Partial CCA
coa <- dudi.coa(soilmicrob$OTU, scannf = FALSE)
wcoa <- wca(coa, soilmicrob$env$pH, scannf = FALSE)
wbcoa <- bca(wcoa,soilmicrob$env$VegType, scannf = FALSE)

## Classical DPCoA
dp <- dpcoa(soilmicrob$OTU, soilmicrob$dphy, RaoDecomp = FALSE, scannf = FALSE)

## Between DPCoA (focus on the effect of vegetation type)
bdp <- bca(dp, fac = soilmicrob$env$VegType , scannf = FALSE)
bdp$ratio ## 0.2148972
randtest(bdp) ## p = 0.001

## Within DPCoA (remove the effect of pH)
wdp <- wca(dp, fac = soilmicrob$env$pH, scannf = FALSE)
wdp$ratio ## 0.5684348

## Between Within-DPCoA (remove the effect of pH and focus on vegetation type)
wbdp <- bwca.dpcoa(dp, fac = soilmicrob$env$VegType, cofac =  soilmicrob$env$pH, scannf = FALSE)
wbdp$ratio ## 0.05452813
randtest(wbdp) ## p = 0.001
} # }
```
