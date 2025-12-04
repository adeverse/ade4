# Students and Subjects

The `seconde` data frame gives the marks of 22 students for 8 subjects.

## Usage

``` r
data(seconde)
```

## Format

This data frame (22,8) contains the following columns: - HGEO: History
and Geography - FRAN: French literature - PHYS: Physics - MATH:
Mathematics - BIOL: Biology - ECON: Economy - ANGL: English language -
ESPA: Spanish language

## Source

Personal communication

## Examples

``` r
data(seconde)
if(adegraphicsLoaded()) {
  scatter(dudi.pca(seconde, scan = FALSE), row.plab.cex = 1, col.plab.cex = 1.5)
} else {
  scatter(dudi.pca(seconde, scan = FALSE), clab.r = 1, clab.c = 1.5)
}
#> Warning: Unused parameters: clab 
#> Warning: Unused parameters: clab 
#> Warning: Unused parameters: clab 
#> Warning: Unused parameters: clab 
#> Warning: Unused parameters: clab 
#> Warning: Unused parameters: clab 
```
