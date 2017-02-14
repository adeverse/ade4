\name{combine.4thcorner}
\alias{combine.randtest.rlq}
\alias{combine.4thcorner}
\alias{p.adjust.4thcorner}

\title{Functions to combine and adjust the outputs 3-table methods}
\description{Functions to combine and adjust the outputs of the \code{fourthcorner} and
  \code{randtest.rlq} functions created using permutational models 2 and
  4 (sequential approach).
}
\usage{
combine.randtest.rlq(obj1, obj2, ...)
combine.4thcorner(four1,four2)
p.adjust.4thcorner(x, p.adjust.method.G = p.adjust.methods,
p.adjust.method.D = p.adjust.methods, p.adjust.D = c("global",
"levels"))
}

\arguments{
   \item{four1}{ an object of the class 4thcorner created with
   modeltype = 2 (or 4)}
  \item{four2}{ an object of the class 4thcorner created with
   modeltype = 4 (or 2)}
  \item{obj1}{an object created with \code{randtest.rlq} and
   modeltype = 2 (or 4)}
  \item{obj2}{an object  created with \code{randtest.rlq} and
    modeltype = 4 (or 2)}
  \item{x}{ an object of the class 4thcorner}
  \item{p.adjust.method.G}{a string indicating a method for multiple
    adjustment used for output tabG, see \code{\link[stats]{p.adjust.methods}} for possible choices}
  \item{p.adjust.method.D}{a string indicating a method for multiple
    adjustment used for output tabD/tabD2, see \code{p.adjust.methods} for possible choices}
  \item{p.adjust.D}{a string indicating if multiple adjustment for
  tabD/tabD2 should be done globally or only between levels of a factor
  ("levels", as in the original paper of Legendre et al. 1997)}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{

  The functions combines the outputs of two objects (created by
  \code{fourthcorner} and \code{randtest.rlq} functions) as described in
  Dray and Legendre (2008) and ter Braak et al (2012).
}
\value{
  The functions return objects of the same class than their
  argument. They simply create a  new object where pvalues are equal to the
  maximum of pvalues of the two arguments.
}
\references{
  Dray, S. and Legendre, P. (2008) 
  Testing the species traits-environment relationships: the fourth-corner
  problem revisited. \emph{Ecology},
  \bold{89}, 3400--3412.
  
  ter Braak, C., Cormont, A., and Dray, S. (2012)
  Improved testing of species traits-environment relationships in the
  fourth corner problem. \emph{Ecology}, \bold{93}, 1525--1526.
}
\author{Stéphane Dray \email{stephane.dray@univ-lyon1.fr}}

\seealso{
\code{\link{rlq}}, \code{\link{fourthcorner}}, \code{\link[stats]{p.adjust.methods}}
}
\examples{
data(aravo)
four2 <- fourthcorner(aravo$env, aravo$spe, aravo$traits, nrepet=99,modeltype=2)
four4 <- fourthcorner(aravo$env, aravo$spe, aravo$traits, nrepet=99,modeltype=4)
four.comb <- combine.4thcorner(four2,four4)
## or directly :
## four.comb <- fourthcorner(aravo$env, aravo$spe, aravo$traits, nrepet=99,modeltype=6)
summary(four.comb)
plot(four.comb, stat = "G")

}


\keyword{ multivariate }
