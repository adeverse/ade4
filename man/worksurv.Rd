\encoding{latin1}
\name{worksurv}
\alias{worksurv}
\docType{data}
\title{French Worker Survey (1970)}
\description{
The \code{worksurv} data frame gives 319 response items and 4 questions 
providing from a French Worker Survey. 
}
\usage{data(worksurv)}
\format{
  This data frame contains the following columns:
  \enumerate{
    \item{pro}{Professional elections. In professional elections in your firm, would you rather vote for a list supported by?
   \code{CGT}
      \code{CFDT}
      \code{FO}
      \code{CFTC}
      \code{Auton} Autonomous
      \code{Abst}
      \code{Nonaffi} Not affiliated
      \code{NR} No response}
    \item{una}{Union affiliation. At the present time, are you affiliated to a Union, and in the affirmative, which one?
      \code{CGT}
      \code{CFDT}
      \code{FO}
      \code{CFTC}
      \code{Auton} Autonomous
      \code{CGC}
      \code{Notaffi} Not affiliated
      \code{NR} No response}
    \item{pre}{Presidential election. On the last presidential election (1969), can you tell me the candidate for whom you have voted?
      \code{Duclos}
      \code{Deferre}
      \code{Krivine}
      \code{Rocard}
      \code{Poher}
      \code{Ducatel}
      \code{Pompidou}
      \code{NRAbs} No response, abstention}
    \item{pol}{political sympathy. Which political party do you feel closest to, as a rule ?
      \code{Communist} (PCF)
      \code{Socialist} (SFIO+PSU+FGDS)
      \code{Left} (Party of workers",\dots)
      \code{Center} MRP+RAD.
      \code{RI}
      \code{Right} INDEP.+CNI
      \code{Gaullist} UNR
      \code{NR} No response}
  }
}
\details{
The data frame \code{worksurv} has the attribute 'counts' giving the number of responses for each item.
}
\source{
Rouanet, H. and Le Roux, B. (1993) 
\emph{Analyse des données multidimensionnelles}. Dunod, Paris.
}
\references{
Le Roux, B. and Rouanet, H.  (1997) 
Interpreting axes in multiple correspondence analysis: method of the contributions of points and deviation. 
Pages 197-220 in B. J. and M. Greenacre, editors. 
\emph{Visualization of categorical data}, Acamedic Press, London.
}
\examples{
data(worksurv)
acm1 <- dudi.acm(worksurv, row.w = attr(worksurv,"counts"), 
    scan = FALSE)
par(mfrow = c(2,2))
apply(worksurv,2, function(x) s.class(acm1$li, factor(x),
    attr(worksurv, 'counts')))
}
\keyword{datasets}
