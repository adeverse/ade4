# Genetic Relationships between cattle breeds with microsatellites

This data set gives genetic relationships between cattle breeds with
microsatellites.

## Usage

``` r
data(microsatt)
```

## Format

`microsatt` is a list of 4 components.

- tab:

  contains the allelic frequencies for 18 cattle breeds (Taurine or
  Zebu,French or African) and 9 microsatellites.

- loci.names:

  is a vector of the names of loci.

- loci.eff:

  is a vector of the number of alleles per locus.

- alleles.names:

  is a vector of the names of alleles.

## Source

Extract of data prepared by D. Laloë <ugendla@dga2.jouy.inra.fr> from
data used in:

Moazami-Goudarzi, K., D. Laloë, J. P. Furet, and F. Grosclaude (1997)
Analysis of genetic relationships between 10 cattle breeds with 17
microsatellites. *Animal Genetics*, **28**, 338–345.

Souvenir Zafindrajaona, P.,Zeuh V. ,Moazami-Goudarzi K., Laloë D.,
Bourzat D., Idriss A., and Grosclaude F. (1999) Etude du statut
phylogénétique du bovin Kouri du lac Tchad à l'aide de marqueurs
moléculaires. *Revue d'Elevage et de Médecine Vétérinaire des pays
Tropicaux*, **55**, 155–162.

Moazami-Goudarzi, K., Belemsaga D. M. A., Ceriotti G., Laloë D. ,
Fagbohoun F., Kouagou N. T., Sidibé I., Codjia V., Crimella M. C.,
Grosclaude F. and Touré S. M. (2001)  
Caractérisation de la race bovine Somba à l'aide de marqueurs
moléculaires. *Revue d'Elevage et de Médecine Vétérinaire des pays
Tropicaux*, **54**, 1–10.

## References

See a data description at <http://pbil.univ-lyon1.fr/R/pdf/pps055.pdf>
(in French).

## Examples

``` r
if (FALSE) { # \dontrun{
data(microsatt)
fac <- factor(rep(microsatt$loci.names, microsatt$loci.eff))
w <- dudi.coa(data.frame(t(microsatt$tab)), scann = FALSE)
wit <- wca(w, fac, scann = FALSE)
microsatt.ktab <- ktab.within(wit)

plot(sepan(microsatt.ktab)) # 9 separated correspondence analyses
plot(mcoa(microsatt.ktab, scan = FALSE))
plot(mfa(microsatt.ktab, scan = FALSE))
plot(statis(microsatt.ktab, scan = FALSE))
} # }
```
