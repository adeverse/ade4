# Genetic structure of two nitrogen fixing bacteria influenced by geographical isolation and host specialization

The data set concerns fixing bacteria belonging to the genus
Sinorhizobium (Rhizobiaceae) associated with the plant genus Medicago
(Fabaceae). It is a combination of two data sets fully available online
from GenBank and published in two recent papers (see reference below).
The complete sampling procedure is described in the Additional file 3 of
the reference below. We delineated six populations according to
geographical origin (France: F, Tunisia Hadjeb: TH, Tunisia Enfidha:
TE), the host plant (*M. truncatula* or similar symbiotic specificity:
T, M. laciniata: L), and the taxonomical status of bacteria (S.
meliloti: mlt, S. medicae: mdc). Each population will be called
hereafter according to the three above criteria, e.g. THLmlt is the
population sampled in Tunisia at Hadjeb from M. laciniata nodules which
include S. meliloti isolates. S. medicae interacts with M. truncatula
while S. meliloti interacts with both M. laciniata (S. meliloti bv.
medicaginis) and M. truncatula (S. meliloti bv. meliloti). The numbers
of individuals are respectively 46 for FTmdc, 43 for FTmlt, 20 for
TETmdc, 24 for TETmlt, 20 for TELmlt, 42 for THTmlt and 20 for THLmlt.

Four different intergenic spacers (IGS), IGSNOD, IGSEXO, IGSGAB, and
IGSRKP, distributed on the different replication units of the model
strain 1021 of S. meliloti bv. meliloti had been sequenced to
characterize each bacterial isolate (DNA extraction and sequencing
procedures are described in an additional file). It is noteworthy that
the IGSNOD marker is located within the nod gene cluster and that
specific alleles at these loci determine the ability of S. meliloti
strains to interact with either M. laciniata or M. truncatula.

## Usage

``` r
data(rhizobium)
```

## Format

`rhizobium` is a list of 2 components.

- dnaobj: list of dna lists. Each dna list corresponds to a locus. For a
  given locus, the dna list provides the dna sequences The ith sequences
  of all loci corresponds to the ith individual of the data set.

- pop: The list of the populations which each individual sequence
  belongs to.

## Source

Pavoine, S. and Bailly, X. (2007) New analysis for consistency among
markers in the study of genetic diversity: development and application
to the description of bacterial diversity. *BMC Evolutionary Biology*,
**7**, e156.

## Examples

``` r
# The functions used below require the package ape
data(rhizobium)
if(requireNamespace("ape", quietly = TRUE)) {
dat <- prep.mdpcoa(rhizobium[[1]], rhizobium[[2]], 
    model = c("F84", "F84", "F84", "F81"),
    pairwise.deletion = TRUE)
sam <- dat$sam
dis <- dat$dis
# The distances should be Euclidean. 
# Several transformations exist to render a distance object Euclidean 
# (see functions cailliez, lingoes and quasieuclid in the ade4 package). 
# Here we use the quasieuclid function.
dis <- lapply(dis, quasieuclid)
mdpcoa1 <- mdpcoa(sam, dis, scann = FALSE, nf = 2)

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
