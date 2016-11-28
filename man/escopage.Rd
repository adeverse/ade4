\name{escopage}
\alias{escopage}
\docType{data}
\title{K-tables of wine-tasting}
\description{
This data set describes 27 characteristics of 21 wines distributed in four fields : 
rest, visual, olfactory and global. 
}
\usage{data(escopage)}
\format{
    \code{escopage} is a list of 3 components.
    \describe{
        \item{tab}{is a data frame with 21 observations (wines) and 27 variables. }
        \item{tab.names}{is the vector of the names of sub-tables : "rest" "visual" "olfactory" "global".}
        \item{blo}{is a vector of the numbers of variables for each sub-table.}
    }
}
\source{
Escofier, B. and Pagès, J. (1990) 
\emph{Analyses factorielles simples et multiples : objectifs, méthodes et interprétation} 
Dunod, Paris. 1--267.

Escofier, B. and Pagès, J. (1994) 
Multiple factor analysis (AFMULT package). 
\emph{Computational Statistics and Data Analysis}, \bold{18}, 121--140.
}
\examples{
data(escopage)
w <- data.frame(scale(escopage$tab))
w <- ktab.data.frame(w, escopage$blo)
names(w)[1:4] <- escopage$tab.names
plot(mfa(w, scan = FALSE))
}
\keyword{datasets}
