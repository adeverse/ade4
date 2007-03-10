\name{dudi.pca}
\alias{dudi.pca}
\title{Principal Component Analysis}
\description{
\code{dudi.pca} performs a principal component analysis of a data frame and
returns the results as objects of class \code{pca} and \code{dudi}. 
}
\usage{
dudi.pca(df, row.w = rep(1, nrow(df))/nrow(df), 
    col.w = rep(1, ncol(df)), center = TRUE, scale = TRUE, 
    scannf = TRUE, nf = 2)
}
\arguments{
  \item{df}{a data frame with n rows (individuals) and p columns (numeric variables)}
  \item{row.w}{an optional row weights (by default, uniform row weights)}
  \item{col.w}{an optional column weights (by default, unit column weights)}
  \item{center}{a logical or numeric value, centring option\cr
    if TRUE, centring by the mean\cr
    if FALSE no centring\cr
    if a numeric vector, its length must be equal to the number of columns of the data frame df
    and gives the decentring}
  \item{scale}{a logical value indicating whether the column vectors should be normed for the row.w weighting}
  \item{scannf}{a logical value indicating whether the screeplot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
}
\value{
Returns a list of classes \code{pca} and \code{dudi} (see \link{dudi}) containing the used information
for computing the principal component analysis :
    \item{tab}{the data frame to be analyzed depending of the transformation arguments (center and scale)}
    \item{cw}{the column weights}
    \item{lw}{the row weights}
    \item{eig}{the eigenvalues}
    \item{rank}{the rank of the analyzed matrice}
    \item{nf}{the number of kept factors}
    \item{c1}{the column normed scores  i.e. the principal axes}
    \item{l1}{the row normed scores}
    \item{co}{the column coordinates}
    \item{li}{the row coordinates i.e. the principal components}
    \item{call}{the call function}
    \item{cent}{the \it{p} vector containing the means for variables}
    \item{norm}{the \it{p} vector containing the standard deviations for variables i.e. the root
    of the sum of squares deviations of the values from their means divided by \it{n}}
}
\seealso{
    \code{prcomp}, \code{princomp} in the \code{mva} library
}
\author{
Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}\cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(deug)
deug.dudi <- dudi.pca(deug$tab, center = deug$cent, 
    scale = FALSE, scan = FALSE)
par(mfrow = c(2,2))
s.class(deug.dudi$li, deug$result, cpoint = 1)
s.arrow(deug.dudi$c1, lab = names(deug$tab))
deug.dudi1 <- dudi.pca(deug$tab, center = TRUE, 
    scale = TRUE, scan = FALSE)
s.class(deug.dudi1$li, deug$result, cpoint = 1)
s.corcircle(deug.dudi1$co, lab = names(deug$tab), 
    full = FALSE, box = TRUE)
par(mfrow = c(1,1))

# for interpretations
par(mfrow = c(3,3))
par(mar = c(2.1,2.1,2.1,1.1))
for(i in 1:9) { 
hist(deug.dudi$tab[,i], xlim = c(-40,40), breaks = seq(-45, 35, by = 5), 
    prob = TRUE, right = FALSE, main = names(deug$tab)[i], xlab = "", 
    ylim = c(0,0.10))
abline(v = 0, lwd = 3)
}
par(mfrow = c(1,1))
}
\keyword{multivariate}
