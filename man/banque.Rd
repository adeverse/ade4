\name{banque}
\alias{banque}
\docType{data}
\title{Table of Factors}
\description{
\code{banque} gives the results of a bank survey onto 810 customers. 
}
\usage{data(banque)}
\format{
  This data frame contains the following columns:
  \describe{
    \item{csp}{: "Socio-professional categories" a factor with levels 
        \code{agric} Farmers 
    	\code{artis} Craftsmen, Shopkeepers, Company directors 
    	\code{cadsu} Executives and higher intellectual professions 
    	\code{inter} Intermediate professions 
        \code{emplo} Other white-collar workers 
        \code{ouvri} Manual workers 
        \code{retra} Pensionners 
    	\code{inact} Non working population 
        \code{etudi} Students} 

    \item{duree}{: "Time relations with the customer" a factor with levels 
        \code{dm2} <2 years 
        \code{d24} [2 years, 4 years[ 
        \code{d48} [4 years, 8 years[ 
        \code{d812} [8 years, 12 years[ 
        \code{dp12} >= 12 years}
	
    \item{oppo}{: "Stopped a check ?" a factor with levels 
        \code{non} no 
        \code{oui} yes}
	
    \item{age}{: "Customer's age" a factor with levels 
        \code{ai25} [18 years, 25 years[ 
        \code{ai35} [25 years, 35 years[
        \code{ai45} [35 years, 45 years[ 
        \code{ai55} [45 years, 55 years[ 
        \code{ai75} [55 years, 75 years[}
	
    \item{sexe}{: "Customer's gender" a factor with levels 
        \code{hom} Male 
        \code{fem} Female}
	
    \item{interdit}{: "No checkbook allowed" a factor with levels
        \code{non} no 
        \code{oui} yes }
	
    \item{cableue}{: "Possess a bank card ?" a factor with levels 
        \code{non} no 
        \code{oui} yes }
	
    \item{assurvi}{: "Contrat of life insurance ?" a factor with levels 
        \code{non} no\cr
        \code{oui} yes}
	
    \item{soldevu}{: "Balance of the current accounts" a factor with levels 
        \code{p4} credit balance > 20000 
        \code{p3} credit balance 12000-20000 
        \code{p2} credit balance 4000-120000 
        \code{p1} credit balance >0-4000 
        \code{n1} debit balance  0-4000 
        \code{n2} debit balance >4000  }
	
    \item{eparlog}{: "Savings and loan association account amount" a factor with levels 
        \code{for} > 20000 
        \code{fai} >0 et <20000 
        \code{nul} nulle  }
	
    \item{eparliv}{: "Savings bank amount" a factor with levels 
        \code{for} > 20000 
        \code{fai} >0 et <20000 
        \code{nul} nulle  }
	
    \item{credhab}{: "Home loan owner" a factor with levels 
        \code{non} no 
        \code{oui} yes  }
	
    \item{credcon}{: "Consumer credit amount" a factor with levels 
        \code{nul} none 
        \code{fai} >0 and <20000 
        \code{for} > 20000  }
	
    \item{versesp}{: "Check deposits" a factor with levels 
        \code{oui} yes 
        \code{non} no  }
	
    \item{retresp}{: "Cash withdrawals" a factor with levels 
        \code{fai} < 2000 
        \code{moy} 2000-5000 
        \code{for} > 5000  }
	
    \item{remiche}{: "Endorsed checks amount" a factor with levels 
        \code{for} >10000 
        \code{moy} 10000-5000 
        \code{fai} 1-5000 
        \code{nul} none  }
	
    \item{preltre}{: "Treasury Department tax deductions" a factor with levels 
        \code{nul} none 
        \code{fai} <1000 
        \code{moy} >1000  }
	
    \item{prelfin}{: "Financial institution deductions" a factor with levels 
        \code{nul} none 
        \code{fai} <1000 
        \code{moy} >1000  }
	
    \item{viredeb}{: "Debit transfer amount" a factor with levels 
        \code{nul} none 
        \code{fai} <2500 
        \code{moy} 2500-5000 
        \code{for} >5000  }
	
    \item{virecre}{: "Credit transfer amount" a factor with levels 
        \code{for} >10000 
        \code{moy} 10000-5000 
        \code{fai} <5000 
        \code{nul} aucun  }
	
    \item{porttit}{: "Securities portfolio estimations" a factor with levels 
        \code{nul} none 
        \code{fai} < 20000 
        \code{moy} 20000-100000 
        \code{for} >100000  }
  }
}
\source{
 anonymous
}
\examples{
data(banque)
banque.acm <- dudi.acm(banque, scann = FALSE, nf = 3)
apply(banque.acm$cr, 2, mean)
banque.acm$eig[1:banque.acm$nf] # the same thing
s.arrow(banque.acm$c1, clab = 0.75)
}
\keyword{datasets}
