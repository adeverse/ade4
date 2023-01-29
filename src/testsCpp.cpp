#include <RcppArmadillo.h>
using namespace arma;

#include <Rcpp.h>

// [[Rcpp::depends(RcppArmadillo)]]

#include <ade4libCpp.h>

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

// [[Rcpp::export]]
arma::vec procusterandtestCpp(const arma::mat & X, const arma::mat & Y, const int nrepet)
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
	arma::mat w(c1, c1);

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
	/*--------------------------------------------------
 	* Produit matriciel B = AAt
 	--------------------------------------------------*/
	for (j=0; j<c1; j++) {
		for (k=j; k<c1; k++) {
		  s1 = 0;
		  for (i=0; i<c2; i++) {
			s1 = s1 + C(j, i) * C(k, i);
		  }
		  w(j, k) = s1;
		  w(k, j) = s1;
		}       
	}
	arma::eig_sym(S, w);
	for (j=0; j<c1; j++) {
		S(j) = sqrt(S(j));
	}
	s1 = sum(S);
	s2(0) = s1;	
	for (i=0; i<l1; i++) pop(i) = i;	
	for (istep = 1; istep <= nrepet; istep++) {
		/*----------------------
		 * affectation d'une permutation aleatoire des l1 premiers entiers 
		 * dans dans un vecteur d'entiers de dimension l1
		 ------------------------*/
		v1 = sample(pop, l1);
		/*--------------------------------------------------
		 * Produit matriciel C = AtB
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
		/*--------------------------------------------------
 		* Produit matriciel B = AAt
 		--------------------------------------------------*/
		for (j=0; j<c1; j++) {
			for (k=j; k<c1; k++) {
			  s1 = 0;
			  for (i=0; i<c2; i++) {
				s1 = s1 + C(j, i) * C(k, i);
			  }
		  	  w(j, k) = s1;
		  	  w(k, j) = s1;
			}       
		}
		arma::eig_sym(S, w);
		for (j=0; j<c1; j++) {
			S(j) = sqrt(S(j));
		}
		s1 = sum(S);		
		s2(istep) = s1;
	}			
    return s2;
}

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

