#include <math.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include "adesub.h"
#include <R.h>

void testertracerlq ( int *npermut,
                double *pcRr, int *npcR,
                double *pcQr, int *npcQ,
                double *plLr, int *nplL,
                double *pcLr, int *nclL,
                double *tabRr, 
                double *tabQr,
                double *tabLr,
                int *assignRr, int *assignQr,
                int *indexRr, int *nindexR,
                int *indexQr, int *nindexQ,
                int *typQr,
                int *typRr,
                double *inersimul);
              
                

                
void testertracerlq ( int *npermut,
                double *pcRr, int *npcR,
                double *pcQr, int *npcQ,
                double *plLr, int *nplL,
                double *pcLr, int *npcL,
                double *tabRr, 
                double *tabQr,
                double *tabLr,
                int *assignRr, int *assignQr,
                int *indexRr, int *nindexR,
                int *indexQr, int *nindexQ,
                int *typQr,
                int *typRr,
                double *inersimul)




{
/* Declarations des variables C locales */

    double  **XR, **XQ, **XL,**initR, **initQ, *pcR, *pcQ, *plL,*pcL, **ta,**provi;
    int     i, j, k, lL,cL, cR, cQ;
    double  inertot, s1, inersim, a1;
    int     *numero1, *numero2,*assignR,*assignQ, *indexR, *indexQ;
    char    typR[3], typQ[3];
    
/* On recopie les objets R dans les variables C locales */

    lL = *nplL;
    cL = *npcL;
    cQ = *npcQ;
    cR = *npcR;
    strncpy(typR, (char const *) *typRr, 2);
    strncpy(typQ, (char const *) *typQr, 2);
    typR[2] = 0;
    typQ[2] = 0;
/* Allocation memoire pour les variables C locales */

    vecalloc (&pcR, cR);
    vecalloc (&pcQ, cQ);
    vecalloc (&plL, lL);
    vecalloc (&pcL, cL);    
    vecintalloc (&numero1, lL);
    vecintalloc (&numero2, cL);
    taballoc (&XR, lL, cR);
    taballoc (&XQ, cL, cQ);
    taballoc (&initR, lL, cR);
    taballoc (&initQ, cL, cQ);
    taballoc (&XL, lL, cL);
    taballoc (&ta, cR, cQ);
    taballoc (&provi,cR,cL);
    if (strcmp (typR,"hi") == 0) {
        vecintalloc(&assignR,cR);    
        for (i=1; i<=cR; i++) {
            assignR[i] = assignRr[i-1];
        }
        vecintalloc(&indexR,*nindexR);    
        for (i=1; i<=*nindexR; i++) {
            indexR[i] = indexRr[i-1];
        }
    } 
    if (strcmp (typQ,"hi") == 0) {
        vecintalloc(&assignQ,cQ);    
        for (i=1; i<=cQ; i++) {
            assignQ[i] = assignQr[i-1];
        }
        vecintalloc(&indexQ,*nindexQ);    
        for (i=1; i<=*nindexQ; i++) {
            indexQ[i] = indexQr[i-1];
        }
        
    } 

/* On recopie les objets R dans les variables C locales */

    k = 0;
    for (i=1; i<=lL; i++) {
        for (j=1; j<=cR; j++) {
            initR[i][j] = tabRr[k];
            XR[i][j] = tabRr[k];
            k = k + 1;
        }
    }
    k = 0;
    for (i=1; i<=cL; i++) {
        for (j=1; j<=cQ; j++) {
            initQ[i][j] = tabQr[k];
            XQ[i][j] = tabQr[k];
            k = k + 1;
        }
    }
    k = 0;
    for (i=1; i<=lL; i++) {
        for (j=1; j<=cL; j++) {
            XL[i][j] = tabLr[k];
            k = k + 1;
        }
    }
    
    for (i=1; i<=cR; i++) {
        pcR[i] = pcRr[i-1];
    }
    for (i=1; i<=cQ; i++) {
        pcQ[i] = pcQr[i-1];
    }
    for (i=1; i<=cL; i++) {
        pcL[i] = pcLr[i-1];
    }
    for (i=1; i<=lL; i++) {
        plL[i] = plLr[i-1];
    }
      
/* Calculs */


    for (i=1; i<=lL;i++) {
        for (j=1;j<=cL;j++) {
            XL[i][j]=XL[i][j]*plL[i]*pcL[j];
        }
    }
    if (strcmp (typR,"hi") == 0) {
       matcentragehi(XR,plL,indexR,assignR);
              }
   else {matcentrage (XR, plL, typR);
      }
        
    if (strcmp (typQ,"hi") == 0) {
        matcentragehi(XQ,pcL,indexQ,assignQ);
	}
    else {matcentrage (XQ, pcL, typQ);
        }

    prodmatAtBC (XR, XL, provi);
    prodmatABC (provi,XQ, ta);

    inertot = 0;
    for (i=1;i<=cR;i++) {
        a1 = pcR[i];
        for (j=1;j<=cQ;j++) {
            s1 = ta[i][j];
            inertot = inertot + s1 * s1 * a1 * pcQ[j];
        }
    }
    inersimul[0] = inertot;
           k = 0;
 


    
    
    
    for (k=1; k<=*npermut; k++) {
        getpermutation (numero1,k);
        getpermutation (numero2,2*k);
        aleapermutmat(initR);
	aleapermutmat(initQ);
	matpermut (initR, numero1, XR);
        matpermut (initQ, numero2, XQ);


    if (strcmp (typR,"hi") == 0) {
        for(j=1;j<=cR;j++){
		if(indexR[assignR[j]]==1){
			pcR[j]=0;
		}
	}
    	for(i=1;i<=lL;i++){
		for(j=1;j<=cR;j++){
			if(indexR[assignR[j]]==1){
				pcR[j]=pcR[j]+XR[i][j]*plL[i];
			}
		}
	}
	matcentragehi(XR,plL,indexR,assignR);
/* on recalcule le poids colonne pour les qualitatives */
	}
    else {
      /* on recalcule le poids colonne pour les qualitatives pour une acm*/
	if (strcmp (typR,"cm") == 0) {
		for(j=1;j<=cR;j++){
			pcR[j]=0;
			}
    		for(i=1;i<=lL;i++){
			for(j=1;j<=cR;j++){
				pcR[j]=pcR[j]+XR[i][j]*plL[i];
			}
		}
		for(j=1;j<=cR;j++){
			pcR[j]=pcR[j]/(*nindexR);				
			}
			
	
	}
    
    	matcentrage (XR, plL, typR);
    	
    	
	}
        
    if (strcmp (typQ,"hi") == 0) {
/* on recalcule le poids colonne pour les qualitatives*/
	for(j=1;j<=cQ;j++){
		if(indexQ[assignQ[j]]==1){
			pcQ[j]=0;
		}
	}
    	for(i=1;i<=cL;i++){
		for(j=1;j<=cQ;j++){
			if(indexQ[assignQ[j]]==1){
				pcQ[j]=pcQ[j]+XQ[i][j]*pcL[i];
			}
		}
	}
	
        matcentragehi(XQ,pcL,indexQ,assignQ);
	
        }
    else {
/* on recalcule le poids colonne pour les qualitatives pour une acm*/
	if (strcmp (typQ,"cm") == 0) {
		for(j=1;j<=cQ;j++){
			pcQ[j]=0;
			}
    		for(i=1;i<=cL;i++){
			for(j=1;j<=cQ;j++){
				pcQ[j]=pcQ[j]+XQ[i][j]*pcL[i];
			}
		}
		for(j=1;j<=cQ;j++){
			pcQ[j]=pcQ[j]/(*nindexQ);
			}	
	}
	
	
    	matcentrage (XQ, pcL, typQ);
    	

    }

        prodmatAtBC (XR, XL, provi);
        prodmatABC (provi,XQ, ta);


        inersim = 0;
        for (i=1;i<=cR;i++) {
            a1 = pcR[i];
            for (j=1;j<=cQ;j++) {
                s1 = ta[i][j];
                inersim = inersim + s1 * s1 * a1 * pcQ[j];
            }
        }
        inersimul[k]=inersim;
    }
 
 
    
    freeintvec(numero1);
    freeintvec(numero2);

    
    if (strcmp (typR,"hi") == 0) {
        freeintvec(assignR);
        freeintvec(indexR);     
    } 
    if (strcmp (typQ,"hi") == 0) {
        freeintvec(assignQ);    
        freeintvec(indexQ);     
    } 
    freetab(XR);
    freetab(initR);
    freetab(XL);
    freetab(ta);
    freetab(provi);
    freetab(XQ);
    freetab(initQ);
    freevec(plL);
    freevec(pcL);
    freevec(pcQ);
    freevec(pcR);

} /*********************************/

 
