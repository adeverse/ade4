#include <math.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include "adesub.h"
#include "divsub.h"

void testapdiv(double *distab, int *l1, int *c1, int *samtab, int *l2, int *c2,int *strtab, int *l3, int *c3, int *indicstr, int *nbhapl, int *npermut, double *divtotal, double *result);
void permutapdiv(double **a, int **b, int **c, int *som, int increm, double *sst, int *prindicstr, double *res);
/*****************************************************************/

void testapdiv(double *distab, int *l1, int *c1,
				int *samtab, int *l2, int *c2,
				int *strtab, int *l3, int *c3,
				int *indicstr,
				int *nbhapl,
				int *npermut,
				double *divtotal,
				double *result)
{
/* Declarations de variables C locales */

	double	**ditab, *vtest;
	int		i, j, k, lenvtest, seuil, **satab, **sttab;
	
/* Allocation memoire pour les variables C locales */

	taballoc(&ditab, *l1, *c1);
	tabintalloc(&satab, *l2, *c2);
	tabintalloc(&sttab, *l3, *c3);
	

	if(indicstr[0] != 0){
		lenvtest = *c3 + 1;
	}
	else{
		lenvtest = 1;
	}
	
	vecalloc(&vtest, lenvtest);
	

/* On recopie les objets R dans les variables C locales */

	k = 0;
	for (i = 1; i <= *l1; i++) {
		for (j = 1; j <= *c1; j++) {
			ditab[i][j] = distab[k];
			k = k + 1;
		}
	}

	k = 0;
	for (i = 1; i <= *l2; i++) {
		for (j = 1; j <= *c2; j++) {
			satab[i][j] = samtab[k];
			k = k + 1;
		}
	}
	

	k = 0;
	for (i = 1; i <= *l3; i++) {
		for (j = 1; j <= *c3; j++) {
			sttab[i][j] = strtab[k];
			k = k + 1;
		}
	}
	
/* Calculs */
	
	seuil = 0;
	k = 0;
	for(i = 1; i <= npermut[0]; i++){
		seuil = seuil + 1;
		permutapdiv(ditab, satab, sttab, nbhapl, seuil, divtotal, indicstr, vtest);
		for(j = 1; j <= lenvtest; j++){
			result[j - 1 + k] = vtest[j];
		}
		k = k + lenvtest;
	}

	/* les resultats des tests vont etre renvoyes sous la forme d un vecteur.
	* Ce vecteur sera transforme en plusieurs object MonteCarlo dans la fonction .R */
	
	freetab(ditab);
	freeinttab(satab);
	freeinttab(sttab);
	freevec(vtest);

}

/***************************************************************/
void permutapdiv(double **a, int **b, int **c, int *som, int increm, double *sst, int *prindicstr, double *res)
/*--------------------------------------------------
* realise les permutation
* a est le tableau distances
* b est le tableau samples
* c est le tableau structure
* som contient la somme des termes de samples
* increm va servir dans la fonction getpermutation pour determiner des nombres aleatoires
* sst est la diversité totale (qui est constante)
* prindicstr indique la presence d un "vrai" tableau structures
--------------------------------------------------*/
{

	int i, j, k, l, m, n, ligb, colb, colc, colderoule, lenprss, lennumhapld, *xd, *newxd, **deroule, **newderoule, **newderouled, *xp , *newxp, *unduplicxp, *unduplicxdprxp, *newunduplicxdprxp, *pralea, compt, lignewderoule, nbniveaux, **csim, *dersamples, *numhaplp, *numhapld, *numhaplt, *numsamples, *ressoms, *repnumsam, *numhaplsim, **bsim, *newh, *news, *newsd, *newst, *newg, *newgd, *numgroup, *numgroud;
	double *prss;
	
	/* dersamples contient samples deroule comme dans asvector samples*/
	
	ligb = b[0][0];
	colb = b[1][0];
	lennumhapld = colb * ligb;
	colc = c[1][0];
	
	vecintalloc(&numhaplp, ligb);
	vecintalloc(&numhapld, lennumhapld);
	vecintalloc(&dersamples, lennumhapld);
	vecintalloc(&numhaplt, som[0]);
	vecintalloc(&numhaplsim, som[0]);
	vecintalloc(&numsamples, colb);
	vecintalloc(&repnumsam, som[0]);
	vecintalloc(&ressoms, colb);
	vecintalloc(&pralea, som[0]);
	tabintalloc(&bsim, ligb, colb);
	tabintalloc(&csim, colb, colc);
	vecintalloc(&numgroup, colb);
	vecintalloc(&numgroud, som[0]);
	vecintalloc(&xp, som[0]);
	vecintalloc(&newxp, som[0]);
	vecintalloc(&xd, som[0]);
	vecintalloc(&newxd, som[0]);
	vecintalloc(&unduplicxp, som[0]);
	vecintalloc(&unduplicxdprxp, som[0]);
	vecintalloc(&newunduplicxdprxp, som[0]);
	vecintalloc(&newh, som[0]);
	vecintalloc(&news, som[0]);
	vecintalloc(&newsd, som[0]);
	vecintalloc(&newst, som[0]);
	vecintalloc(&newg, som[0]);
	vecintalloc(&newgd, som[0]);
	
	if(prindicstr[0] != 0){
		colderoule = 2 + colc + 1;
	}
	else{
		colderoule = 2;
	}
	tabintalloc(&deroule, som[0], colderoule);
	tabintalloc(&newderoule, som[0], colderoule);
	tabintalloc(&newderouled, som[0], colderoule);

	if(prindicstr[0] != 0){
		lenprss = colc + 3;
	}
	else{
		lenprss = 3;
	}
	
	vecalloc(&prss, lenprss);
	
	for(i = 1; i <= ligb; i++){
		numhaplp[i] = i;
	}
	
	repdvecint(numhaplp, colb, numhapld);
	
	k = 0;
	for(j = 1; j <= colb; j++){	
		for(i = 1; i <= ligb; i++){	
			dersamples[k + i] = b[i][j];	
		}	
		k = k + ligb;
	}
	
	repintvec(numhapld, dersamples, numhaplt);
	
	for(i = 1; i <= colb; i++){
		numsamples[i] = i;
	}
	
	popsum(b, ressoms);
	repintvec(numsamples, ressoms, repnumsam);
	
	if(prindicstr[0] != 0){
	
		for(i = 1; i <= som[0]; i++){
			deroule[i][1] = numhaplt[i];
			deroule[i][2] = repnumsam[i];
		}
		
		for(j = 1; j <= colc; j++){
			for(i = 1; i <= colb; i++){
				numgroup[i] = c[i][j];
			}	
			repintvec(numgroup, ressoms, numgroud);	
			for(i = 1; i <= som[0]; i++){
				deroule[i][2 + j] = numgroud[i];
			}
		}
		
		for(i = 1; i <= som[0]; i++){
			deroule[i][colderoule] = 1;
		}
		
		for(i = 2; i <= colderoule - 1; i++){
		
			if(i != colderoule - 1){
				for(k = 1; k <= colb; k++){
					numgroup[k] = c[k][i - 1];
				}
				nbniveaux = maxvecint(numgroup);
			}
			else{
				nbniveaux = 1;
			}
			
			compt = 0;
			for(k = 1; k <= nbniveaux; k++){
				m = 1;
				for(j = 1; j <= som[0]; j++){
					if(deroule[j][i + 1] == k){
						for(l = 1; l <= colderoule; l++){
							newderoule[m][l] = deroule[j][l];
						}
						m = m + 1;
					}
				}
				
				for(j = 1; j <= m - 1; j++){
					xp[j] = newderoule[j][i];
				}
				xp[0] = m - 1;
	
				unduplicint(xp, unduplicxp);
				lignewderoule = m - 1;
									
				if(unduplicxp[0] == 1){
					for(j = 1; j <= lignewderoule; j++){
						for(l = 1; l <= colderoule; l++){
							newderouled[j + compt][l] = newderoule[j][l];
						}
					}
				}
				
				else{
				
					if(i == 2){
						pralea[0] = m - 1;
						getpermutation(pralea, increm);
				
						for(j = 1; j <= lignewderoule; j++){
							newderouled[j + compt][1] = newderoule[j][1];
							m = pralea[j];
							newderouled[j + compt][2] = newderoule[m][2];
							for(l = 3; l <= colderoule; l++){
								newderouled[j + compt][l] = newderoule[j][l];
							}
						}
					}
						
					else{

						for(j = 1; j <= m - 1; j++){
							xd[j] = newderoule[j][i-1];
						}
						xd[0] = m - 1;

						changeintlevels(xd, newxd);
						vpintunduplicvdint(xp, newxd, unduplicxdprxp);
						
						lignewderoule = m - 1;
						pralea[0] = unduplicxdprxp[0];
						getpermutation(pralea, increm);
						vecintpermut(unduplicxdprxp, pralea, newunduplicxdprxp);
						
						for(j = 1; j <= m-1; j++){
							l = newxd[j];
							newxp[j] = newunduplicxdprxp[l];
						}
				
						for(j = 1; j <= lignewderoule; j++){
							for(l = 1; l <= i - 1; l++){
								newderouled[j + compt][l] = newderoule[j][l];
							}
							newderouled[j + compt][i] = newxp[j];
							for(l = i + 1; l <= colderoule; l++){
								newderouled[j + compt][l] = newderoule[j][l];
							}
						}
					}
				}
				compt = compt + lignewderoule;
				
			}
			
			for(j = 1; j <= som[0]; j++){
				newh[j] = newderouled[j][1];
				news[j] = newderouled[j][2];
			}
			
			getinttable(newh, news, bsim);
			
			for(j = 3; j <= colderoule - 1; j++){
				for(l = 1; l <= som[0]; l++){
					newg[l] = newderouled[l][j];
				}
				vpintunduplicvdint(newg, news, newgd);
				unduplicint(news, newsd);
				newst[0] = newsd[0];
				getneworder(newsd, newst);
				for(l = 1; l <= colb; l++){
					n = newst[l];
					csim[l][j - 2] = newgd[n];
				}
			}
						
			sums(a, bsim, csim, som, sst, prindicstr, prss);
			res[i-1] = prss[i] / prss[i - 1];
			
		}
	}

	else {
		getpermutation(pralea,increm);
		vecintpermut(numhaplt, pralea, numhaplsim);
		getinttable(numhaplsim, repnumsam, bsim);
		sums(a, bsim, c, som, sst, prindicstr, prss);
		res[1] = prss[2] / prss[1];
	}

	freeintvec(numhaplp);
	freeintvec(numhapld);
	freeintvec(dersamples);
	freeintvec(numhaplt);
	freeintvec(numhaplsim);
	freeintvec(numsamples);
	freeintvec(repnumsam);
	freeintvec(ressoms);
	freeintvec(pralea);
	freeinttab(bsim);
	freeinttab(csim);
	freeintvec(numgroup);
	freeintvec(numgroud);
	freeintvec(xp);
	freeintvec(newxp);
	freeintvec(xd);
	freeintvec(newxd);
	freeintvec(unduplicxp);
	freeintvec(unduplicxdprxp);
	freeintvec(newunduplicxdprxp);
	freeintvec(newh);
	freeintvec(news);
	freeintvec(newsd);
	freeintvec(newst);
	freeintvec(newg);
	freeintvec(newgd);
	freeinttab(deroule);
	freeinttab(newderoule);
	freeinttab(newderouled);
	freevec(prss);
	
}
