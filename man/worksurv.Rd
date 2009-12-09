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
    \item pro: Professional elections. In professional elections in your firm, would you rather vote for a list supported by?
      \itemize{
	\item \code{CGT}
      \item \code{CFDT}
      \item \code{FO}
      \item \code{CFTC}
      \item \code{Auton} Autonomous
      \item \code{Abst}
      \item \code{Nonaffi} Not affiliated
      \item \code{NR} No response}
 
    \item una: Union affiliation. At the present time, are you affiliated to a Union, and in the affirmative, which one?
      \itemize{
	\item \code{CGT}
      \item \code{CFDT}
      \item \code{FO}
      \item \code{CFTC}
      \item \code{Auton} Autonomous
      \item \code{CGC}
      \item \code{Notaffi} Not affiliated
      \item \code{NR} No response}

    \item pre: Presidential election. On the last presidential election
      (1969), can you tell me the candidate for whom you havevoted?
      \itemize{
      \item \code{Duclos}
      \item \code{Deferre}
      \item \code{Krivine}
      \item \code{Rocard}
      \item \code{Poher}
      \item \code{Ducatel}
      \item \code{Pompidou}
      \item \code{NRAbs} No response, abstention}
    
    \item pol: political sympathy. Which political party do you feel closest to, as a rule ?
      \itemize{
	\item \code{Communist} (PCF)
      \item \code{Socialist} (SFIO+PSU+FGDS)
      \item \code{Left} (Party of workers,\dots)
      \item \code{Center} MRP+RAD.
      \item \code{RI}
      \item \code{Right} INDEP.+CNI
      \item \code{Gaullist} UNR
      \item \code{NR} No response}
    
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
