#include <RcppArmadillo.h>
using namespace arma;

#include <Rcpp.h>

// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
arma::vec RVintrarandtestCpp(const arma::mat & X, const arma::mat & Y, Rcpp::IntegerVector fac, const int nrepet)
{
	arma::mat U, V;
	arma::vec S, s2(nrepet+1);
	double s1;
	int i, j, j1, k, istep;
	int l1 = X.n_rows;
	int c1 = X.n_cols;
	int c2 = Y.n_cols;
	Rcpp::IntegerVector v1;
	arma::mat C(c1, c2);
	Rcpp::NumericMatrix Yp(l1, c2);

	Rcpp::CharacterVector faclevs = fac.attr("levels");
	int nlev = faclevs.length();

/*--------------------------------------------------
 List of lists to store the row numbers in each factor level
--------------------------------------------------*/
	Rcpp::List spl1(nlev);
	for (i=0; i<nlev; i++) {
		Rcpp::List spl1[i];
	}

/*--------------------------------------------------
Fill the list of row numbers that belong to each factor level
--------------------------------------------------*/
	for (j=0;  j<nlev; j++) {
		Rcpp::List listej;
		for (i=0; i<l1; i++) {
			if (fac(i) == j+1) {
				listej.push_back(i+1);
			}
		}
		spl1[j] = listej;
	}

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
	/*----------------------
	* Boucle sur les nrepet permutations
	------------------------*/
	for (istep = 1; istep <= nrepet; istep++) {
		/*----------------------
		 * affectation d'une permutation aleatoire des individus dans les blocs
		 ------------------------*/
		j1 = 0;
		Rcpp::List listej;
		for (i=0; i<nlev; i++) {
			listej = spl1[i];
			int l2 = listej.length();
			Rcpp::IntegerVector v1(l2);
			for (j=0; j<l2; j++) {
				v1[j] = listej[j];
			}
			v1 = sample(v1, l2);
			for (j=0; j<l2; j++) {
				for (k=0; k<c2; k++) {
					Yp(j1, k) = Y(v1(j)-1, k);
				}
				j1 = j1 + 1;
			}
		}

		/*--------------------------------------------------
		 * Produit matriciel AtB
		 --------------------------------------------------*/
		for (j=0; j<c1; j++) {
			for (k=0;k<c2;k++) {
			  s1 = 0;
			  for (i=0;i<l1;i++) {
				s1 = s1 + X(i, j) * Yp(i, k);
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
