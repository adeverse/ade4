\name{dudi}
\alias{dudi}
\alias{as.dudi}
\alias{print.dudi}
\alias{t.dudi}
\alias{is.dudi}
\alias{redo.dudi}
\alias{summary.dudi}
\alias{[.dudi}
\title{Duality Diagram}
\description{
\code{as.dudi} is called by many functions (\code{dudi.pca}, \code{dudi.coa}, \code{dudi.acm}, ...) 
and not directly by the user. It creates duality diagrams.

\code{t.dudi} returns an object of class '\code{dudi}' where the rows are the columns and the columns are the rows
of the initial \code{dudi}. 

\code{is.dudi} returns TRUE if the object is of class \code{dudi} 

\code{redo.dudi} computes again an analysis, eventually changing the number of kept axes. Used by other functions.\cr
}
\usage{
as.dudi(df, col.w, row.w, scannf, nf, call, type, tol = 1e-07, 
    full = FALSE) 
\method{print}{dudi}(x, \dots) 
is.dudi(x) 
redo.dudi(dudi, newnf = 2) 
\method{t}{dudi}(x)
\method{summary}{dudi}(object, \dots) 
\method{[}{dudi}(x,i,j)
}
\arguments{
  \item{df}{a data frame with \emph{n} rows and \emph{p} columns}
  \item{col.w}{a numeric vector containing the row weights}
  \item{row.w}{a numeric vector containing the column weights}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{call}{generally \code{match.call()}}
  \item{type}{a string of characters : the returned list will be of class \code{c(type, "dudi")}}
  \item{tol}{a tolerance threshold for null eigenvalues (a value less than tol times the first one is considered as null)}
  \item{full}{a logical value indicating whether all non null eigenvalues should be kept}
  \item{x, dudi, object}{objects of class \code{dudi}}
  \item{\dots}{further arguments passed to or from other methods}
  \item{newnf}{an integer indicating the number of kept axes}
  \item{i,j}{elements to extract (integer or empty): index of rows (i) and columns (j)}
}
\value{
as.dudi and all the functions that use it return a list with the following components :
\item{tab}{a data frame with n rows and p columns}
\item{cw}{column weights, a vector with n components} 
\item{lw}{row (lines) weights, a vector with p components}
\item{eig}{eigenvalues, a vector with min(n,p) components}
\item{nf}{integer, number of kept axes}
\item{c1}{principal axes, data frame with p rows and nf columns}
\item{l1}{principal components, data frame with n rows and nf columns}
\item{co}{column coordinates, data frame with p rows and nf columns}
\item{li}{row coordinates, data frame with n rows and nf columns}
\item{call}{original call}
}
\references{Escoufier, Y. (1987) 
The duality diagram  : a means of better practical applications 
In \emph{Development in numerical ecology}, Legendre, P. & Legendre, L. (Eds.) 
NATO advanced Institute,  Serie G. Springer Verlag, Berlin,  139--156.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}\cr
Stephane Dray \email{stephane.dray@univ-lyon1.fr}
}
\examples{
data(deug)
dd1 <- dudi.pca(deug$tab, scannf = FALSE)
dd1
t(dd1)
is.dudi(dd1)
redo.dudi(dd1,3)
summary(dd1)
}
\keyword{multivariate}
