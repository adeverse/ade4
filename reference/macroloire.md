# Assemblages of Macroinvertebrates in the Loire River (France)

A total of 38 sites were surveyed along 800 km of the Loire River
yielding 40 species of Trichoptera and Coleoptera sampled from riffle
habitats. The river was divided into three regions according to geology:
granitic highlands (Region#1), limestone lowlands (Region#2) and
granitic lowlands (Region#3). This data set has been collected for
analyzing changes in macroinvertebrate assemblages along the course of a
large river. Four criterias are given here: variation in 1/ species
composition and relative abundance, 2/ taxonomic composition, 3/ Body
Sizes, 4/ Feeding habits.

## Usage

``` r
data(macroloire)
```

## Format

`macroloire` is a list of 5 components.

- fau:

  is a data frame containing the abundance of each species in each
  station.

- traits:

  is a data frame describes two traits : the maximal sizes and feeding
  habits for each species. Each trait is divided into categories. The
  maximal size achieved by the species is divided into four length
  categories: \<= 5mm ; \>5-10mm ; \>10-20mm ; \>20-40mm. Feeding habits
  comprise seven categories: engulfers, shredders, scrapers,
  deposit-feeders, active filter-feeders, passive filter-feeders and
  piercers, in this order. The affinity of each species to each trait
  category is quantified using a fuzzy coding approach. A score is
  assigned to each species for describing its affinity for a given trait
  category from "0" which indicates no affinity to "3" which indicates
  high affinity. These affinities are further transformed into
  percentage per trait per species.

- taxo:

  is a data frame with species and 3 factors: Genus, Family and Order.
  It is a data frame of class "taxo": the variables are factors giving
  nested classifications.

- envir:

  is a data frame giving for each station, its name (variable
  "SamplingSite"), its distance from the source (km, variable
  "Distance"), its altitude (m, variable "Altitude"), its position
  regarding the dams \[1: before the first dam; 2: after the first dam;
  3: after the second dam\] (variable "Dam"), its position in one of the
  three regions defined according to geology: granitic highlands,
  limestone lowlands and granitic lowlands (variable "Morphoregion"),
  presence of confluence (variable "Confluence")

- labels:

  is a data frame containing the latin names of the species.

## Source

Ivol, J.M., Guinand, B., Richoux, P. and Tachet, H. (1997) Longitudinal
changes in Trichoptera and Coleoptera assemblages and environmental
conditions in the Loire River (France). *Archiv for Hydrobiologie*,
**138**, 525–557.  

Pavoine S. and Doledec S. (2005) The apportionment of quadratic entropy:
a useful alternative for partitioning diversity in ecological data.
*Environmental and Ecological Statistics*, **12**, 125–138.

## Examples

``` r
    data(macroloire)
    apqe.Equi <- apqe(macroloire$fau, , macroloire$morphoregions)
    apqe.Equi
#> $call
#> apqe(samples = macroloire$fau, structures = macroloire$morphoregions)
#> 
#> $results
#>                 diversity
#> Between samples 0.2701165
#> Within samples  0.5035630
#> Total           0.7736795
#> 
    #test.Equi <- randtest.apqe(apqe.Equi, method = "aggregated", 99)
    #plot(test.Equi)

    if (FALSE) { # \dontrun{ 

    m.phy <- taxo2phylog(macroloire$taxo)
    apqe.Tax <- apqe(macroloire$fau, m.phy$Wdist, macroloire$morphoregions)
    apqe.Tax
    #test.Tax <- randtest.apqe(apqe.Tax, method = "aggregated", 99)
    #plot(test.Tax)

    dSize <- sqrt(dist.prop(macroloire$traits[ ,1:4], method = 2))
    apqe.Size <- apqe(macroloire$fau, dSize, macroloire$morphoregions)
    apqe.Size
    #test.Size <- randtest.apqe(apqe.Size, method = "aggregated", 99)
    #plot(test.Size)

    dFeed <- sqrt(dist.prop(macroloire$traits[ ,-(1:4)], method = 2))
    apqe.Feed <- apqe(macroloire$fau, dFeed, macroloire$morphoregions)
    apqe.Feed
    #test.Feed <- randtest.apqe(apqe.Feed, method = "aggregated", 99)
    #plot(test.Size)

    } # }
```
