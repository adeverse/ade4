\name{ktab}
\alias{ktab}
\alias{is.ktab}
\alias{c.ktab}
\alias{[.ktab}
\alias{print.ktab}
\alias{t.ktab}
\alias{row.names.ktab}
\alias{row.names<-.ktab}
\alias{col.names}
\alias{col.names.ktab}
\alias{col.names<-}
\alias{col.names<-.ktab}
\alias{tab.names}
\alias{tab.names.ktab}
\alias{tab.names<-}
\alias{tab.names<-.ktab}
\alias{ktab.util.names}
\alias{ktab.util.addfactor}
\title{the class of objects 'ktab' (K-tables)}
\description{
an object of class \code{ktab} is a list of data frames with the same row.names in common.\cr
a list of class 'ktab' contains moreover :
\describe{
 \item{blo}{: the vector of the numbers of columns for each table}
 \item{lw}{: the vector of the row weightings in common for all tables}
 \item{cw}{: the vector of the column weightings}
 \item{TL}{: a data frame of two components to manage the parameter positions associated with the rows of tables}
 \item{TC}{: a data frame of two components to manage the parameter positions associated with the columns of tables}
 \item{T4}{: a data frame of two components to manage the parameter positions of 4 components associated to an array}
}
}
\usage{
\method{c}{ktab}(...)
\method{[}{ktab}(x,i,j,k)
is.ktab(x)
\method{t}{ktab}(x)
\method{row.names}{ktab}(x)
\method{col.names}{ktab}(x)
tab.names(x)
col.names(x)
ktab.util.names(x)
}
\arguments{
  \item{x}{an object of the class \code{ktab}}
  \item{\dots}{a sequence of objects of the class \code{ktab}}
  \item{i,j,k}{elements to extract (integer or empty): index of tables (i), rows (j) and columns (k)}
}
\details{
A 'ktab' object can be created with :\cr
    a list of data frame : \code{\link{ktab.list.df}}\cr
    a list of \code{dudi} objects : \code{\link{ktab.list.dudi}}\cr
    a data.frame : \code{\link{ktab.data.frame}}\cr
    an object \code{within} : \code{\link{ktab.within}}\cr
    a couple of \code{ktab}s : \code{\link{ktab.match2ktabs}}\cr
}
\value{
\code{c.ktab} returns an object \code{ktab}. It concatenates K-tables with the same rows in common. \cr
\code{t.ktab} returns an object \code{ktab}. It permutes each data frame into a K-tables. All tables have the same column names and the same column weightings (a data cube). \cr
\code{"["} returns an object \code{ktab}. It allows to select some arrays in a K-tables. \cr
\code{is.ktab} returns TRUE if x is a K-tables. \cr
\code{row.names} returns the vector of the row names common with all the tables of a K-tables and allowes to modifie them.\cr
\code{col.names} returns the vector of the column names of a K-tables and allowes to modifie them.\cr
\code{tab.names} returns the vector of the array names of a K-tables and allowes to modifie them.\cr
\code{ktab.util.names} is a useful function.
}
\author{
Daniel Chessel \cr
Anne-Béatrice Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
Stéphane Dray \email{stephane.dray@univ-lyon1.fr}
}
\examples{
data(friday87)
wfri <- data.frame(scale(friday87$fau, scal = FALSE))
wfri <- ktab.data.frame(wfri, friday87$fau.blo)
wfri[2:4, 1:5, 1:3]
c(wfri[2:4], wfri[5])

data(meaudret)
wit1 <- withinpca(meaudret$env, meaudret$design$season, scan = FALSE, 
    scal = "partial")
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5"), 4))
kta2 <- t(kta1)

if(adegraphicsLoaded()) {
  kplot(sepan(kta2), row.plab.cex = 1.5, col.plab.cex = 0.75)
} else {
  kplot(sepan(kta2), clab.r = 1.5, clab.c = 0.75)
}
}
\keyword{multivariate}
