# French Worker Survey (1970)

The `worksurv` data frame gives 319 response items and 4 questions
providing from a French Worker Survey.

## Usage

``` r
data(worksurv)
```

## Format

This data frame contains the following columns:

1.  pro: Professional elections. In professional elections in your firm,
    would you rather vote for a list supported by?

    - `CGT`

    - `CFDT`

    - `FO`

    - `CFTC`

    - `Auton` Autonomous

    - `Abst`

    - `Nonaffi` Not affiliated

    - `NR` No response

2.  una: Union affiliation. At the present time, are you affiliated to a
    Union, and in the affirmative, which one?

    - `CGT`

    - `CFDT`

    - `FO`

    - `CFTC`

    - `Auton` Autonomous

    - `CGC`

    - `Notaffi` Not affiliated

    - `NR` No response

3.  pre: Presidential election. On the last presidential election
    (1969), can you tell me the candidate for whom you havevoted?

    - `Duclos`

    - `Deferre`

    - `Krivine`

    - `Rocard`

    - `Poher`

    - `Ducatel`

    - `Pompidou`

    - `NRAbs` No response, abstention

4.  pol: political sympathy. Which political party do you feel closest
    to, as a rule?

    - `Communist` (PCF)

    - `Socialist` (SFIO+PSU+FGDS)

    - `Left` (Party of workers,...)

    - `Center` MRP+RAD.

    - `RI`

    - `Right` INDEP.+CNI

    - `Gaullist` UNR

    - `NR` No response

## Details

The data frame `worksurv` has the attribute 'counts' giving the number
of responses for each item.

## Source

Rouanet, H. and Le Roux, B. (1993) *Analyse des données
multidimensionnelles*. Dunod, Paris.

## References

Le Roux, B. and Rouanet, H. (1997) Interpreting axes in multiple
correspondence analysis: method of the contributions of points and
deviation. Pages 197-220 in B. J. and M. Greenacre, editors.
*Visualization of categorical data*, Acamedic Press, London.

## Examples

``` r
data(worksurv)
acm1 <- dudi.acm(worksurv, row.w = attr(worksurv, "counts"), scan = FALSE)

if(adegraphicsLoaded()) {
  s.class(acm1$li, worksurv)
} else {
  par(mfrow = c(2, 2))
  apply(worksurv, 2, function(x) s.class(acm1$li, factor(x), attr(worksurv, 'counts')))
  par(mfrow = c(1, 1))
}
```
