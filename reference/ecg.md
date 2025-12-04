# Electrocardiogram data

These data were measured during the normal sinus rhythm of a patient who
occasionally experiences arrhythmia. There are 2048 observations
measured in units of millivolts and collected at a rate of 180 samples
per second. This time series is a good candidate for a multiresolution
analysis because its components are on different scales. For example,
the large scale (low frequency) fluctuations, known as baseline drift,
are due to the patient respiration, while the prominent short scale
(high frequency) intermittent fluctuations between 3 and 4 seconds are
evidently due to patient movement. Heart rhythm determines most of the
remaining features in the series. The large spikes occurring about 0.7
seconds apart the R waves of normal heart rhythm; the smaller, but sharp
peak coming just prior to an R wave is known as a P wave; and the
broader peak that comes after a R wave is a T wave.

## Usage

``` r
data(ecg)
```

## Format

A vector of class `ts` containing 2048 observations.

## Source

Gust Bardy and Per Reinhall, University of Washington

## References

Percival, D. B., and Walden, A.T. (2000) *Wavelet Methods for Time
Series Analysis*, Cambridge University Press.

## Examples

``` r
if (FALSE) { # \dontrun{
# figure 130 in Percival and Walden (2000)
if (requireNamespace("waveslim") == TRUE) { 
data(ecg)
ecg.level <- haar2level(ecg)
ecg.haar <- orthobasis.haar(length(ecg))
ecg.mld <- mld(ecg, ecg.haar, ecg.level, plot = FALSE)
res <- cbind.data.frame(apply(ecg.mld[,1:5],1,sum), ecg.mld[,6:11])
par(mfrow = c(8,1))
par(mar = c(2, 5, 1.5, 0.6))
plot(as.ts(ecg), ylab = "ECG")
apply(res, 2, function(x) plot(as.ts(x), ylim = range(res),
 ylab = ""))
par(mfrow = c(1,1))
}} # }
```
