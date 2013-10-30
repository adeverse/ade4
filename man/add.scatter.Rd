\name{add.scatter}
\alias{add.scatter}
\alias{add.scatter.eig}
\title{Add graphics to an existing plot}
\description{
  \code{add.scatter} is a function which defines a new plot area within an existing plot and displays an additional graphicinside this area. The additional graphic is determined by a function which is the first argument taken by \code{add.scatter}. It can be used in various ways, for instance to add a screeplot to an ordination scatterplot (\code{add.scatter.eig}).\cr
  The function \code{add.scatter.eig} uses the following colors: black (represented axes), grey(axes retained in the analysis) and white (others).
}
\usage{
add.scatter(func,posi=c("bottomleft","bottomright","topleft","topright"),ratio=.2,inset=.01,bg.col='white')
add.scatter.eig(w,nf=NULL, xax, yax, posi = "bottomleft", ratio = .25, inset = .01, sub="Eigenvalues",csub=2*ratio)
}
\arguments{
  \item{func}{an - evaluated - function producing a graphic}
  \item{posi}{a character vector (only its first element being
    considered) giving the position of the added graph. Possible values
    are "bottomleft" (="bottom"),"bottomright","topleft"
    (="top"),"topright", and "none" (no plot).}
  \item{ratio}{the size of the added graph in proportion of the current
    plot region}
  \item{inset}{the inset from which the graph is drawn, in proportion of the whole
    plot region. Can be a vector of length 2, giving the inset in x and y. If atomic, same inset is
    used in x and y}
  \item{bg.col}{the color of the background of the added graph}
  \item{w}{numeric vector of eigenvalues}
  \item{nf}{the number of retained factors, NULL if not provided}
  \item{xax}{first represented axis}
  \item{yax}{second represented axis}
  \item{sub}{title of the screeplot}
  \item{csub}{size of the screeplot title}
}
\value{
The matched call (invisible).
}
\details{
  \code{add.scatter} uses \code{par("plt")} to redefine the new plot region.
  As stated in \code{par} documentation, this produces to (sometimes
  surprising) interactions with other parameters such as "mar".
  In particular, such interactions are likely to reset the plot region
  by default which would cause the additional graphic to take the whole
  plot region. To avoid such inconvenient, add \code{par([other
    options], plt=par("plt"))} when using \code{par} in your graphical
  function (argument \code{func}).
}
\seealso{\code{\link{scatter}}
}
\author{Thibaut Jombart \email{jombart@biomserv.univ-lyon1.fr}}
\examples{
par(mfrow=c(2,2))

f1 <- function(a){
  opar=par("mar","xaxt","yaxt","plt")
  on.exit(par(opar))
  par(mar=rep(.1,4),xaxt="n",yaxt="n",plt=par("plt"))

  hist(a,xlab="",ylab="",main="",col="white",proba=TRUE)
  lines(seq(-4,4,le=50),dnorm(seq(-4,4,le=50)),col="red")
}

a <- rnorm(100)
barplot(sort(a))
add.scatter(f1(a),posi="topleft",bg.col="grey")

a <- rnorm(100)
barplot(sort(a))
add.scatter(f1(a),posi="topleft",bg.col="grey",inset=c(.25,.01))

a <- rnorm(100)
barplot(sort(a))
add.scatter(f1(a),posi="topleft",bg.col="grey",inset=.25,ratio=.1)

a <- rnorm(100)
barplot(sort(a))
add.scatter(f1(a),posi="bottomright",bg.col="grey",ratio=.3)

par(mfrow=c(1,1))

data(microsatt)
w <- dudi.coa(data.frame(t(microsatt$tab)), scann = FALSE,nf=3)
s.label(w$co)
ade4:::add.scatter.eig(w$eig,w$nf,posi="bottomright",1,2)
}
\keyword{multivariate}
\keyword{hplot}
