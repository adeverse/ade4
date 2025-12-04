# Table of Factors

`banque` gives the results of a bank survey onto 810 customers.

## Usage

``` r
data(banque)
```

## Format

This data frame contains the following columns:

1.  csp: "Socio-professional categories" a factor with levels

    - `agric` Farmers

    - `artis` Craftsmen, Shopkeepers, Company directors

    - `cadsu` Executives and higher intellectual professions

    - `inter` Intermediate professions

    - `emplo` Other white-collar workers

    - `ouvri` Manual workers

    - `retra` Pensionners

    - `inact` Non working population

    - `etudi` Students

2.  duree: "Time relations with the customer" a factor with levels

    - `dm2` \<2 years

    - `d24` \[2 years, 4 years\[

    - `d48` \[4 years, 8 years\[

    - `d812` \[8 years, 12 years\[

    - `dp12` \>= 12 years

3.  oppo: "Stopped a check?" a factor with levels

    - `non` no

    - `oui` yes

4.  age: "Customer's age" a factor with levels

    - `ai25` \[18 years, 25 years\[

    - `ai35` \[25 years, 35 years\[

    - `ai45` \[35 years, 45 years\[

    - `ai55` \[45 years, 55 years\[

    - `ai75` \[55 years, 75 years\[

5.  sexe: "Customer's gender" a factor with levels

    - `hom` Male

    - `fem` Female

6.  interdit: "No checkbook allowed" a factor with levels

    - `non` no

    - `oui` yes

7.  cableue: "Possess a bank card?" a factor with levels

    - `non` no

    - `oui` yes

8.  assurvi: "Contrat of life insurance?" a factor with levels

    - `non` no  

    - `oui` yes

9.  soldevu: "Balance of the current accounts" a factor with levels

    - `p4` credit balance \> 20000

    - `p3` credit balance 12000-20000

    - `p2` credit balance 4000-12000

    - `p1` credit balance \>0-4000

    - `n1` debit balance 0-4000

    - `n2` debit balance \>4000

10. eparlog: "Savings and loan association account amount" a factor with
    levels

    - `for` \> 20000

    - `fai` \>0 and \<20000

    - `nul` nulle

11. eparliv: "Savings bank amount" a factor with levels

    - `for` \> 20000

    - `fai` \>0 and \<20000

    - `nul` nulle

12. credhab: "Home loan owner" a factor with levels

    - `non` no

    - `oui` yes

13. credcon: "Consumer credit amount" a factor with levels

    - `nul` none

    - `fai` \>0 and \<20000

    - `for` \> 20000

14. versesp: "Check deposits" a factor with levels

    - `oui` yes

    - `non` no

15. retresp: "Cash withdrawals" a factor with levels

    - `fai` \< 2000

    - `moy` 2000-5000

    - `for` \> 5000

16. remiche: "Endorsed checks amount" a factor with levels

    - `for` \>10000

    - `moy` 10000-5000

    - `fai` 1-5000

    - `nul` none

17. preltre: "Treasury Department tax deductions" a factor with levels

    - `nul` none

    - `fai` \<1000

    - `moy` \>1000

18. prelfin: "Financial institution deductions" a factor with levels

    - `nul` none

    - `fai` \<1000

    - `moy` \>1000

19. viredeb: "Debit transfer amount" a factor with levels

    - `nul` none

    - `fai` \<2500

    - `moy` 2500-5000

    - `for` \>5000

20. virecre: "Credit transfer amount" a factor with levels

    - `for` \>10000

    - `moy` 10000-5000

    - `fai` \<5000

    - `nul` aucun

21. porttit: "Securities portfolio estimations" a factor with levels

    - `nul` none

    - `fai` \< 20000

    - `moy` 20000-100000

    - `for` \>100000

## Source

anonymous

## Examples

``` r
data(banque)
banque.acm <- dudi.acm(banque, scannf = FALSE, nf = 3)
apply(banque.acm$cr, 2, mean)
#>        RS1        RS2        RS3 
#> 0.17346599 0.11838319 0.09825814 
banque.acm$eig[1:banque.acm$nf] # the same thing
#> [1] 0.17346599 0.11838319 0.09825814

if(adegraphicsLoaded()) {
  g <- s.arrow(banque.acm$c1, plabels.cex = 0.75)
} else {
  s.arrow(banque.acm$c1, clab = 0.75)
}
```
