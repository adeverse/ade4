\name{table.cont}
\alias{table.cont}
\title{Plot of Contingency Tables}
\description{
presents a graph for viewing contingency tables. 
}
\usage{
table.cont(df, x = 1:ncol(df), y = 1:nrow(df),
    row.labels = row.names(df), col.labels = names(df),
    clabel.row = 1, clabel.col = 1, abmean.x = FALSE, abline.x = FALSE,
    abmean.y = FALSE, abline.y = FALSE, csize = 1, clegend = 0, grid = TRUE)
}
\arguments{
  \item{df}{a data frame with only positive or null values}
  \item{x}{a vector of values to position the columns}
  \item{y}{a vector of values to position the rows}
  \item{row.labels}{a character vector for the row labels}
  \item{col.labels}{a character vetor for the column labels}
  \item{clabel.row}{a character size for the row labels}
  \item{clabel.col}{a character size for the column labels}
  \item{abmean.x}{a logical value indicating whether the column conditional means should be drawn}
  \item{abline.x}{a logical value indicating whether the regression line of y onto x should be plotted}
  \item{abmean.y}{a logical value indicating whether the row conditional means should be drawn}
  \item{abline.y}{a logical value indicating whether the regression line of x onto y should be plotted}
  \item{csize}{a coefficient for the square size of the values}
  \item{clegend}{if not NULL, a character size for the legend used with  \code{par("cex")*clegend}}
  \item{grid}{a logical value indicating whether a grid in the background of the plot should be drawn}
}
\examples{
data(chats)
chatsw <- data.frame(t(chats))
chatscoa <- dudi.coa(chatsw, scann = FALSE)
table.cont(chatsw)

par(mfrow = c(2,2))
table.cont(chatsw, abmean.x = TRUE, csi = 2, abline.x = TRUE, 
    clabel.r = 1.5, clabel.c = 1.5)
table.cont(chatsw, abmean.y = TRUE, csi = 2, abline.y = TRUE, 
    clabel.r = 1.5, clabel.c = 1.5)
table.cont(chatsw, x = chatscoa$c1[,1], y = chatscoa$l1[,1],
    abmean.x = TRUE, csi = 2, abline.x = TRUE, clabel.r = 1.5, clabel.c = 1.5)
table.cont(chatsw, x = chatscoa$c1[,1], y = chatscoa$l1[,1],
    abmean.y = TRUE, csi = 2, abline.y = TRUE, clabel.r = 1.5, clabel.c = 1.5)

data(rpjdl)
w <- data.frame(t(rpjdl$fau))
wcoa <- dudi.coa(w, scann = FALSE)
par(mfrow = c(1,1))
table.cont(w, abmean.y = TRUE, x = wcoa$c1[,1], y = rank(wcoa$l1[,1]),
    csi = 0.2, clabel.c = 0, row.labels = rpjdl$lalab, clabel.r = 0.75)
}
\keyword{hplot}
