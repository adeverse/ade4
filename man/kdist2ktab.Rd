\name{kdist2ktab}
\alias{kdist2ktab}
\title{ Transformation of K distance matrices (object 'kdist') into K Euclidean representations (object 'ktab') }
\description{
  The function creates a \code{ktab} object with the Euclidean representations from a \code{kdist} object. Notice that the euclid attribute must be TRUE for all elements.
}
\usage{
kdist2ktab(kd, scale = TRUE, tol = 1e-07)
}
\arguments{
  \item{kd}{ an object of class \code{kdist} }
  \item{scale}{ a logical value indicating whether the inertia of Euclidean representations are equal to 1 (TRUE) or not (FALSE).  }
  \item{tol}{ a tolerance threshold, an eigenvalue is considered equal to zero if \code{eig$values} > (\code{eig$values[1} * tol) }
}
\value{
returns a list of class \code{ktab} containing for each distance of \code{kd} the data frame of its Euclidean representation
}
\author{ Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}}
\examples{
data(friday87)
fri.w <- ktab.data.frame(friday87$fau, friday87$fau.blo, 
    tabnames = friday87$tab.names)
fri.kd <- lapply(1:10, function(x) dist.binary(fri.w[[x]], 10))
names(fri.kd) <-  substr(friday87$tab.names, 1, 4)
fri.kd <- kdist(fri.kd)
fri.ktab = kdist2ktab(kd = fri.kd)
fri.sepan = sepan(fri.ktab)
plot(fri.sepan, csub = 3)

tapply(fri.sepan$Eig, fri.sepan$TC[,1], sum)
# the sum of the eigenvalues is constant and equal to 1, for each K tables

fri.statis <- statis(fri.ktab, scan = FALSE, nf = 2)
round(fri.statis$RV, dig = 2)

fri.mfa <- mfa(fri.ktab, scan = FALSE, nf = 2)
fri.mcoa <- mcoa(fri.ktab, scan = FALSE, nf = 2)

apply(fri.statis$RV, 1, mean) 
fri.statis$RV.tabw 
plot(apply(fri.statis$RV, 1, mean), fri.statis$RV.tabw)
plot(fri.statis$RV.tabw, fri.statis$RV.tabw)
}
\keyword{ multivariate }
