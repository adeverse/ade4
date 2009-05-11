\encoding{latin1}
\name{dist.binary}
\alias{dist.binary}
\title{Computation of Distance Matrices for Binary Data}
\description{
computes for binary data some distance matrice. 
}
\usage{
dist.binary(df, method = NULL, diag = FALSE, upper = FALSE)
}
\arguments{
  \item{df}{a matrix or a data frame with positive or null numeric values. Used with \code{as.matrix(1 * (df > 0))}}
  \item{method}{an integer between 1 and 10 . If NULL the choice is made with a console message. See details}
  \item{diag}{a logical value indicating whether the diagonal of the distance matrix should be printed by `print.dist'}
  \item{upper}{a logical value indicating whether the upper triangle of the distance matrix should be printed by `print.dist'}
}
\details{
Let be the contingency table of binary data such as \eqn{n_{11} = a}{n11 = a}, \eqn{n_{10} = b}{n10 = b}, \eqn{n_{01} = c}{n01 = c} 
and \eqn{n_{00} = d}{n00 = d}. All these distances are of type \eqn{d=\sqrt{1-s}}{d = sqrt(1 - s)} with \emph{s} a similarity coefficient.
\describe{
\item{1 = Jaccard index (1901)}{S3 coefficient of Gower & Legendre \eqn{s_1 = \frac{a}{a+b+c}}{s1 = a / (a+b+c)}}
\item{2 = Sockal & Michener index (1958)}{S4 coefficient of Gower & Legendre \eqn{s_2 =\frac{a+d}{a+b+c+d}}{s2 = (a+d) / (a+b+c+d)}}
\item{3 = Sockal & Sneath(1963)}{S5 coefficient of Gower & Legendre \eqn{s_3 =\frac{a}{a+2(b+c)}}{s3 = a / (a + 2(b + c))}}
\item{4 = Rogers & Tanimoto (1960)}{S6 coefficient of Gower & Legendre \eqn{s_4 =\frac{a+d}{(a+2(b+c)+d)}}{s4 = (a + d) / (a + 2(b + c) +d)}}
\item{5 = Czekanowski (1913) or Sorensen (1948)}{S7 coefficient of Gower & Legendre \eqn{s_5 =\frac{2a}{2a+b+c}}{s5 = 2a / (2a + b + c)}}
\item{6 = S9 index of Gower & Legendre (1986)}{\eqn{s_6 =\frac{a-(b+c)+d}{a+b+c+d}}{s6 = (a - (b + c) + d) / (a + b + c + d)}}
\item{7 = Ochiai (1957)}{S12 coefficient of Gower & Legendre \eqn{s_7 =\frac{a}{\sqrt{(a+b)(a+c)}}}{s7 = a / sqrt((a + b)(a + c))}}
\item{8 = Sockal & Sneath (1963)}{S13 coefficient of Gower & Legendre \eqn{s_8 =\frac{ad}{\sqrt{(a+b)(a+c)(d+b)(d+c)}}}{s8 = ad / sqrt((a + b)(a + c)(d + b)(d + c))}}
\item{9 = Phi of Pearson}{S14 coefficient of Gower & Legendre \eqn{s_9 =\frac{ad-bc}{\sqrt{(a+b)(a+c)(b+d)(d+c)}}}{s9 = (ad - bc) / sqrt((a + b)(a + c)(d + b)(d + c))}}
\item{10 = S2 coefficient of Gower & Legendre}{\eqn{s_1 = \frac{a}{a+b+c+d}}{s10 = a / (a + b + c + d)}}
}
}
\value{
returns a distance matrix of class \code{dist} between the rows of the data frame
}
\references{Gower, J.C. and Legendre, P. (1986) Metric and Euclidean properties of dissimilarity coefficients. 
\emph{Journal of Classification}, \bold{3}, 5--48.
}
\author{
Daniel Chessel  \cr
Stéphane Dray \email{dray@biomserv.univ-lyon1.fr}
}
\examples{
data(aviurba)
for (i in 1:10) {
    d <- dist.binary(aviurba$fau, method = i)
    cat(attr(d, "method"), is.euclid(d), "\n")}
}
\keyword{array}
\keyword{multivariate}
