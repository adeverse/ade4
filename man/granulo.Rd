\name{granulo}
\alias{granulo}
\non_function{}
\title{Granulometric Curves}
\description{
This data set gives the repartition in diameter classes of deposit samples. 
}
\usage{data(granulo)}
\format{
	\code{granulo} is a list of 2 components.
	\enumerate{
		\item{tab}{contains the 49 deposit samples, 9 diameter classes, weight of grains by size class}
		\item{born}{contains the boundaries of the diameter classes}
	}
}
\source{
Gaschignard-Fossati, O. (1986) Répartition spatiale des macroinvertébrés benthiques d'un bras vif du Rhône.\cr
Rôle des crues et dynamique saisonni"re.\cr
Th"se de doctorat, Université Lyon 1.
}
\examples{
data(granulo)
w <- t(apply(granulo$tab, 1, function (x) x / sum(x)))
w <- data.frame(w)
wtr <- data.frame(t(w))
wmoy <- data.frame(matrix(apply(wtr, 1, mean), 1))
d1 <- dudi.pca(w, scal = FALSE, scan = FALSE)
wmoy <- suprow.default(d1, wmoy)
s.arrow(d1$c1, clab = 1.5)
s.distri(d1$c1, wtr, cstar = 0.33, cell = 0, 
    axesell = FALSE, add.p = TRUE, clab = 0.75)
s.label(wmoy, cpoi = 5, clab = 0, add.p = TRUE)
}
\keyword{datasets}
