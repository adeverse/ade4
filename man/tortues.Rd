\name{tortues}
\alias{tortues}
\docType{data}
\title{Morphological Study of the Painted Turtle}
\description{
This data set gives a morphological description (4 characters) of 48 turtles. 
}
\usage{data(tortues)}
\format{
a data frame with 48 rows and 4 columns (length (mm), maximum width(mm), height (mm), gender). 
}
\source{
Jolicoeur, P. and Mosimann, J. E. (1960)
Size and shape variation in the painted turtle. A principal component analysis.
\emph{Growth}, \bold{24}, 339--354.
}
\examples{
data(tortues)
xyz <- as.matrix(tortues[,1:3])
ref <- -svd(xyz)$u[,1]
pch0 <- c(1,20)[as.numeric(tortues$sex)]
plot(ref, xyz[,1], ylim = c(40,180), pch = pch0)
abline(lm(xyz[,1]~ -1 + ref))
points(ref,xyz[,2], pch = pch0)
abline(lm(xyz[,2]~ -1 + ref))
points(ref,xyz[,3], pch = pch0)
abline(lm(xyz[,3]~ -1 + ref))
}
\keyword{datasets}
