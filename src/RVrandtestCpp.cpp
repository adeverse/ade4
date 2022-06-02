#include <RcppArmadillo.h>
using namespace arma;

#include <Rcpp.h>

// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
arma::vec RVrandtestCpp(const arma::mat & X, const arma::mat & Y, const int nrepet)
{
	arma::mat U, V;
	arma::vec S, s2(nrepet+1);
	double s1;
	int i, j, k, istep;
	int l1 = X.n_rows;
	int c1 = X.n_cols;
	int c2 = Y.n_cols;
	Rcpp::IntegerVector v1, pop(l1);
	arma::mat C(c1, c2);

	/*--------------------------------------------------
	 * RV obs
	 --------------------------------------------------*/
	for (j=0; j<c1; j++) {
		for (k=0;k<c2;k++) {
		  s1 = 0;
		  for (i=0;i<l1;i++) {
			s1 = s1 + X(i, j) * Y(i, k);
		  }
		  C(j,k) = s1;
		}       
	}
	svd(U, S, V, C, "standard");
	s1 = sum(S.t() * S);
	s2(0) = s1;	
	for (i=0; i<l1; i++) pop(i) = i;	
	for (istep = 1; istep <= nrepet; istep++) {
		/*----------------------
		 * affectation d'une permutation aleatoire des l1 premiers entiers 
		 * dans dans un vecteur d'entiers de dimension l1
		 ------------------------*/
		v1 = sample(pop, l1);
		/*--------------------------------------------------
		 * Produit matriciel AtB
		 --------------------------------------------------*/
		for (j=0; j<c1; j++) {
			for (k=0;k<c2;k++) {
			  s1 = 0;
			  for (i=0;i<l1;i++) {
				s1 = s1 + X(i, j) * Y(v1(i), k);
			  }
			  C(j,k) = s1;
			}       
		}
		svd(U, S, V, C, "standard");
		s1 = sum(S.t() * S);		
		s2(istep) = s1;
	}			
    return s2;
}
