# Distribution of Alpine plants in Aravo (Valloire, France)

This dataset describe the distribution of 82 species of Alpine plants in
75 sites. Species traits and environmental variables are also measured.

## Usage

``` r
data(aravo)
```

## Format

`aravo` is a list containing the following objects :

- spe:

  is a data.frame with the abundance values of 82 species (columns) in
  75 sites (rows).

- env:

  is a data.frame with the measurements of 6 environmental variables for
  the sites.

- traits:

  is data.frame with the measurements of 8 traits for the species.

- spe.names:

  is a vector with full species names.

## Details

The environmental variables are:

|                                                                                      |                                                                          |                                                                                                                     |
|--------------------------------------------------------------------------------------|--------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| Aspect                                                                               | Relative south aspect (opposite of the sine of aspect with flat coded 0) | Slope                                                                                                               |
| Slope inclination (degrees)                                                          | Form                                                                     | Microtopographic landform index: 1 (convexity); 2 (convex slope); 3 (right slope); 4 (concave slope); 5 (concavity) |
| Snow                                                                                 | Mean snowmelt date (Julian day) averaged over 1997-1999                  | PhysD                                                                                                               |
| Physical disturbance, i.e., percentage of unvegetated soil due to physical processes | ZoogD                                                                    | Zoogenic disturbance, i.e., quantity of unvegetated soil due to marmot activity: no; some; high                     |

The species traits for the plants are:

|        |                                                                 |
|--------|-----------------------------------------------------------------|
| Height | Vegetative height (cm)                                          |
| Spread | Maximum lateral spread of clonal plants (cm)                    |
| Angle  | Leaf elevation angle estimated at the middle of the lamina      |
| Area   | Area of a single leaf                                           |
| Thick  | Maximum thickness of a leaf cross section (avoiding the midrib) |
| SLA    | Specific leaf area                                              |
| Nmass  | Mass-based leaf nitrogen content                                |
| Seed   | Seed mass                                                       |

## Source

Choler, P. (2005) Consistent shifts in Alpine plant traits along a
mesotopographical gradient. *Arctic, Antarctic, and Alpine Research*,
**37**,444–453.

## Examples

``` r
data(aravo)
coa1 <- dudi.coa(aravo$spe, scannf = FALSE, nf = 2)
dudienv <- dudi.hillsmith(aravo$env, scannf = FALSE, nf = 2, row.w = coa1$lw)
duditrait <- dudi.pca(aravo$traits, scannf = FALSE, nf = 2, row.w = coa1$cw)
rlq1 <- rlq(dudienv, coa1, duditrait, scannf = FALSE, nf = 2)
plot(rlq1)
```
