#include <RcppArmadillo.h>
using namespace arma;

#include <Rcpp.h>

// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
/*****************/
arma::vec testertraceCpp(int npermut,
		    const arma::vec& pc1,
		    const arma::vec& pc2, 
		     arma::mat& X1,
		     arma::mat& X2)
{

	/* Declarations des variables C locales */

	int     i, j, k, istep;
	double  poi, inertot, s1, inersim;

	int l1 = X1.n_rows;
	int c1 = X1.n_cols;
	int c2 = X2.n_cols;

	arma::mat cov(c2, c1);
	arma::vec inersimul(npermut+1);
	Rcpp::IntegerVector v1, pop(l1);
	for (i=0; i<l1; i++) pop(i) = i;	

	/* Calculs */

	for (j=0; j<c1;j++) {
		poi = sqrt(pc1(j));
		for (i=0; i<l1; i++) {
			X1(i, j) = X1(i, j) * poi;
		}
	}
	for (j=0; j<c2; j++) {
		poi = sqrt(pc2(j));
		for (i=0; i<l1; i++) {
			X2(i, j) = X2(i, j) * poi;
		}
	}

	/*--------------------------------------------------
	 * Produit matriciel AtBC
	 *   prodmatAtBC (X2, X1, cov);
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

	inertot = 0;
	for (i=0; i<c2; i++) {
		for (j=0; j<c1; j++) {
			s1 = cov(i, j);
			inertot = inertot + s1 * s1;
		}
	}
	inertot = inertot / l1 / l1;
	inersimul(0) = inertot;

	/* Rcpp::Rcout << "inertot " << inertot << std::endl; */

	for (istep=1; istep<=npermut; istep++) {
		v1 = sample(pop, l1);
		for (j=0; j<c1; j++) {
			for (k=0; k<c2; k++) {
			  s1 = 0;
			  for (i=0; i<l1; i++) {
				s1 = s1 + X1(v1(i), j) * X2(i, k);
			  }
			  cov(k, j) = s1;
			}       
		}
		inersim = 0;
		for (i=0; i<c2; i++) {
		  for (j=0; j<c1; j++) {
			s1 = cov(i, j);
			inersim = inersim + s1 * s1;
		  }
		}
		inersimul(istep) = inersim / l1 / l1;
	}
	return inersimul;
}
