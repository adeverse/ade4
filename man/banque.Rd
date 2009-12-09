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
  \enumerate{
    \item csp: "Socio-professional categories" a factor with levels 
    \itemize{
      \item \code{agric} Farmers 
      \item \code{artis} Craftsmen, Shopkeepers, Company directors 
      \item \code{cadsu} Executives and higher intellectual professions 
      \item \code{inter} Intermediate professions 
      \item \code{emplo} Other white-collar workers 
      \item \code{ouvri} Manual workers 
      \item \code{retra} Pensionners 
      \item \code{inact} Non working population 
      \item \code{etudi} Students} 
    
    \item duree: "Time relations with the customer" a factor with levels 
    \itemize{
      \item \code{dm2} <2 years 
      \item \code{d24} [2 years, 4 years[ 
      \item \code{d48} [4 years, 8 years[ 
      \item \code{d812} [8 years, 12 years[ 
      \item \code{dp12} >= 12 years}
    
    \item oppo: "Stopped a check ?" a factor with levels
    \itemize{
      \item \code{non} no 
      \item \code{oui} yes}
    
    \item age: "Customer's age" a factor with levels 
    \itemize{
      \item \code{ai25} [18 years, 25 years[ 
      \item \code{ai35} [25 years, 35 years[
      \item \code{ai45} [35 years, 45 years[ 
      \item \code{ai55} [45 years, 55 years[ 
      \item \code{ai75} [55 years, 75 years[}
    
    \item sexe: "Customer's gender" a factor with levels 
    \itemize{
      \item \code{hom} Male 
      \item \code{fem} Female}
    
    \item interdit: "No checkbook allowed" a factor with levels
    \itemize{
      \item \code{non} no 
      \item \code{oui} yes }
    
    \item cableue: "Possess a bank card ?" a factor with levels 
    \itemize{
      \item \code{non} no 
      \item \code{oui} yes }
    
    \item assurvi: "Contrat of life insurance ?" a factor with levels 
    \itemize{
      \item \code{non} no\cr
      \item \code{oui} yes}
    
    \item soldevu: "Balance of the current accounts" a factor with levels 
    \itemize{
      \item \code{p4} credit balance > 20000 
      \item \code{p3} credit balance 12000-20000 
      \item \code{p2} credit balance 4000-120000 
      \item \code{p1} credit balance >0-4000 
      \item \code{n1} debit balance  0-4000 
      \item \code{n2} debit balance >4000  }
    
    \item eparlog: "Savings and loan association account amount" a factor with levels 
    \itemize{
      \item \code{for} > 20000 
      \item \code{fai} >0 and <20000 
      \item \code{nul} nulle  }
    
    \item eparliv: "Savings bank amount" a factor with levels 
    \itemize{
      \item \code{for} > 20000 
      \item \code{fai} >0 and <20000 
      \item \code{nul} nulle  }
    
    \item credhab: "Home loan owner" a factor with levels 
    \itemize{
      \item \code{non} no 
      \item \code{oui} yes  }
    
    \item credcon: "Consumer credit amount" a factor with levels 
    \itemize{
      \item \code{nul} none 
      \item \code{fai} >0 and <20000 
      \item \code{for} > 20000  }
    
    \item versesp: "Check deposits" a factor with levels 
    \itemize{
      \item \code{oui} yes 
      \item \code{non} no  }
    
    \item retresp: "Cash withdrawals" a factor with levels 
    \itemize{
      \item \code{fai} < 2000 
      \item \code{moy} 2000-5000 
      \item \code{for} > 5000  }
    
    \item remiche: "Endorsed checks amount" a factor with levels 
    \itemize{
      \item \code{for} >10000 
      \item \code{moy} 10000-5000 
      \item \code{fai} 1-5000 
      \item \code{nul} none  }
    
    \item preltre: "Treasury Department tax deductions" a factor with levels 
    \itemize{
      \item \code{nul} none 
      \item \code{fai} <1000 
      \item \code{moy} >1000  }
    
    \item prelfin: "Financial institution deductions" a factor with levels 
    \itemize{
      \item \code{nul} none 
      \item \code{fai} <1000 
      \item \code{moy} >1000  }
    
    \item viredeb: "Debit transfer amount" a factor with levels 
    \itemize{
      \item \code{nul} none 
      \item \code{fai} <2500 
      \item \code{moy} 2500-5000 
      \item \code{for} >5000  }
    
    \item virecre: "Credit transfer amount" a factor with levels 
    \itemize{
      \item \code{for} >10000 
      \item \code{moy} 10000-5000 
      \item \code{fai} <5000 
      \item \code{nul} aucun  }
    
    \item porttit: "Securities portfolio estimations" a factor with levels 
    \itemize{
      \item \code{nul} none 
      \item \code{fai} < 20000 
      \item \code{moy} 20000-100000 
      \item \code{for} >100000  }
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
