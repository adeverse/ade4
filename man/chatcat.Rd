\name{chatcat}
\alias{chatcat}
\non_function{}
\title{Qualitative Weighted Variables}
\description{
  This data set gives the age, the fecundity and the number of litters for 26 groups of cats. 
}
\usage{data(chatcat)}
\format{
\code{chatcat} is a list with two components :
    \describe{
    \item{tab}{is a data frame with 3 factors (age, feco, nport). }
    \item{eff}{is a vector of numbers. }
    }
}
\details{
one row of \code{tab} corresponds to one group of cats.\cr
The value in \code{eff} is the number of cats in this group
}
\source{
Pontier, D. (1984)\cr
Contribution à la biologie et à la génétique des populations de chats domestiques (Felis catus).\cr
Th"se de 3° cycle. Université Lyon 1, p. 67.
}
\examples{
data(chatcat)
summary(chatcat$tab)
w <- acm.disjonctif(chatcat$tab) #  Disjonctive table
names(w) <- c(paste("A", 1:5, sep = ""), paste("B", 1:5, sep = ""), 
    paste("C", 1:2, sep = ""))
w <- t(w*chatcat$num)%*%as.matrix(w)
w <- data.frame(w)
w # BURT table
}
\keyword{datasets}
