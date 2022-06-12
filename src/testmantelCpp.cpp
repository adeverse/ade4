#include <RcppArmadillo.h>
using namespace arma;

#include <Rcpp.h>

// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
arma::vec testmantelCpp(const int npermut, const arma::mat & m1, const arma::mat & m2)
{
  /* Declarations de variables C locales */

  int         i, j, i0, j0, isel;
  double      trace, trace0, moy1, moy2, car1, car2, a0;
  
  int l1 = m1.n_cols;
  arma::vec inersim(npermut + 1);
  Rcpp::IntegerVector v1, pop(l1);

/* Calcul de la valeur observee */
  trace = 0;
  moy1 = 0; moy2=0; car1 = 0; car2 = 0;
  for (i=0; i<l1; i++) {
    for (j=0; j<l1; j++) {
      trace = trace + m1(i, j) * m2(i, j);
      if (j > i) {
		moy1 = moy1 + m1(i,j);
		moy2 = moy2 + m2(i,j);
		car1 = car1 + m1(i,j) * m1(i,j);
		car2 = car2 + m2(i,j) * m2(i,j);
      }
    }
  }
  trace = trace / 2;
  a0 = trace - moy1 * moy2 * 2 / l1 / (l1-1);
  a0 = a0 / sqrt((double) (car1 - moy1 * moy1 * 2 / l1 / (l1 - 1)));
  a0 = a0 / sqrt((double) (car2 - moy2 * moy2 * 2 / l1 / (l1 - 1)) );
  trace = a0;
    
  inersim(0) = a0;

/* Calcul des permutations */
 for (i=0; i<l1; i++) pop(i) = i;	
 for (isel=1; isel<=npermut; isel++) {
    v1 = sample(pop, l1);
    trace0 = 0;
    for (i=0; i<l1; i++) {
      i0 = v1(i);
      for (j=0; j<l1; j++) {
      	j0 = v1(j);
      	trace0 = trace0 + m1(i, j) * m2(i0, j0);
      }
    }
    trace0 = trace0 / 2;
    a0 = trace0 - moy1 * moy2 * 2 / l1 / (l1 - 1);
    a0 = a0 / sqrt((double) (car1 - moy1 * moy1 * 2 / l1 / (l1 - 1)));
    a0 = a0 / sqrt((double) (car2 - moy2 * moy2 * 2 / l1 / (l1 - 1)));
    inersim(isel) = a0;
  }
  return inersim;
}
