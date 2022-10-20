#include <math.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include "adesub.h"
#include "divsub.h"

/***************************************************************/
void popweighting(int **b, int *som, double *res)
/*--------------------------------------------------
* Calcule les poids des samples muij
* b est le tableau samples
* som est la somme des termes de b
* res est le vecteur ou on doit mettre les poids
* les poids sont en frequences
--------------------------------------------------*/
{

	int i, j, lig, col;
	
	lig = b[0][0];
	col = b[1][0];
	
	for(j = 1; j <= col; j++){
		res[j] = 0;
		for(i = 1; i <= lig; i++){
			res[j] = (double) b[i][j] / (double) som[0] + res[j];
		}
	}

}

/***************************************************************/
void popsum(int **b, int *res)
/*--------------------------------------------------
* Calcule les effectifs des samples
* b est le tableau samples
* res est le vecteur ou on doit mettre les effectifs
--------------------------------------------------*/
{

	int i, j, lig, col;
	
	lig = b[0][0];
	col = b[1][0];
	
	for(j = 1; j <= col; j++){
		res[j] = 0;
		for(i = 1; i <= lig; i++){
			res[j] = (double) b[i][j] + res[j] ;
		}
	}

}

/***************************************************************/
void newsamples(int **b, int *vstru, int **res)
/*--------------------------------------------------
* Recalcule la matrice samples pour un niveau hiérarchique supérieur
* b est le tableau samples et c est le tableau structures
--------------------------------------------------*/
{

	int i, j, interm, col, lig;
	
	col = b[1][0];
	lig = b[0][0];

	for(i = 1;  i <= lig; i++){
		for(j = 1; j <= col; j++){
			interm = vstru[j];
			res[i][interm] = res[i][interm] + (double) b[i][j];
		} 
	}

}

/***************************************************************/
void alphadiv(double **a, int **b, int *som, double *res)
/*--------------------------------------------------
* Calcule les diversites au sein de chaque sample ou niveau hierarchique superieur
* a est le tableau distance et b est le tableau samples,
* som est la somme de tous les termes de b,
* res contiendra les diversites
--------------------------------------------------*/
{

	double **transi, **transib, *respoids, **bmod;
	
	/* bmod va contenir le tableau b mais avec les frequences pour chaque colonne
	* ie la somme des termes de chaque colonne vaut 1*/

	int i, j, cola, colb, ligb;
	
	colb = b[1][0];
	cola = a[1][0];
	ligb = b[0][0];

	taballoc(&transi, colb, cola);
	taballoc(&transib, colb, colb);
	taballoc(&bmod, ligb, colb);
	vecalloc(&respoids, colb);

	popweighting(b, som, respoids);
	
	for(i = 1; i <= ligb; i++){
		for(j = 1; j <= colb; j++){
			bmod[i][j] = (double) b[i][j] / respoids[j] / (double) som[0];
		}
	}

	prodmatAtBC(bmod, a, transi);
	prodmatABC(transi, bmod, transib);
	
	for(j = 1; j <= colb; j++) {
		res[j] = transib[j][j];
	} 
	
	/* la diversite est dans la diagonale de transib */

	freetab(transi);
	freetab(transib);
	freetab(bmod);
	freevec(respoids);
		
}

/***************************************************************/
void sums(double **a, int **b, int **c, int *som, double *sst, int *prindicstr, double *res)
/*--------------------------------------------------
* Calcule les sommes des carres des ecarts
* les resultats sont donnes de alpha moyen a total
--------------------------------------------------*/
{

	double *resdiva, *respoids, *lesgammas, somdesres;
	int i, j, l, seuil, colb, ligb, **newb, *stru, newcolb, colc, lenres;
	
	colb = b[1][0];
	ligb = b[0][0];
	colc = c[1][0];
	lenres = res[0];


	vecalloc(&resdiva, colb);
	vecalloc(&respoids, colb);
	vecintalloc(&stru, colb);
	vecalloc(&lesgammas, colc);
	
	/* stru va contenir une des colonnes de la matrice c
	* resdiva va contenir un vecteur de diversite intra a un des niveau hierarchique */
	
	for(i = 1; i <= colb; i++){
		stru[i] = c[i][1];
	}
	
	newcolb = maxvecint(stru);
	
	tabintalloc(&newb, ligb, newcolb);
	alphadiv(a, b, som, resdiva);
	popweighting(b, som, respoids);

	res[1] = 0;
	for(i = 1; i <= colb; i++){
		res[1] = resdiva[i] * respoids[i] * (double) som[0] + res[1];
	}

	if(prindicstr[0] != 0){	
		
		for(j = 1; j <= colc; j++){		
			for(i = 1; i <= ligb; i++){						
				for(l = 1; l <= newcolb;l++){				
					newb[i][l] = 0;				
				}			
			}

			/* il faut reinitialiser la matrice newb */
	
			for(i = 1; i <= colb; i++){
				stru[i] = c[i][j];
			}
			
			newsamples(b, stru, newb);
			newb[1][0] = maxvecint(stru);
			alphadiv(a, newb, som, resdiva);
			popweighting(newb, som, respoids);
	
			lesgammas[j] = 0;
	
			seuil = newb[1][0];
			for(i = 1; i <= seuil; i++){
				lesgammas[j] = resdiva[i] * respoids[i] * (double) som[0] + lesgammas[j];	
			}
		}
		
		for(i = 1; i <= colc; i++){
			somdesres = 0;
			for(j = 1; j <= i; j++){
				somdesres = somdesres + res[j];	
			}	
			res[i + 1] = lesgammas[i] - somdesres;	
		}
		
	}
	
	
	seuil = lenres - 1;
	if(prindicstr[0] != 0){
		res[seuil] = sst[0] * (double) som[0] - lesgammas[colc];
	}
	else{
		res[seuil] = sst[0] * (double) som[0] - res [1];
	}
	
	res[lenres] = sst[0] * (double) som[0];

	freevec(resdiva);
	freevec(respoids);
	freeintvec(stru);
	freevec(lesgammas);
	freeinttab(newb);


}

/***************************************************************/
int maxvecint (int *vec)
/*--------------------------------------------------
* calcul le max d'un vecteur d'entier
--------------------------------------------------*/
{
	int	i, len, x;
	
	x = vec[1];
	len = vec[0];
	for (i = 1; i <= len; i++) {
		if (vec[i] > x) x = vec[i];
	}
 	return(x);
}

/***************************************************************/
void means(double *pss, double *pdf, double *res)
/*--------------------------------------------------
* Calcule les carres moyen
* les resultats sont donnes de alpha moyen a total
* pss contient les sommes des carres
* pdf contient les degres de liberte
--------------------------------------------------*/
{
	int i, lenpss;
	
	lenpss = pss[0];	
	for(i = 1; i <= lenpss; i++){	
		res[i] = pss[i] / pdf[i];		
	}
	
}

/***************************************************************/
void nvalues(int **b, int **c, int *som, double *pdf, int *prindicstr, double *res)
/*--------------------------------------------------
* Calcule les valeurs n qui permettent de calculer les sigmas
* b contient le tableau samples
* c contient le tableau structures
* som contient la somme totale des elements de samples
* pdf contient les degres de liberte
--------------------------------------------------*/
{
	double *np, *nd, interm, *prres, *ddlutil, *ddlutilt;
	int i, j, k, l, m, colb, colc, ligb, lenpdf, lennp, lennd, lenddlutil, lenddlutild, collessoms, *ddlutild, *prddlutild, *repstrp, *repstrd, *ressoms, **lessoms, *numsamples, *repnumsam, *nbind, *nbindtemp, newcolb, intermint, **newb, *stru;
	
	/* sumsamples va contenir les numeros des samples 1 2 etc
	* repnumsam contient le numero du sample auquel appartient chaque occurence
	* lessoms contient en ligne les individus ou occurences et en colonne les groupes
	* en entree il contient les effectifs du groupe auquel appartient une occurence */
	
	colb = b[1][0];
	colc = c[1][0];
	ligb = b[0][0];
	lenpdf = pdf[0];
	lenddlutil = lenpdf - 2;
	
	if(prindicstr[0] != 0){
		collessoms = colc + 2;
	}
	else{
		collessoms = 2;
	}

	lennp = collessoms - 1;

	vecintalloc(&nbindtemp, colb);
	vecintalloc(&nbind, som[0]);
	vecintalloc(&ressoms, colb);
	tabintalloc(&lessoms, som[0], collessoms);
	vecintalloc(&numsamples, colb);
	vecintalloc(&repnumsam, som[0]);
	vecintalloc(&repstrp, colb);
	vecintalloc(&repstrd, som[0]);
	vecalloc(&np, lennp);
	vecalloc(&ddlutil, lenddlutil);
	vecalloc(&prres, lennp);
	vecintalloc(&stru, colb);
	
	for(i = 1; i <= colb; i++){
		numsamples[i] = i;
	}
	
	for(i = 1; i <= colb; i++){
		stru[i] = c[i][1];
	}
	
	newcolb = maxvecint(stru);
	tabintalloc(&newb, ligb, newcolb);
	
	if(prindicstr[0] != 0){
		lennd = 0;
		for(i = 1; i <= colc; i++){
		lennd = lennd + i;
		}
		lenddlutild = 0;
		k = colc + 1;
		for(i = 1; i <= k; i++){
			lenddlutild = lenddlutild + i;
		}
	}
	else{
		lennd = 1;
		lenddlutild = 1;
	}
	
	vecalloc(&nd, lennd);
	vecintalloc(&ddlutild, lenddlutild);
	vecalloc(&ddlutilt, lenddlutild);
	vecintalloc(&prddlutild, lennp);	

	popsum(b, nbindtemp);
	repintvec(numsamples, nbindtemp, repnumsam);
	repintvec(nbindtemp, nbindtemp, nbind);
	
	for(i = 1; i <= som[0]; i++){
		lessoms[i][1] = som[0];
		lessoms[i][collessoms] = nbind[i];
	}
	
	k = lenpdf - 1;
	for(i = 2; i <= k; i++){
		ddlutil[i - 1] = pdf[i];
	}
	
	if(prindicstr[0] != 0){
		for(j = 1; j <= colc; j++){		
			for(i = 1; i <= ligb; i++){						
				for(l = 1; l <= newcolb; l++){			
					newb[i][l] = 0;			
				}		
			}

			/* il faut reinitialiser la matrice newb */
	
			for(i = 1; i <= colb; i++){		
				stru[i] = c[i][j];
			}
			
			newsamples(b, stru, newb);
			intermint = maxvecint(stru);
			newb[1][0] = intermint;
			ressoms[0] = intermint;
			popsum(newb, ressoms);
			
			for(i = 1; i <= colb; i++){
				k = stru[i];
				repstrp[i] = ressoms[k];
			}
			
			repintvec(repstrp, nbindtemp, repstrd);
			
			for(i = 1; i <= som[0]; i++){
				lessoms[i][collessoms - j] = repstrd[i];
			}
		}	
	}
	
	for(j = 2; j <= collessoms; j++){
		interm = 0;
		for(i = 1; i <= som[0]; i++){
			interm = (double) lessoms[i][j] / (double) lessoms[i][j - 1] + interm;
		}
		np[j - 1] = (double) som[0] - interm;
	}	
	
	
	if(prindicstr[0] != 0){
		k = 0;
		for(i = 1; i <= lennp; i++){
			k = k + i;
			prres[i] = k;
			res[k] = np[lennp - i + 1];
		}
	}
	
	else{
		for(i = 1; i <= lennp; i++){
			res[i] = np[i];
		}
	}
	
	if(prindicstr[0] != 0){
	
		l = 1;
		for(i = 2; i <= colc + 1; i++){
			interm = i + 1;
			for(j = interm; j <= collessoms; j++){
				nd[l] = 0;
				for(k = 1; k <= som[0]; k++){
					interm = 1 / (double) lessoms[k][i - 1];
					interm = 1 / (double) lessoms[k][i] - interm;
					nd[l] = (double) lessoms[k][j] * interm + nd[l];
				}
				l = l + 1;
			}
		}

		interm = 0;
		k = colc + 1;
		for(i = 1; i <= k; i++){
			interm = interm + i;
			prres[i] = interm;
		}
			
		interm = 1;
		for(i = 1; i <= colc; i++){
			j = prres[i] + 1;
			k = prres[i + 1] - 1;
			for(l = j; l <= k; l++){
				m = lennd - interm + 1;
				res[l] = nd[m];
				interm = interm + 1;
			}
		}
		
		for(i = 1; i <= colc + 1; i++){
			prddlutild[i] = i;
		}
		
		repintvec(prddlutild, prddlutild, ddlutild);
		
		for(i = 1; i <= lenddlutild; i++){
			k= ddlutild[i];
			ddlutilt[i] = ddlutil[k];
			res[i] = res[i] / ddlutilt[i];
		}
		
	}
	
	else{
		res[1] = np[1] / ddlutil[1];
	}

	freeintvec(nbindtemp);
	freeintvec(nbind);
	freeintvec(ressoms);
	freeinttab(lessoms);
	freeintvec(numsamples);
	freeintvec(repnumsam);
	freeintvec(repstrp);
	freeintvec(repstrd);
	freevec(np);
	freevec(ddlutil);
	freevec(prres);
	freeintvec(stru);
	freeinttab(newb);
	freevec(nd);
	freeintvec(ddlutild);
	freevec(ddlutilt);
	freeintvec(prddlutild);
	
}

/***************************************************************/
void repintvec(int *vecp, int *vecd, int *res)
/*--------------------------------------------------
* correspond a la fonction rep de R avec un vecteur en deuxieme partie
* res doit avoir la longueur de la somme des termes de vecd
--------------------------------------------------*/
{

	int i, j, k, lenvecp, indic, seuil;
	
	lenvecp = vecp[0];	
	k = 0;	
	for(i = 1; i <= lenvecp; i++){		
		seuil = vecd[i];		
		for(j = 1; j <= seuil; j++){		
			indic = k + j;		
			res[indic] = vecp[i];		
		}		
		k = k + seuil;		
	}	

}

/***************************************************************/
void repdvecint(int *vecp, int nbd, int *res)
/*--------------------------------------------------
* correspond a la fonction rep de R avec un nombre en deuxieme partie
* res doit avoir la longueur de nbd multiplier par la longueur de vecp
* sans compter la case 0
--------------------------------------------------*/
{

	int i, j, k, lenvecp, indic;
	
	lenvecp = vecp[0];
	k = 0;
	for(i = 1; i <= nbd; i++){	
		for(j = 1; j <= lenvecp; j++){
			indic = k + j;		
			res[indic] = vecp[j];
		}
		k = k + lenvecp;
	}

}

/***************************************************************/
void sigmas(double *pms, double *pn, double *res)
/*--------------------------------------------------
* calcule les variances ou covariances de l'amova
* pms contient les carres moyens
* pn contient les valeurs n
--------------------------------------------------*/
{
	double si;
	int i, j, k, lenpms, lenindex, *index;
	
	lenpms = pms[0];
	lenindex = lenpms - 1;
	
	vecintalloc(&index, lenindex);
	
	res[1] = pms[1];
	res[2] = pms[2] / pn[1] - res[1] / pn[1];
	
	if(lenpms >= 3){	
		k = 2;
		for(i = 3; i <= lenpms - 1; i++){
			si = 0;
			for(j = 2; j <= i-1; j++){
				si = pn[k] * res[j] + si;
				k = k + 1;
			}
			res[i] = pms[i] - res[1] - si;
			res[i] = res[i] / pn[k];
			k = k + 1;
		}
	}
	
	for(i = 1; i <= lenpms - 1; i++){
		res[lenpms] = res[lenpms] + res[i];
	}
	
	freeintvec(index);

}
/***************************************************************/
void getinttable(int *vp, int *vd, int **res)
/*--------------------------------------------------
* calcule une table a partir de deux facteurs ie des deux vecteurs dont les termes vont de 1 à n
* les niveaux de vp seront mis en lignes (haplotypes)
* les niveaux de vd seront mis en colonnes (samples)
--------------------------------------------------*/
{

	/* attention pour generaliser la fonction, il faudra surement modifier ça
	* pour que les niveaux soient dans le même ordre qu'au début*/

	int i, j, k, lig, nivvp, nivvd;
	
	lig = vp[0];
	nivvp = maxvecint(vp);
	nivvd = maxvecint(vd);
	
	for(i = 1; i <= nivvp; i++){
		for(j = 1; j <= nivvd; j++){
			res[i][j] = 0;
			for(k = 1; k <= lig; k++){
				if(vp[k] == i && vd[k] == j){
					res[i][j] = res[i][j] + 1;
				}
			}
		}
	}

}

/***************************************************************/
void unduplicint(int *vecp, int *res)
/*--------------------------------------------------
*
--------------------------------------------------*/
{

	int i, j, k, lenvecp, compteur;
	lenvecp = vecp[0];
	
	k = 1;
	res[1] = vecp[1];
	for(i = 2; i <= lenvecp; i++){
		compteur = 0;
		for(j = 1; j <= k; j++){
			if(vecp[i] != res[j]){
				compteur = compteur + 1;
			}
		}
		if(compteur == k){
			res[k + 1] = vecp[i];
			k = k + 1;
		}
	}
	res[0] = k;

}

/***************************************************************/
void vpintunduplicvdint(int *vecp, int *vecd, int *res)
/*--------------------------------------------------
* on prend les termes de vecp tels que vecd ne soit pas dupliqué
* cela correspond à vecp[!duplicated(vecd)]
--------------------------------------------------*/
{

	int i, j, k, lenvecp, compteur, *resinterm;
	
	lenvecp = vecp[0];
	vecintalloc (&resinterm, lenvecp);

	k = 1;
	resinterm[1] = vecd[1];
	res[1] = vecp[1];
	for(i = 1; i <= lenvecp; i++){
		compteur = 0;
		for(j = 1; j <= k; j++){
			if(vecd[i] != resinterm[j]){
				compteur = compteur + 1;
			}
			if(compteur == k){
				resinterm[k + 1] = vecd[i];
				res[k + 1] = vecp[i];
				k = k + 1;
			}
		}
	}
	
	res[0] = k;
	
	freeintvec(resinterm);

}

/***************************************************************/
void changeintlevels(int *vecp, int *res)
/*--------------------------------------------------
* on va numéroter les levels de vecp de 1 à n
--------------------------------------------------*/
{

	int i, j, k, l, lenvecp, lenundup, *unduplicvecp;
	
	vecintalloc (&unduplicvecp, vecp[0]);
	
	lenvecp = vecp[0];
	unduplicint(vecp, unduplicvecp);
	lenundup = unduplicvecp[0];
	
	for(i = 1; i <= lenvecp; i++){
			for(j = 1; j <= lenundup; j++){
				k = vecp[i];
				l = unduplicvecp[j];
				if(k == l){
					res[i] = j;

				}
			}
	}
	
	freeintvec(unduplicvecp);
	
}

/***************************************************************/
void getneworder(int *vecp, int *res)
/*--------------------------------------------------
* donne les ordres pour un facteur ie avec des numéros de 1 à n
--------------------------------------------------*/
{

	int i, k, lenvecp;
	lenvecp = vecp[0];
	
	for(i = 1; i <= lenvecp; i++){
		k = vecp[i];
		res[k] = i;
	}
	
}

/***************************************************************/
void vecintpermut (int *A, int *num, int *B)
{
/*---------------------------------------
* A est un vecteur n elements
* B est une vecteur n elements
* num est une permutation alatoire des n premiers entiers
* B contient en sortie les elements de A permutes
* ---------------------------------------*/

	int lig, lig1, lig2, i, k;
	
	lig = A[0];
	lig1 = B[0];
	lig2 = num[0];
	
	
	if ( (lig!=lig1) || (lig!=lig2) ) {
		/*err_message ("Illegal parameters (vecpermut)");
		closelisting();*/
	}
	
	for (i=1; i<=lig; i++) {
		k=num[i];
		B[i] = A[k];
	}
}
