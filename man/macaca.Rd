\name{macaca}
\alias{macaca}
\non_function{}
\title{Landmarks}
\description{
This data set gives the landmarks of a macaca at the ages of 0.9 and 5.77 years. 
}
\usage{data(macaca)}
\format{
    \code{macaca} is a list of 2 components.
    \enumerate{
    \item{xy1}{is a data frame with 72 points and 2 coordinates.}
    \item{xy2}{is a data frame with 72 points and 2 coordinates.}
    }
}
\source{
Olshan, A.F., Siegel, A.F. and Swindler, D.R. (1982)\cr
Robust and least-squares orthogonal mapping: Methods for the study of cephalofacial form and growth.\cr
\emph{American Journal of Physical Anthropology}, \bold{59}, 131--137.
}
\examples{
data(macaca)
par(mfrow = c(2,2))
s.match(macaca$xy1, macaca$xy2, clab = 0)
pro1 <- procuste(macaca$xy1, macaca$xy2, scal = FALSE)
s.match(pro1$tab1, pro1$rot2, clab = 0.7)
s.match(pro1$tab2, pro1$rot1, clab = 0.7)
pro2 <- procuste(macaca$xy1, macaca$xy2)
s.match(pro2$tab2, pro2$rot1, clab = 0.7)
par(mfrow = c(1,1))
}
\keyword{datasets}
