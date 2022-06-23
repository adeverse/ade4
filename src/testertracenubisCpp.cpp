#include <RcppArmadillo.h>
using namespace arma;

#include <Rcpp.h>

// [[Rcpp::depends(RcppArmadillo)]]
#include <ade4.h>

// [[Rcpp::export]]
/*****************/
arma::vec testertracenubisCpp(int npermut,
			arma::vec& pc1,
			arma::vec& pc2,
			const arma::vec& pl,
			arma::mat& tab1,
			arma::mat& tab2,
			arma::mat& tabinit1,
			arma::mat& tabinit2,
			const int typ1,
			const int typ2,
			const int ntab)
{
  /* Declarations des variables C locales */

  int     i, j, k, istep;
  double  poi, inertot, s1, inersim, a1;

	int l1 = tab1.n_rows;
	int c1 = tab1.n_cols;
	int c2 = tab2.n_cols;

	arma::mat cov(c2, c1);
	arma::mat init1(l1, c1);
	arma::mat init2(l1, c2);
	arma::mat X1(l1, c1);
	arma::mat X2(l1, c2);
	arma::vec inersimul(npermut+1);
	Rcpp::IntegerVector v1(l1), v2(l1), pop(l1);
	for (i=0; i<l1; i++) pop(i) = i;	

	/* Rcpp::Rcout << "npermut " << npermut << std::endl; */

  /* Calculs */


	init1 = tab1;
	init2 = tab2;

	inertot = 0;
	for (i=0; i<l1; i++) {
		poi = pl(i);
		for (j=0; j<c1; j++) {
			  init1(i,j) = init1(i,j) * poi;
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
			s1 = s1 + init1(i,j) * init2(i,k);
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

	X1 = tab1;
	for (i=0; i<l1; i++) {
		poi = pl[i];
		for (j=0; j<c1; j++) {
		  X1(i,j) = X1(i,j) * poi;
		}
	}

	X2 = tab2;
	for (i=0; i<l1; i++) {
		poi = pl[i];
		for (j=0; j<c2; j++) {
		  X2(i,j) = X2(i,j) * poi;
		}
	}

	if (ntab == 1) {
		init2 = tabinit2;
	} else {
		init1 = tabinit1;
	}
	
  for (istep=1; istep<=npermut; istep++) {

	if (ntab == 1) {
		v2 = sample(pop, l1);
		for (j=0; j<l1; j++) {
			for (k=0; k<c2; k++) {
				X2(j, k) = init2(v2(j), k);
			}
		}

		if (typ2 == 2) {
		  for(j=0; j<c2; j++){
			pc2(j) = 0;
		  }
		  for(i=0; i<l1; i++){
			for(j=0; j<c2; j++){
			  pc2(j) = pc2(j) + X2(i,j) * pl(i);
			}
		  }
		}
		i = matcentrageCpp (X2, pl, typ2);
	} else {
		v1 = sample(pop, l1);
		for (j=0; j<l1; j++) {
			for (k=0; k<c1; k++) {
				X1(j, k) = init1(v1(j), k);
			}
		}
		if (typ1 == 2) {
		  for(j=0; j<c1; j++){
			pc1(j)=0;
		  }
		  for(i=0; i<l1; i++){
			for(j=0; j<c1; j++){
			  pc1(j) = pc1(j) + X1(i,j) * pl(i);
			}
		  }
		}	

		i = matcentrageCpp (X1, pl, typ1);
	}
	/*--------------------------------------------------
	 * Produit matriciel AtBC
     * prodmatAtBC (X2, X1, cov);
	 --------------------------------------------------*/
	for (j=0; j<c1; j++) {
		for (k=0; k<c2; k++) {
		  s1 = 0;
		  for (i=0; i<l1; i++) {
			s1 = s1 + X1(i, j) * X2(i, k);
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

