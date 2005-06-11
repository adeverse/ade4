\name{chats}
\alias{chats}
\docType{data}
\title{Pair of Variables}
\description{
This data set is a contingency table of age classes and fecundity classes of cats \emph{Felis catus}. 
}
\usage{data(chats)}
\format{
    \code{chats} is a data frame with 8 rows and 8 columns.\
    The 8 rows are age classes (age1, \dots, age8)\
    The 8 columns are fecundity classes (f0, f12, f34, \dots, fcd)\
    The values are cats numbers (contingency table).
}
\source{
Legay, J.M. and Pontier, D. (1985)
Relation âge-fécondité dans les populations de Chats domestiques, Felis catus.
\emph{Mammalia}, \bold{49}, 395--402.
}
\examples{
data(chats)
chatsw <- data.frame(t(chats))
chatscoa <- dudi.coa(chatsw, scann = FALSE)
par(mfrow = c(2,2))
table.cont(chatsw, abmean.x = TRUE, csi = 2, abline.x = TRUE, 
    clabel.r = 1.5, clabel.c = 1.5)
table.cont(chatsw, abmean.y = TRUE, csi = 2, abline.y = TRUE, 
    clabel.r = 1.5, clabel.c = 1.5)
table.cont(chatsw, x = chatscoa$c1[,1], y = chatscoa$l1[,1],
    abmean.x = TRUE, csi = 2, abline.x = TRUE, clabel.r = 1.5, 
    clabel.c = 1.5)
table.cont(chatsw,, x = chatscoa$c1[,1], y = chatscoa$l1[,1],
    abmean.y = TRUE, csi = 2, abline.y = TRUE, clabel.r = 1.5, 
    clabel.c = 1.5)
par(mfrow = c(1,1))}
\keyword{datasets}
