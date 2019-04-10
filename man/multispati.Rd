\name{multispati}
\alias{multispati}
\alias{plot.multispati}
\alias{summary.multispati}
\alias{print.multispati}
\title{Multivariate spatial analysis}
\description{
These functions are deprecated. See the function \code{multispati} and the methods \code{plot.multispati}, \code{summary.multispati} and \code{print.multispati} in the package \code{adespatial}.

This function ensures a multivariate extension of the univariate method of spatial autocorrelation analysis.
By accounting for the spatial dependence of data observations and their multivariate covariance simultaneously, 
complex interactions among many variables are analysed. Using a methodological scheme borrowed from duality diagram 
analysis, a strategy for the exploratory analysis of spatial pattern in the multivariate is developped.
}
\usage{
multispati(dudi, listw, scannf = TRUE, nfposi = 2, nfnega = 0)
\method{plot}{multispati}(x, xax = 1, yax = 2, ...) 
\method{summary}{multispati}(object, ...) 
\method{print}{multispati}(x, ...)
}
\arguments{
  \item{dudi}{an object of class \code{dudi} for the duality diagram analysis}
  \item{listw}{an object of class \code{listw} for the spatial dependence of data observations}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nfposi}{an integer indicating the number of kept positive axes}
  \item{nfnega}{an integer indicating the number of kept negative axes}
  \item{x, object}{an object of class \code{multispati}}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
This analysis generalizes the Wartenberg's multivariate spatial
correlation analysis to various duality diagrams created by the
functions (\code{dudi.pca}, \code{dudi.coa}, \code{dudi.acm}, \code{dudi.mix}...)
If \emph{dudi} is a duality diagram created by the function \code{dudi.pca} 
and \emph{listw} gives spatial weights created by a row normalized coding scheme,
the analysis is equivalent to Wartenberg's analysis. 

We note X the data frame with the variables, Q the column weights matrix 
and D the row weights matrix associated to the duality diagram \emph{dudi}.
We note L the neighbouring weights matrix associated to  \emph{listw}.
Then, the \code{'multispati'} analysis gives principal axes v that maximize
the product of spatial autocorrelation and inertia of row scores : 
\deqn{I(XQv)*\|XQv\|^2 = v^{t}Q^{t}X^{t}DLXQv}{I(XQv)*\|\|XQv\|\|^2 = t(v)t(Q)t(X)DLXQv}
}
\value{
Returns an object of class \code{multispati}, which contains the following elements :
	\item{eig}{a numeric vector containing the eigenvalues}
	\item{nfposi}{integer, number of kept axes associated to positive eigenvalues}
	\item{nfnega}{integer, number of kept axes associated to negative eigenvalues}
	\item{c1}{principle axes (v), data frame with p rows and (nfposi + nfnega) columns}
	\item{li}{principal components (XQv), data frame with n rows and (nfposi + nfnega) columns}
	\item{ls}{lag vector onto the principal axes (LXQv), data frame with n rows and (nfposi + nfnega) columns}
	\item{as}{principal axes of the dudi analysis (u) onto principal axes of multispati (t(u)Qv), data frame with dudi\$nf rows and (nfposi + nfnega) columns}
}
\references{
Dray, S., Said, S. and Debias, F. (2008) Spatial ordination of
vegetation data using a generalization of Wartenberg's  multivariate
spatial correlation. \emph{Journal of vegetation science}, \bold{19},
45--56.

  Grunsky, E. C. and Agterberg, F. P. (1988) Spatial and multivariate analysis of geochemical data from metavolcanic rocks in the Ben Nevis area, Ontario. \emph{Mathematical Geology}, \bold{20}, 825--861.
  
Switzer, P. and Green, A.A. (1984) Min/max autocorrelation factors for multivariate spatial imagery. Tech. rep. 6, Stanford University.

Thioulouse, J., Chessel, D. and Champely, S. (1995) Multivariate analysis of spatial patterns: a unified approach to local and global structures. \emph{Environmental and Ecological Statistics}, \bold{2}, 1--14.

Wartenberg, D. E. (1985) Multivariate spatial correlation: a method for
exploratory geographical analysis. \emph{Geographical Analysis},
\bold{17}, 263--283.

Jombart, T., Devillard, S., Dufour, A.-B. and Pontier, D. A
spatially explicit multivariate method to disentangle global and local
patterns of genetic variability. Submitted to \emph{Genetics}.
}
\author{Daniel Chessel  \cr
Sebastien Ollier \email{sebastien.ollier@u-psud.fr} \cr
Thibaut Jombart \email{t.jombart@imperial.ac.uk}

}
\seealso{\code{\link{dudi}},\code{\link[spdep]{mat2listw}}}
\examples{
\dontrun{
if (requireNamespace("spdep", quietly = TRUE)) {
    data(mafragh)
    maf.xy <- mafragh$xy
    maf.flo <- mafragh$flo
    maf.listw <- spdep::nb2listw(neig2nb(mafragh$neig))
    if(adegraphicsLoaded()) {
      g1 <- s.label(maf.xy, nb = neig2nb(mafragh$neig), plab.cex = 0.75)
    } else {
      s.label(maf.xy, neig = mafragh$neig, clab = 0.75)
    }
    maf.coa <- dudi.coa(maf.flo,scannf = FALSE)
    maf.coa.ms <- multispati(maf.coa, maf.listw, scannf = FALSE, nfposi = 2, nfnega = 2)
    maf.coa.ms
    
    ### detail eigenvalues components
    fgraph <- function(obj){
      # use multispati summary
      sum.obj <- summary(obj)
      # compute Imin and Imax
      L <- spdep::listw2mat(eval(as.list(obj$call)$listw))
      Imin <- min(eigen(0.5*(L+t(L)))$values)
      Imax <- max(eigen(0.5*(L+t(L)))$values)
      I0 <- -1/(nrow(obj$li)-1)
      # create labels
      labels <- lapply(1:length(obj$eig),function(i) bquote(lambda[.(i)]))
      # draw the plot
      xmax <- eval(as.list(obj$call)$dudi)$eig[1]*1.1
      par(las=1)
      var <- sum.obj[,2]
      moran <- sum.obj[,3]
      plot(x=var,y=moran,type='n',xlab='Inertia',ylab="Spatial autocorrelation (I)",
           xlim=c(0,xmax),ylim=c(Imin*1.1,Imax*1.1),yaxt='n')
      text(x=var,y=moran,do.call(expression,labels))
      ytick <- c(I0,round(seq(Imin,Imax,le=5),1))
      ytlab <- as.character(round(seq(Imin,Imax,le=5),1))
      ytlab <- c(as.character(round(I0,1)),as.character(round(Imin,1)),
           ytlab[2:4],as.character(round(Imax,1)))
      axis(side=2,at=ytick,labels=ytlab)
      rect(0,Imin,xmax,Imax,lty=2)
      segments(0,I0,xmax,I0,lty=2)
      abline(v=0)
      title("Spatial and inertia components of the eigenvalues")
    }
    fgraph(maf.coa.ms)
    ## end eigenvalues details


    if(adegraphicsLoaded()) {
      g2 <- s1d.barchart(maf.coa$eig, p1d.hori = FALSE, plot = FALSE)
      g3 <- s1d.barchart(maf.coa.ms$eig, p1d.hori = FALSE, plot = FALSE) 
      g4 <- s.corcircle(maf.coa.ms$as, plot = FALSE)
      G1 <- ADEgS(list(g2, g3, g4), layout = c(1, 3))
    } else {
      par(mfrow = c(1, 3))
      barplot(maf.coa$eig)
      barplot(maf.coa.ms$eig) 
      s.corcircle(maf.coa.ms$as)
      par(mfrow = c(1, 1))
    }
 
 
    if(adegraphicsLoaded()) {
      g5 <- s.value(maf.xy, -maf.coa$li[, 1], plot = FALSE)
      g6 <- s.value(maf.xy, -maf.coa$li[, 2], plot = FALSE)
      g7 <- s.value(maf.xy, maf.coa.ms$li[, 1], plot = FALSE)
      g8 <- s.value(maf.xy, maf.coa.ms$li[, 2], plot = FALSE)
      G2 <- ADEgS(list(g5, g6, g7, g8), layout = c(2, 2))
    } else {
      par(mfrow = c(2, 2))
      s.value(maf.xy, -maf.coa$li[, 1])
      s.value(maf.xy, -maf.coa$li[, 2])
      s.value(maf.xy, maf.coa.ms$li[, 1])
      s.value(maf.xy, maf.coa.ms$li[, 2])
      par(mfrow = c(1, 1))
    }


    w1 <- -maf.coa$li[, 1:2]
    w1m <- apply(w1, 2, spdep::lag.listw, x = maf.listw)
    w1.ms <- maf.coa.ms$li[, 1:2]
    w1.msm <- apply(w1.ms, 2, spdep::lag.listw, x = maf.listw)
    if(adegraphicsLoaded()) {
      g9 <- s.match(w1, w1m, plab.cex = 0.75, plot = FALSE)
      g10 <- s.match(w1.ms, w1.msm, plab.cex = 0.75, plot = FALSE)
      G3 <- cbindADEg(g9, g10, plot = TRUE)
    } else {
      par(mfrow = c(1,2))
      s.match(w1, w1m, clab = 0.75)
      s.match(w1.ms, w1.msm, clab = 0.75)
      par(mfrow = c(1, 1))
    }

    maf.pca <- dudi.pca(mafragh$env, scannf = FALSE)
    multispati.randtest(maf.pca, maf.listw)
    maf.pca.ms <- multispati(maf.pca, maf.listw, scannf=FALSE)
    plot(maf.pca.ms)
}
}}
\keyword{multivariate}
\keyword{spatial}
