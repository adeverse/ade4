\name{ktab.list.df}
\alias{ktab.list.df}
\title{Creating a K-tables from a list of data frames.
}
\description{
creates a list of class \code{ktab} from a list of data frames 
}
\usage{
ktab.list.df(obj, rownames = NULL, colnames = NULL, tabnames = NULL, 
    w.row = rep(1, nrow(obj[[1]])), w.col = lapply(obj, function(x) 
    rep(1 / ncol(x), ncol(x))))
}
\arguments{
  \item{obj}{a list of data frame}
  \item{rownames}{the names of the K-tables rows (otherwise, the row names of the arrays)}
  \item{colnames}{the names of the K-tables columns (otherwise, the column names of the arrays)}
  \item{tabnames}{the names of the arrays of the K-tables (otherwise, the names of the obj if they exist, or else "Ana1", "Ana2", \dots)}
  \item{w.row}{a vector of the row weightings in common with all the arrays}
  \item{w.col}{a list of the vector of the column weightings for each array}
}
\details{
Each element of the initial list have to possess the same names and row numbers
}
\value{
returns a list of class \code{ktab}. See \code{\link{ktab}}
}
\examples{
data(jv73)
l0 <- split(jv73$morpho, jv73$fac.riv)
l0 <- lapply(l0, function(x) data.frame(t(scalewt(x))))
kta <- ktab.list.df(l0)
kplot(sepan(kta[c(2,5,7,10)]), perm = TRUE, clab.r = 1, clab.c = 1.5)
}
\keyword{multivariate}
