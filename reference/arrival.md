# Arrivals at an intensive care unit

This data set gives arrival times of 254 patients at an intensive care
unit during one day.

## Usage

``` r
data(arrival)
```

## Format

`arrival` is a list containing the 2 following objects :

- times:

  is a vector giving the arrival times in the form HH:MM

- hours:

  is a vector giving the number of arrivals per hour for the day
  considered

## Source

Data taken from the Oriana software developed by Warren L. Kovach
<sales@kovcomp.com> starting from
<https://www.kovcomp.co.uk/oriana/index.html>.

## References

Fisher, N. I. (1993) *Statistical Analysis of Circular Data*. Cambridge
University Press.

## Examples

``` r
data(arrival)
dotcircle(arrival$hours, pi/2 + pi/12)
```
