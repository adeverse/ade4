\name{ktab.data.frame}
\alias{ktab.data.frame}
\title{Creation of K-tables from a Data Frame}
\description{
creates k tables from a data frame. 
}
\usage{
ktab.data.frame(df, blocks, rownames = NULL, colnames = NULL, 
    tabnames = NULL, w.row = rep(1, nrow(df)) / nrow(df), 
    w.col = rep(1, ncol(df)))
}
\arguments{
  \item{df}{a data frame}
  \item{blocks}{an integer vector for which the sum must be the number of variables of df. Its length is the number of arrays of the K-tables}
  \item{rownames}{the row names of the K-tables (otherwise the row names of df)}
  \item{colnames}{the column names of the K-tables (otherwise the column names of df)}
  \item{tabnames}{the names of the arrays of the K-tables (otherwise "Ana1", "Ana2", …)}
  \item{w.row}{a vector of the row weightings}
  \item{w.col}{a vector of the column weightings}
}
\value{
returns a list of class 'ktab'. See \code{\link{ktab}}.
}
\examples{
data(escopage)
wescopage <- data.frame(scalewt(escopage$tab))
wescopage <- ktab.data.frame(wescopage, escopage$blo,
		tabnames = escopage$tab.names)
plot(sepan(wescopage))
data(friday87)
w <- data.frame(scale(friday87$fau, scal = FALSE))
w <- ktab.data.frame(w, friday87$fau.blo, tabnames = friday87$tab.names)
kplot(sepan(w))
}
\keyword{multivariate}
