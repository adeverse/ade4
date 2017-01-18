\name{nipals}
\alias{nipals}
\alias{print.nipals}
\alias{scatter.nipals}

\title{Non-linear Iterative Partial Least Squares (NIPALS) algorithm}
\description{
 This function performs NIPALS algorithm, i.e. a principal component
 analysis of a data table that can contain missing values.
}
\usage{
nipals(df, nf = 2, rec = FALSE, niter = 100, tol = 1e-09)
\method{scatter}{nipals}(x, xax = 1, yax = 2, clab.row = 0.75, clab.col
= 1, posieig = "top", sub = NULL, ...)
\method{print}{nipals}(x, ...)
}

\arguments{
  \item{df}{a data frame that can contain missing values}
  \item{nf}{an integer, the number of axes to keep}
  \item{rec}{a logical that specify if the functions must perform the
    reconstitution of the data using the \code{nf} axes}
  \item{niter}{an integer, the maximum number of iterations}
  \item{tol}{a real, the tolerance used in the iterative algorithm}
  \item{x}{an object of class \code{nipals}}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{clab.row}{a character size for the rows}
  \item{clab.col}{a character size for the columns}
  \item{posieig}{if "top" the eigenvalues bar plot is upside, if "bottom" it is downside, if "none" no plot}
  \item{sub}{a string of characters to be inserted as legend}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
Data are scaled (mean 0 and variance 1) prior to the analysis.
}
\value{
Returns a list of classes \code{nipals}:
    \item{tab}{the scaled data frame}
    \item{eig}{the pseudoeigenvalues}
    \item{rank}{the rank of the analyzed matrice}
    \item{nf}{the number of factors}
    \item{c1}{the column normed scores}
    \item{co}{the column coordinates}
    \item{li}{the row coordinates}
    \item{call}{the call function}
    \item{nb}{the number of iterations for each axis}
    \item{rec}{a data frame obtained by the reconstitution of the scaled
      data using the \code{nf} axes}

}
\references{
  Wold, H. (1966)  Estimation of principal
  components and related models by iterative least squares. In
  P. Krishnaiah, editors.\emph{Multivariate
  Analysis}, Academic Press, 391--420.\cr\cr

  Wold, S., Esbensen, K. and Geladi, P. (1987) Principal component
  analysis \emph{Chemometrics and Intelligent Laboratory Systems},
  \bold{2}, 37--52.
  }

\author{Stéphane Dray \email{stephane.dray@univ-lyon1.fr}}
\seealso{\code{\link{dudi.pca}}}
\examples{
data(doubs)
## nipals is equivalent to dudi.pca when there are no NA
acp1 <- dudi.pca(doubs$env, scannf = FALSE, nf = 2)
nip1 <- nipals(doubs$env)


if(adegraphicsLoaded()) {
  if(requireNamespace("lattice", quietly = TRUE)) {
    g1 <- s1d.barchart(acp1$eig, psub.text = "dudi.pca", p1d.hori = F, plot = F)
    g2 <- s1d.barchart(nip1$eig, psub.text = "nipals", p1d.hori = F, plot = F)
    g3 <- xyplot(nip1$c1[, 1] ~ acp1$c1[, 1], main = "col scores", xlab = "dudi.pca", 
      ylab = "nipals")
    g4 <- xyplot(nip1$li[, 1] ~ acp1$li[, 1], main = "row scores", xlab = "dudi.pca", 
      ylab = "nipals")
    G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  }
  
} else {
  par(mfrow = c(2, 2))
  barplot(acp1$eig, main = "dudi.pca")
  barplot(nip1$eig, main = "nipals")
  plot(acp1$c1[, 1], nip1$c1[, 1], main = "col scores", xlab = "dudi.pca", ylab = "nipals")
  plot(acp1$li[, 1], nip1$li[, 1], main = "row scores", xlab = "dudi.pca", ylab = "nipals")
}

\dontrun{
## with NAs:
doubs$env[1, 1] <- NA
nip2 <- nipals(doubs$env)
cor(nip1$li, nip2$li)
nip1$eig
nip2$eig
}}

\keyword{multivariate}

