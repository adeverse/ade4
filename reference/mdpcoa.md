# Multiple Double Principal Coordinate Analysis

The DPCoA analysis (see [`dpcoa`](dpcoa.md)) has been developed by
Pavoine et al. (2004). It has been used in genetics for describing
inter-population nucleotide diversity. However, this procedure can only
be used with one locus. In order to measure and describe nucleotide
diversity with more than one locus, we developed three versions of
multiple DPCoA by using three ordination methods: multiple co-inertia
analysis, STATIS, and multiple factorial analysis. The multiple DPCoA
allows the impact of various loci in the measurement and description of
diversity to be quantified and described. This method is general enough
to handle a large variety of data sets. It complements existing methods
such as the analysis of molecular variance or other analyses based on
linkage disequilibrium measures, and is very useful to study the impact
of various loci on the measurement of diversity.

## Usage

``` r
mdpcoa(msamples, mdistances = NULL, method = 
    c("mcoa", "statis", "mfa"), 
    option = c("inertia", "lambda1", "uniform", "internal"), 
    scannf = TRUE, nf = 3, full = TRUE, 
    nfsep = NULL, tol = 1e-07)
kplotX.mdpcoa(object, xax = 1, yax = 2, mfrow = NULL, 
    which.tab = 1:length(object$nX), includepop = FALSE, 
    clab = 0.7, cpoi = 0.7, unique.scale = FALSE, 
    csub = 2, possub = "bottomright")
prep.mdpcoa(dnaobj, pop, model, ...)
```

## Arguments

- msamples:

  A list of data frames with the populations as columns, alleles as rows
  and abundances as entries. All the tables should have equal numbers of
  columns (populations). Each table corresponds to a locus;

- mdistances:

  A list of objects of class 'dist', corresponding to the distances
  among alleles. The order of the loci should be the same in msamples as
  in mdistances;

- method:

  One of the three possibilities: "mcoa", "statis", or "mfa". If a
  vector is given, only its first value is considered;

- option:

  One of the four possibilities for normalizing the population
  coordinates over the loci: "inertia", "lambda1", "uniform", or
  "internal". These options are used with MCoA and MFA only;

- scannf:

  a logical value indicating whether the eigenvalues bar plots should be
  displayed;

- nf:

  if scannf is FALSE, an integer indicating the number of kept axes for
  the multiple analysis;

- full:

  a logical value indicating whether all the axes should be kept in the
  separated analyses (one analysis, DPCoA, per locus);

- nfsep:

  if full is FALSE, a vector indicating the number of kept axes for each
  of the separated analyses;

- tol:

  a tolerance threshold for null eigenvalues (a value less than tol
  times the first one is considered as null);

- object:

  an object of class 'mdpcoa';

- xax:

  the number of the x-axis;

- yax:

  the number of the y-axis;

- mfrow:

  a vector of the form 'c(nr,nc)', otherwise computed by as special own
  function 'n2mfrow';

- which.tab:

  a numeric vector containing the numbers of the loci to analyse;

- includepop:

  a logical indicating if the populations must be displayed. In that
  case, the alleles are displayed by points and the populations by
  labels;

- clab:

  a character size for the labels;

- cpoi:

  a character size for plotting the points, used with
  'par("cex")'\*cpoint. If zero, no points are drawn;

- unique.scale:

  if TRUE, all the arrays of figures have the same scale;

- csub:

  a character size for the labels of the arrays of figures used with
  'par("cex")\*csub';

- possub:

  a string of characters indicating the sub-title position ("topleft",
  "topright", "bottomleft", "bottomright");

- dnaobj:

  a list of dna sequences that can be obtained with the function
  `read.dna` of the ape package;

- pop:

  a factor that gives the name of the population to which each sequence
  belongs;

- model:

  a vector giving the model to be applied for the calculations of the
  distances for each locus. One model should be attributed to each
  locus, given that the loci are in alphabetical order. The models can
  take the following values: "raw", "JC69", "K80" (the default), "F81",
  "K81", "F84", "BH87", "T92", "TN93", "GG95", "logdet", or "paralin".
  See the help documentation for the function "dist.dna" of ape for a
  describtion of the models.

- ...:

  `...` further arguments passed to or from other methods

## Value

The functions provide the following results:

- dist.ktab:

  returns an object of class `dist`;

## Details

An object obtained by the function mdpcoa has two classes. The first one
is "mdpcoa" and the second is either "mcoa", or "statis", or "mfa",
depending on the method chosen. Consequently, other functions already
available in ade4 for displaying graphical results can be used: With
MCoA, - plot.mcoa: this function displays (1) the differences among the
populations according to each locus and the compromise, (2) the
projection of the principal axes of the individual analyses onto the
synthetic variables, (3) the projection of the principal axes of the
individual analyses onto the co-inertia axes, (4) the squared vectorial
covariance among the coinertia scores and the synthetic variables; -
kplot.mcoa: this function divides previous displays (figures 1, 2, or 3
described in plot.mcoa) by giving one plot per locus.

With STATIS, - plot.statis: this function displays (1) the scores of
each locus according to the two first eigenvectors of the matrix *Rv*,
(2) the scatter diagram of the differences among populations according
to the compromise, (3) the weight attributed to each locus in abscissa
and the vectorial covariance among each individual analysis with the
notations in the main text of the paper) and the compromise analysis in
ordinates, (4) the covariance between the principal component inertia
axes of each locus and the axes of the compromise space; - kplot.statis:
this function displays for each locus the projection of the principal
axes onto the compromise space.

With MFA, - plot.mfa: this function displays (1) the differences among
the populations according to each locus and the compromise, (2) the
projection of the principal axes of the individual analyses onto the
compromise, (3) the covariance between the principal component inertia
axes of each locus and the axes of the compromise space, (4) for each
axis of the compromise, the amount of inertia conserved by the
projection of the individual analyses onto the common space. -
kplot.mfa: this function displays for each locus the projection of the
principal axes and populations onto the compromise space.

## References

Pavoine, S. and Bailly, X. (2007) New analysis for consistency among
markers in the study of genetic diversity: development and application
to the description of bacterial diversity. *BMC Evolutionary Biology*,
**7**, e156.  

Pavoine, S., Dufour, A.B. and Chessel, D. (2004) From dissimilarities
among species to dissimilarities among communities: a double principal
coordinate analysis. *Journal of Theoretical Biology*, **228**, 523–537.

## Author

Sandrine Pavoine <pavoine@mnhn.fr>

## See also

[`dpcoa`](dpcoa.md)

## Examples

``` r
# The functions used below require the package ape
data(rhizobium)
if (requireNamespace("ape", quietly = TRUE)) {
dat <- prep.mdpcoa(rhizobium[[1]], rhizobium[[2]], 
    model = c("F84", "F84", "F84", "F81"), pairwise.deletion = TRUE)
sam <- dat$sam
dis <- dat$dis
# The distances should be Euclidean. 
# Several transformations exist to render a distance object Euclidean 
# (see functions cailliez, lingoes and quasieuclid in the ade4 package). 
# Here we use the quasieuclid function.
dis <- lapply(dis, quasieuclid)
mdpcoa1 <- mdpcoa(sam, dis, scannf = FALSE, nf = 2)

# Reference analysis
plot(mdpcoa1)

# Differences between the loci
kplot(mdpcoa1)

# Alleles projected on the population maps.
kplotX.mdpcoa(mdpcoa1)
}
#> Warning: Zero distance(s)
#> Warning: Zero distance(s)
#> Warning: Zero distance(s)
#> Warning: Zero distance(s)
#> Warning: Zero distance(s)
#> Error in s.match(dfxy1 = mdpcoa1$Tl1, dfxy2 = as.data.frame(matrix(kronecker(c(1, 1, 1, 1), as.matrix(mdpcoa1$SynVar)), nrow = 28L, ncol = 2L,     dimnames = list(c("FTmdc.EXO.aa", "FTmlt.EXO.aa", "TELmlt.EXO.aa",     "TETmdc.EXO.aa", "TETmlt.EXO.aa", "THLmlt.EXO.aa", "THTmlt.EXO.aa",     "FTmdc.GAB.aa", "FTmlt.GAB.aa", "TELmlt.GAB.aa", "TETmdc.GAB.aa",     "TETmlt.GAB.aa", "THLmlt.GAB.aa", "THTmlt.GAB.aa", "FTmdc.NOD.aa",     "FTmlt.NOD.aa", "TELmlt.NOD.aa", "TETmdc.NOD.aa", "TETmlt.NOD.aa",     "THLmlt.NOD.aa", "THTmlt.NOD.aa", "FTmdc.RKP.aa", "FTmlt.RKP.aa",     "TELmlt.RKP.aa", "TETmdc.RKP.aa", "TETmlt.RKP.aa", "THLmlt.RKP.aa",     "THTmlt.RKP.aa"), c("Axis1", "Axis2")))), xax = 1, yax = 2,     plot = FALSE, storeData = TRUE, pos = -3, psub = list(text = "Rows"),     parrows = list(angle = 0), plabels = list(alpha = 0, boxes = list(        draw = FALSE))): non convenient selection for dfxy1 or dfxy2 (can not be converted to dataframe)
```
