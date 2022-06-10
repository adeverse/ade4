#include <RcppArmadillo.h>
using namespace arma;

#include <Rcpp.h>

// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
/************************************/
double inerbetweenCpp (const arma::vec& pl, const arma::vec& pc, const int moda, Rcpp::IntegerVector indica, const arma::mat& tab)
{
  int i, j, k, l1, rang;
  double poi, a0, a1, s1;
  double inerb;
 
  l1 = tab.n_rows;
  rang = tab.n_cols;
  
  arma::mat moy(moda, rang);
  arma::vec pcla(moda);
  
  for (i=0; i<l1; i++) { 
    k = indica(i)-1;
    poi = pl(i);
    pcla(k)=pcla(k)+poi;
  }


  for (i=0; i<l1; i++) {
    k = indica(i)-1;
    poi = pl(i);
    for (j=0; j<rang; j++) {
      moy(k, j) = moy(k, j) + tab(i, j) * poi;
    }
  }
    
  for (k=0; k<moda; k++) { 
    a0 = pcla(k);
    for (j=0; j<rang; j++) {
      moy(k, j) = moy(k, j) / a0;
    }
  }

  inerb = 0;
  for (i=0; i<moda; i++) {
    a1 = pcla(i);
    for (j=0; j<rang; j++) {
      s1 = moy(i, j);
      inerb = inerb + s1 * s1 *a1 * pc(j);
    }
  }
  return inerb;
}

// [[Rcpp::export]]
/************************************/
arma::vec testinterCpp(const int npermut,
                const arma::vec& pl,
                const arma::vec& pc,
                Rcpp::IntegerVector fac,
                const arma::mat& tab)
{
  /* Declarations de variables locales */

	arma::vec inersim(npermut+1);
	int i, j, k;
	int l1 = tab.n_rows;
	int c1 = tab.n_cols;
	arma::mat tabp(l1, c1);
	arma::vec plp(l1);

	Rcpp::CharacterVector faclevs = fac.attr("levels");
	int moda = faclevs.length();
	
	Rcpp::IntegerVector v1, pop(l1);

  /* Calculs
     inertie initiale est stockee dans le premier element du vecteur
     des simulations */
    
	inersim(0) = inerbetweenCpp(pl, pc, moda, fac, tab);
  
	for (i=0; i<l1; i++) pop(i) = i;	
	for (k=1; k<=npermut; k++) {
		v1 = sample(pop, l1);
		for (i=0; i<l1; i++) {
			plp(i) = pl(v1(i));
			for (j=0; j<c1; j++) {
				tabp(i, j) = tab(v1(i), j);
			}
		}
		inersim(k) = inerbetweenCpp(plp, pc, moda, fac, tabp);
	}
	return inersim;
}
