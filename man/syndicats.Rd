\name{syndicats}
\alias{syndicats}
\docType{data}
\title{Two Questions asked on a Sample of 1000 Respondents}
\description{
This data set is extracted from an opinion poll (period 1970-1980) on 1000 respondents. 
}
\usage{data(syndicats)}
\format{
The \code{syndicats} data frame has 5 rows and 4 columns.\cr
"Which politic family are you agreeing about?" has 5 response items : 
\code{extgauche} (extreme left) \code{left} \code{center} \code{right} and \code{extdroite} (extreme right)\cr
"What do you think of the trade importance?" has 4 response items :
\code{trop} (too important) \code{adequate} \code{insufficient} \code{nesaispas} (no opinion)
}
\source{
 unknown
}
\examples{
data(syndicats)
par(mfrow = c(1,2))
dudi1 <- dudi.coa(syndicats, scan = FALSE)
score (dudi1, 1, TRUE)
score (dudi1, 1, FALSE)
}
\keyword{datasets}
