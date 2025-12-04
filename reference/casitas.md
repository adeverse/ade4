# Enzymatic polymorphism in Mus musculus

This data set is a data frame with 74 rows (mice) and 15 columns (loci
enzymatic polymorphism of the DNA mitochondrial). Each value contains 6
characters coding for two allelles. The missing values are coding by
'000000'.

## Usage

``` r
data(casitas)
```

## Format

The 74 individuals of `casitas` belong to 4 groups:

- 1:

  24 mice of the sub-species *Mus musculus domesticus*

- 2:

  11 mice of the sub-species *Mus musculus castaneus*

- 3:

  9 mice of the sub-species *Mus musculus musculus*

- 4:

  30 mice from a population of the lake Casitas (California)

## Source

Exemple du logiciel GENETIX. Belkhir k. et al. GENETIX, logiciel sous
WindowsTM pour la génétique des populations. Laboratoire Génome,
Populations, Interactions CNRS UMR 5000, Université de Montpellier II,
Montpellier (France).  
<https://kimura.univ-montp2.fr/genetix/>

## References

Orth, A., T. Adama, W. Din and F. Bonhomme. (1998) Hybridation naturelle
entre deux sous espèces de souris domestique *Mus musculus domesticus*
et *Mus musculus castaneus* près de Lake Casitas (Californie). *Genome*,
**41**, 104–110.

## Examples

``` r
data(casitas)
str(casitas)
#> 'data.frame':    74 obs. of  15 variables:
#>  $ Aat : chr  "100100" "100100" "100100" "100100" ...
#>  $ Amy : chr  "080080" "080100" "080080" "080080" ...
#>  $ Es1 : chr  "094094" "094094" "094094" "094094" ...
#>  $ Es2 : chr  "100100" "100100" "100100" "100100" ...
#>  $ Es10: chr  "100100" "100100" "100100" "100100" ...
#>  $ Hbb : chr  "120120" "120120" "120120" "120120" ...
#>  $ Gpd1: chr  "100100" "100100" "100100" "100100" ...
#>  $ Idh1: chr  "100100" "100125" "100100" "100125" ...
#>  $ Mod1: chr  "110110" "110110" "110110" "100100" ...
#>  $ Mod2: chr  "100100" "100100" "100100" "100100" ...
#>  $ Mpi : chr  "100100" "100100" "100100" "100100" ...
#>  $ Np  : chr  "100100" "100100" "100100" "100100" ...
#>  $ Pgm1: chr  "100100" "100100" "100100" "100100" ...
#>  $ Pgm2: chr  "100100" "100100" "100100" "100100" ...
#>  $ Sod : chr  "100100" "100100" "100100" "100100" ...
names(casitas)
#>  [1] "Aat"  "Amy"  "Es1"  "Es2"  "Es10" "Hbb"  "Gpd1" "Idh1" "Mod1" "Mod2"
#> [11] "Mpi"  "Np"   "Pgm1" "Pgm2" "Sod" 
```
