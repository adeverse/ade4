\name{butterfly}
\alias{butterfly}
\non_function{}
\title{Genetics-Ecology-Environment Triple}
\description{
This data set contains environmental and genetics informations about 16 Euphydryas editha butterfly colonies studied in California and Oregon
}
\usage{data(butterfly)}
\format{
\code{butterfly} is a list with 4 objects.\cr
    \enumerate{
    \item{xy}{is a data frame with the two coordinates of the 16 Euphydryas editha butterfly colonies. }
    \item{envir}{is a environmental data frame of  16 sites - 4 variables. }
    \item{genet}{is a genetics data frame of 16 sites - 6 allele frequencies. }
    \item{contour}{is a data frame for background map (California map). }
	}
}
\source{
McKechnie, S.W., Ehrlich, P.R. and White, R.R. (1975)\cr
Population genetics of Euphydryas butterflies.\cr
I. Genetic variation and the neutrality hypothesis.\cr
\emph{Genetics}, \bold{81}, 571--594.\cr\cr

Manly, B.F. (1994) \emph{Multivariate Statistical Methods. A primer.}\cr
Second edition. Chapman & Hall, London. 1--215.
}
\examples{
library(mva)
data(butterfly)
par(mfrow = c(2,2))
s.label(butterfly$xy, contour = butterfly$contour, inc = FALSE)
table.dist(dist(butterfly$xy), labels = row.names(butterfly$xy)) # depends of mva
s.value(butterfly$xy, dudi.pca(butterfly$envir, scan = FALSE)$li[,1], 
    contour = butterfly$contour, inc = FALSE, csi = 3)
plot(mantel.randtest(dist(butterfly$xy), dist(butterfly$gen), 99),
    main = "genetic/spatial")
par(mfrow = c(1,1))
}
\keyword{datasets}
