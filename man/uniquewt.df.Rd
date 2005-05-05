\name{uniquewt.df}
\alias{uniquewt.df}
\title{Elimination of Duplicated Rows in a Array}
\description{
An utility function to eliminate the duplicated rows in a array. 
}
\usage{
uniquewt.df(x)
}
\arguments{
  \item{x}{a data frame which contains duplicated rows}
}
\value{
The function returns a \code{y} which contains once each duplicated row of \code{x}.\cr
\code{y} is an attribut 'factor' which gives the number of the row of \code{y} in which each row of \code{x} is found\cr
\code{y} is an attribut 'length.class' which gives the number of duplicates in \code{x} with an attribut of each row of \code{y} with an attribut
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} \cr
\examples{
data(ecomor)
forsub.r <- uniquewt.df(ecomor$forsub)
attr(forsub.r, "factor")
forsub.r[1,]
ecomor$forsub[126,] #idem

dudi.pca(ecomor$forsub, scale = FALSE, scann = FALSE)$eig
# [1] 0.36845 0.24340 0.15855 0.09052 0.07970 0.04490
w1 <- attr(forsub.r, "len.class") / sum(attr(forsub.r,"len.class"))
dudi.pca(forsub.r, row.w = w1, scale = FALSE, scann = FALSE)$eig
# [1] 0.36845 0.24340 0.15855 0.09052 0.07970 0.04490
}
\keyword{utilities}
