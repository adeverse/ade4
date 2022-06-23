#include <RcppArmadillo.h>
using namespace arma;

#include <Rcpp.h>

// [[Rcpp::depends(RcppArmadillo)]]

#include <ade4.h>

// [[Rcpp::export]]
/*****************/
arma::vec testertracenuCpp(int npermut,
			arma::vec& pc1,
			arma::vec& pc2,
			const arma::vec& pl,
			arma::mat& tab1,
			arma::mat& tab2,
			arma::mat& tabinit1,
			arma::mat& tabinit2,
			const int typ1,
			const int typ2)
{
  /* Declarations des variables C locales */

  int     i, j, k, istep;
  double  poi, inertot, s1, inersim, a1;

	int l1 = tab1.n_rows;
	int c1 = tab1.n_cols;
	int c2 = tab2.n_cols;

	arma::mat cov(c2, c1);
	arma::mat ti1p(l1, c1);
	arma::mat ti2p(l1, c2);
	arma::vec inersimul(npermut+1);
	Rcpp::IntegerVector v1(l1), v2(l1), pop(l1);
	for (i=0; i<l1; i++) pop(i) = i;	

	/* Rcpp::Rcout << "npermut " << npermut << std::endl; */

  /* Calculs */

	inertot = 0;
	for (i=0; i<l1; i++) {
		poi = pl(i);
		for (j=0; j<c1; j++) {
			  tab1(i,j) = tab1(i,j) * poi;
		}
	}

	/*--------------------------------------------------
	 * Produit matriciel AtBC
	 *     prodmatAtBC (init2,init1, cov);
	 --------------------------------------------------*/
	for (j=0; j<c1; j++) {
		for (k=0; k<c2; k++) {
		  s1 = 0;
		  for (i=0; i<l1; i++) {
			s1 = s1 + tab1(i,j) * tab2(i,k);
		  }
		  cov(k,j) = s1;
		}       
	}

	for (i=0; i<c2; i++) {
		a1 = pc2(i);
		for (j=0; j<c1; j++) {
			s1 = cov(i,j);
			inertot = inertot + s1 * s1 * a1 * pc1(j);
		}
	}

  inersimul(0) = inertot;

  for (istep=1; istep<=npermut; istep++) {
    
	v1 = sample(pop, l1);
	v2 = sample(pop, l1);
	
	for (j=0; j<l1; j++) {
		for (k=0; k<c1; k++) {
			ti1p(j, k) = tabinit1(v1(j), k);
		}
		for (k=0; k<c2; k++) {
			ti2p(j, k) = tabinit2(v2(j), k);
		}
	}

    /* calcul de poids colonnes dans le cas d'une acm */

    if (typ1 == 2) {
      for(j=0; j<c1; j++){
		pc1(j) = 0;
      }
      for(i=0; i<l1; i++){
		for(j=0; j<c1; j++){
		  pc1(j) = pc1(j) + ti1p(i,j) * pl(i);
		}
      }

    }

    if (typ2 == 2) {
      for(j=0; j<c2; j++){
		pc2(j)=0;
      }
      for(i=0; i<l1; i++){
		for(j=0; j<c2; j++){
		  pc2(j) = pc2(j) + ti2p(v2(i), j) * pl(i);
		}
      }
    }	

    i = matcentrageCpp (ti1p, pl, typ1);
    i = matcentrageCpp (ti2p, pl, typ2);

    for (i=0; i<l1; i++) {
      poi = pl(i);
      for (j=0; j<c1; j++) {
		ti1p(i,j) = ti1p(i,j) * poi;
      }
    }

	/*--------------------------------------------------
	 * Produit matriciel AtBC
     * prodmatAtBC (tab2, tab1, cov);
	 --------------------------------------------------*/
	for (j=0; j<c1; j++) {
		for (k=0; k<c2; k++) {
		  s1 = 0;
		  for (i=0; i<l1; i++) {
			s1 = s1 + ti1p(i, j) * ti2p(i, k);
		  }
		  cov(k, j) = s1;
		}       
	}

    inersim = 0;
    for (i=0; i<c2; i++) {
      a1 = pc2(i);
      for (j=0; j<c1; j++) {
		s1 = cov(i, j);
		inersim = inersim + s1 * s1 * a1 * pc1(j);
      }
    }
    inersimul(istep) = inersim;
  }
  return inersimul;
}

