#include <RcppArmadillo.h>
using namespace arma;

#include <Rcpp.h>

// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
/*********************************************/
double betweenvarCpp (const arma::mat& tab, const arma::vec& pl, Rcpp::IntegerVector fac)
{
	double  s, bvar;
	int     i, j, icla;
	int l1 = tab.n_rows;
	int c1 = tab.n_cols;
	Rcpp::CharacterVector faclevs = fac.attr("levels");
	int ncla = faclevs.length();

	bvar = 0;
	for (j=0; j<c1; j++) {
		arma::vec m(ncla);
		arma::vec indicaw(ncla);
		for (i=0; i<l1; i++) {
			icla = fac(i) - 1;
			indicaw(icla) = indicaw(icla) + pl(i);
			m(icla) = m(icla) + tab(i, j) * pl(i);
		}
		s = 0;
		for (i=0; i<ncla; i++) {
			s = s + m(i) * m(i) / indicaw(i);
		}   
		bvar = bvar + s;
	}
	return (bvar);
}

// [[Rcpp::export]]
/*********************************************/
arma::vec testdiscriminCpp(const int npermut,
		    const int rang,
            const arma::vec& pl,
            Rcpp::IntegerVector fac,
		    const arma::mat& tab)
{
	/* Rcpp::Rcout << "npermut " << npermut << std::endl; */

	arma::vec inersim(npermut+1);
	int l1 = tab.n_rows;
	int c1 = tab.n_cols;
	arma::mat tabp(l1, c1);
	arma::vec plp(l1);
	int     i, j, k;
	Rcpp::IntegerVector v1(l1), pop(l1);

	inersim(0) = betweenvarCpp(tab, pl, fac) / rang;

	for (i=0; i<l1; i++) pop(i) = i;	
	for (k=1; k<=npermut; k++) {
		v1 = sample(pop, l1);
		for (i=0; i<l1; i++) {
			plp(i) = pl(v1(i));
			for (j=0; j<c1; j++) {
				tabp(i, j) = tab(v1(i), j);
			}
		}
		inersim(k) = betweenvarCpp(tabp, plp, fac) / rang;
	}
	return inersim;
}

