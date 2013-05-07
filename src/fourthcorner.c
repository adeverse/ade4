#include <math.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include <R.h>
#include "adesub.h"

/*=============================================================*/
double calculcorr (double **L, double *varx, double *vary);
void vecstandar (double *tab, double *poili, double n);
void calculkhi2 (double **obs, double *res);
double calculkhi2surn (double **obs);
double calculF (double **XL, double **XQual, double *XQuant, double *D);
double calculcorratio (double **XL, double **XQual, double *XQuant);
void quatriemecoin (double *tabR, double *tabL, double *tabQ,
		    int *ncolR, int *nvarR, int *nlL, int *ncL,
		    int *ncolQ, int *nvarQ,int *nrepet,
		    int *modeltype,
		    double *tabD, double *tabD2,
		    double *tabG,
		    int *RtypR,int *RtypQ, int *RassignR, int *RassignQ);
void quatriemecoin2 (double *tabR, double *tabL, 
		     double *tabQ , int *ncolR, int *nvarR, int *nlL,
		     int *ncL, int *ncolQ, int *nvarQ,int *nrepet, int *modeltype,
		     double *tabG, double *trRLQ,
		     int *RtypR,int *RtypQ, int *RassignR, int *RassignQ);
void quatriemecoinRLQ (double *tabR, double *tabL, double *tabQ,
		       int *ncolR, int *nvarR, int *nlL, int *ncL,
		       int *ncolQ, int *nvarQ,
		       int *nrepet, int *modeltype,
		       double *tabD, double *tabD2, double *tabG,
		       int *nrowD, int *ncolD, int *nrowG, int *ncolG,
                       int *RtypR, int *RtypQ, int *RassignR, int *RassignQ,
		       double *c1, double *l1, int *typeTest, int *naxes, int *typAnalRr, int *typAnalQr,
		       double *pcRr, double *pcQr);

/*=============================================================*/

void quatriemecoin (double *tabR, double *tabL, double *tabQ,
		    int *ncolR, int *nvarR, int *nlL, int *ncL,
		    int *ncolQ, int *nvarQ,int *nrepet,
		    int *modeltype,
		    double *tabD, double *tabD2,
		    double *tabG,
		    int *RtypR,int *RtypQ, int *RassignR, int *RassignQ)
  
{
  /* Calcul quatrieme coin */
  /* couplage quantitative/quantitative OU qualitative/quantitative OU qualitative/qualitative */
  
  /* resutlats dans tabD statistique pour chaque cellule (homogeneite ds le cas quanti/quali)*/
  /* resutlats dans tabD2 statistique pour chaque cellule (r ds le cas quanti/quali)*/
  /* tabG resutlats globaux (Chi2 pour quali/quali) observes */
  /* typR et typQ vecteur avec le type de chaque variable (1=quant, 2=qual) longueur nvarR et nvarQ */
  /* assignR et assignQ vecteur avec le numero de variable pour chaque colonne de R et Q longueur ncolR et ncolQ */
  
  /* le tableau est transpose par rapport a l'article original mais
     on garde la typologie des modeles par rapport a espece/site et non ligne colonne
     Par exemple,
     model 1 permute dans les espece independament (lignes dans l'article original), donc dans chaque colonne ici... */
  
  /* Declarations de variables C locales */
  double  **XR,**XL,**XQ,**XD,**LtR, **XG, **XD2;
  double  **XLpermute, **contingxy;
  double   *varx, *vary, **tabx,**taby,resF=0, *reschi2G, *indica;
  int i,j,k,l,lL,cL,cQ,cR,vR,vQ, *nvR, *nvQ, *assignR, *assignQ, *typR, *typQ,dimx=0,dimy=0,npermut;
  
  /* Allocation memoire pour les variables C locales */
  cR = *ncolR;
  cQ = *ncolQ;
  vR = *nvarR;
  vQ = *nvarQ;
  cL = *ncL;
  lL = *nlL;
  
  taballoc (&XR, lL, cR);
  taballoc (&XL, lL, cL);
  taballoc (&XLpermute, lL, cL);
  taballoc (&XQ, cL, cQ);
  
  taballoc (&XD, *nrepet + 1, cQ * cR);
  taballoc (&XG, *nrepet + 1, vQ * vR);  
  taballoc (&XD2, *nrepet + 1, cQ * cR);
  
  vecintalloc (&nvR, vR);
  vecintalloc (&nvQ, vQ);
  vecintalloc (&typR, vR);
  vecintalloc (&typQ, vQ);
  vecintalloc (&assignR, cR);
  vecintalloc (&assignQ, cQ);
  
  /* Passage des objets R en C */    
  k = 0;
  for (i=1; i<=lL; i++) {
    for (j=1; j<=cL; j++) {
      XL[i][j] = tabL[k];
      k = k + 1;
    }
  }

  k = 0;
  for (i=1; i<=lL; i++) {
    for (j=1; j<=cR; j++) {
      XR[i][j] = tabR[k];
      k = k + 1;
    }
  }
    
  k = 0;
  for (i=1; i<=cL; i++) {
    for (j=1; j<=cQ; j++) {
      XQ[i][j] = tabQ[k];
      k = k + 1;
    }
  }
    
  for (i=1; i<=cR; i++) { assignR[i]=RassignR[i-1];   }
  for (i=1; i<=cQ; i++) { assignQ[i]=RassignQ[i-1];   }
  for (i=1; i<=vR; i++) { typR[i]=RtypR[i-1];   }
  for (i=1; i<=vQ; i++) { typQ[i]=RtypQ[i-1];   }
    

  /* Numero de colonne auquel commence une variable */

  nvR[1]=1;
  nvQ[1]=1;
  for (i=2;i<=cR;i++) {
    if (assignR[i]!=assignR[i-1]){nvR[assignR[i]]=i;}
  }
 
  for (i=2;i<=cQ;i++) {
    if (assignQ[i]!=assignQ[i-1]){nvQ[assignQ[i]]=i;}
  }

  /*-----------------------------------*/
  /* ---- calculs valeurs observes ----*/
  /*-----------------------------------*/

  for (i=1;i<=vQ;i++){
    for (j=1;j<=vR;j++){

      /*  quantitatif et quantitatif */   
      /*-----------------------------*/
      if ((typQ[i]==1)&(typR[j]==1)) {
	vecalloc (&varx, lL); /*variable de R*/
	for (k=1;k<=lL;k++){
	  varx[k]=XR[k][(nvR[j])]; /*on remplit vary avec la variable j de R*/
	}
	vecalloc (&vary, cL); /*variable de Q*/
	for (l=1;l<=cL;l++){
	  vary[l]=XQ[l][(nvQ[i])]; /*on remplit vary avec la variable i de Q*/
	}
            
	XG[1][(i - 1) * vR + j]=calculcorr(XL,varx,vary);
	XD[1][(nvQ[i] - 1) * cR + (nvR[j])]= XG[1][(i - 1) * vR + j];
	XD2[1][(nvQ[i] - 1) * cR + (nvR[j])]= XG[1][(i - 1) * vR + j];
	freevec(varx);
	freevec(vary);
      } 
        
      /*  qualitatif et qualitatif */   
      /*---------------------------*/
      if ((typQ[i]==2)&(typR[j]==2)) {
	if (j==vR) {dimx=cR-nvR[j]+1;}
	else {dimx=nvR[j+1]-nvR[j];}
	if (i==vQ) {dimy=cQ-nvQ[i]+1;}
	else {dimy=nvQ[i+1]-nvQ[i];}
        
	taballoc (&tabx, lL,dimx); /*variable de R*/
	for (k=1;k<=dimx;k++){
	  for (l=1;l<=lL;l++){
	    tabx[l][k]=XR[l][(nvR[j])+k-1]; /*on remplit tabx avec la variable j de R*/
            
	  }
	}
	taballoc (&taby, cL,dimy); /*variable de Q*/
	for (k=1;k<=dimy;k++){
	  for (l=1;l<=cL;l++){
	    taby[l][k]=XQ[l][(nvQ[i])+k-1]; /*on remplit taby avec la variable i de Q*/
            
	  }
	}
            
	/* Construction du tableau de contingence */
	/* produit D=QtLtR */
	taballoc(&contingxy,dimy,dimx);
	taballoc (&LtR, cL, dimx );
	prodmatAtBC(XL,tabx,LtR);
	prodmatAtBC(taby,LtR,contingxy);
            
	vecalloc(&reschi2G,2);
	calculkhi2(contingxy,reschi2G); /*calcul du G*/
	XG[1][(i - 1) * vR + j]= reschi2G[1];
	/* XG2[i][j]= reschi2G[2]; */
	for (k=1;k<=dimx;k++){
	  for (l=1;l<=dimy;l++){
	    /*on remplit D et D2  avec les valeurs observes*/
	    XD[1][(nvQ[i] + l-1 - 1) * cR + (nvR[j] + k-1)]=contingxy[l][k]; 
	    XD2[1][(nvQ[i] + l-1 - 1) * cR + (nvR[j] + k-1)]=contingxy[l][k];
	  }
	}
            
	freetab(tabx);
	freetab(taby);
	freetab(contingxy);
	freetab(LtR);
	freevec(reschi2G);
      } 

      /*  Q quantitatif et R qualitatif */   
      /*--------------------------------*/
      if ((typQ[i]==1)&(typR[j]==2)) {
	if (j==vR) {dimx=cR-nvR[j]+1;}
	else {dimx=nvR[j+1]-nvR[j];}

	taballoc (&tabx, lL,dimx); /*variable de R*/
	for (k=1;k<=dimx;k++){
	  for (l=1;l<=lL;l++){
	    tabx[l][k]=XR[l][(nvR[j])+k-1]; /*on remplit tabx avec la variable j qualitative de R*/
            
	  }
	}
	vecalloc (&vary, cL);
	for (l=1;l<=cL;l++){
	  vary[l]=XQ[l][(nvQ[i])]; /*on remplit vary avec la variable i de Q*/
	}
            
	taballoc (&LtR, cL, lL ); /* on transpose L*/
	for (l=1;l<=lL;l++){
	  for (k=1;k<=cL;k++){
	    LtR[k][l]=XL[l][k]; 
            
	  }
	}
          
	/* Calcul de D et du pseudo F */
	vecalloc (&varx, dimx); /*va contenir les valeurs d. une par modalite*/
	resF=calculF(LtR, tabx, vary, varx);             
             
	XG[1][(i - 1) * vR + j]= resF;
	for (k=1;k<=dimx;k++){
	  XD[1][(nvQ[i] -1) * cR + nvR[j] + k-1]=varx[k]; /*on remplit D avec les valeurs observes*/
	}
            
	vecalloc(&indica,lL);
	for (k=1;k<=dimx;k++){
	  for (l=1;l<=lL;l++){
	    indica[l]=tabx[l][k];                    
	  }
	  /*on remplit D2 avec les valeurs observes*/
	  XD2[1][(nvQ[i] - 1) * cR + nvR[j] + k-1]=calculcorr(XL,indica,vary);
                
	}
            
            
	freevec(indica);
	freetab(tabx);
	freevec(vary);
	freevec(varx);
	freetab(LtR);
      } 
      /*  R quantitatif et Q qualitatif */   
      /*--------------------------------*/
      if ((typQ[i]==2)&(typR[j]==1)) {
	if (i==vQ) {dimy=cQ-nvQ[i]+1;}
	else {dimy=nvQ[i+1]-nvQ[i];}

	taballoc (&taby, cL,dimy); /*variable de Q*/
	for (k=1;k<=dimy;k++){
	  for (l=1;l<=cL;l++){
	    taby[l][k]=XQ[l][(nvQ[i])+k-1]; /*on remplit taby avec la variable i qualitative de Q*/
            
	  }
	}
	vecalloc (&varx, lL);
	for (l=1;l<=lL;l++){
	  varx[l]=XR[l][(nvR[j])]; /*on remplit vary avec la variable j de R*/
	}
            
            
	/* Calcul de D et du pseudo F */
	vecalloc (&vary, dimy); /*va contenir les valeurs d. une par modalite*/
	resF=calculF(XL, taby, varx, vary);             
             
	XG[1][(i - 1) * vR + j]= resF;
	for (k=1;k<=dimy;k++){
	  XD[1][(nvQ[i] + k-1 -1) * cR + nvR[j]]=vary[k]; /*on remplit D avec les valeurs observes*/
                
	}

	vecalloc(&indica,cL);
	for (k=1;k<=dimy;k++){
	  for (l=1;l<=cL;l++){
	    indica[l]=taby[l][k];                    
	  }
	  XD2[1][(nvQ[i] +k-1 -1) *cR + nvR[j]]=calculcorr(XL,varx,indica); /*on remplit D avec les valeurs observes*/
                
	}
                  
	freevec(indica);         
	freetab(taby);
	freevec(vary);
	freevec(varx);
      } 





    } /* fin boucle sur les colonnes*/

  } /* fin boucle sur les lignes*/



  /*----------------------------------------*/    
  /*----------------------------------------*/
  /* ----       DEBUT PERMUTATIONS      ----*/
  /*----------------------------------------*/
  /*----------------------------------------*/


  for (npermut=1; npermut<=*nrepet;npermut++) /* Boucle permutation*/
    {

      /* modele de permutation 1*/
      if(*modeltype==1) 
	{
	  permutmodel1(XL,XLpermute,&lL,&cL);
	}
            
      /* modele de permutation 2*/
      if(*modeltype==2) 
	{
	  permutmodel2(XL,XLpermute,&lL,&cL);     
	}
            
      /* modele de permutation 3*/
      if(*modeltype==3)
	{
	  permutmodel3(XL,XLpermute,&lL,&cL);
	}
             
      /* modele de permutation 4*/
      if(*modeltype==4)
	{
	  permutmodel4(XL,XLpermute,&lL,&cL);
	}

      /* modele de permutation 5*/
      if(*modeltype==5)
	{
	  permutmodel5(XL,XLpermute,&lL,&cL);
	}
            
      /* Calcul des statistiques pour la permutation k*/

      /*----------------------------------------*/
      /* ---- calculs des valeurs permutees ----*/
      /*----------------------------------------*/

      for (i=1;i<=vQ;i++){
	for (j=1;j<=vR;j++){
        
	  /*  quantitatif et quantitatif */   
	  /*-----------------------------*/
	  if ((typQ[i]==1)&(typR[j]==1)) {
            vecalloc (&varx, lL); /*variable de R*/
            for (k=1;k<=lL;k++){
	      varx[k]=XR[k][(nvR[j])]; /*on remplit vary avec la variable j de R*/
            }
            vecalloc (&vary, cL); /*variable de Q*/
            for (l=1;l<=cL;l++){
	      vary[l]=XQ[l][(nvQ[i])]; /*on remplit vary avec la variable i de Q*/
            }
            
            XG[npermut + 1][(i - 1) * vR + j]=calculcorr(XLpermute,varx,vary);
            XD[npermut + 1][(nvQ[i] - 1) * cR + (nvR[j])]= XG[npermut + 1][(i - 1) * vR + j];
	    XD2[npermut + 1][(nvQ[i] - 1) * cR + (nvR[j])]= XG[npermut + 1][(i - 1) * vR + j];
            freevec(varx);
            freevec(vary);
            
	  } 
        
	  /*  qualitatif et qualitatif */   
	  /*---------------------------*/
	  if ((typQ[i]==2)&(typR[j]==2)) {
            if (j==vR) {dimx=cR-nvR[j]+1;}
	    else {dimx=nvR[j+1]-nvR[j];}
            if (i==vQ) {dimy=cQ-nvQ[i]+1;}
	    else {dimy=nvQ[i+1]-nvQ[i];}
        
            taballoc (&tabx, lL,dimx); /*variable de R*/
            for (k=1;k<=dimx;k++){
	      for (l=1;l<=lL;l++){
		tabx[l][k]=XR[l][(nvR[j])+k-1]; /*on remplit tabx avec la variable j de R*/
            
	      }
            }
            taballoc (&taby, cL,dimy); /*variable de Q*/
            for (k=1;k<=dimy;k++){
	      for (l=1;l<=cL;l++){
		taby[l][k]=XQ[l][(nvQ[i])+k-1]; /*on remplit taby avec la variable i de Q*/
            
	      }
            }

            /* Construction du tableau de contingence */
            /* produit D=QtLtR */
            taballoc(&contingxy,dimy,dimx);
            taballoc (&LtR, cL, dimx );
            prodmatAtBC(XLpermute,tabx,LtR);
            prodmatAtBC(taby,LtR,contingxy);
            vecalloc(&reschi2G,2);
            
            calculkhi2(contingxy,reschi2G); /*calcul du G*/
            XG[npermut + 1][(i - 1) * vR + j]=reschi2G[1]; 
            /* XG2sim[i][j]=reschi2G[2]; */ 
            for (k=1;k<=dimx;k++){
	      for (l=1;l<=dimy;l++){
		/*on remplit D avec les valeurs observes*/
		XD[npermut + 1][(nvQ[i] + l-1 - 1) * cR + (nvR[j] + k-1)]=contingxy[l][k]; 
		XD2[npermut + 1][(nvQ[i] + l-1 - 1) * cR + (nvR[j] + k-1)]=contingxy[l][k];
            
	      }
            }
            freevec(reschi2G);
            freetab(tabx);
            freetab(taby);
            freetab(contingxy);
            freetab(LtR);
	  } 

	  /*  Q quantitatif et R qualitatif */   
	  /*--------------------------------*/
	  if ((typQ[i]==1)&(typR[j]==2)) {
            if (j==vR) {dimx=cR-nvR[j]+1;}
	    else {dimx=nvR[j+1]-nvR[j];}

            taballoc (&tabx, lL,dimx); /*variable de R*/
            for (k=1;k<=dimx;k++){
	      for (l=1;l<=lL;l++){
		tabx[l][k]=XR[l][(nvR[j])+k-1]; /*on remplit tabx avec la variable j qualitative de R*/
            
	      }
            }
            vecalloc (&vary, cL);
            for (l=1;l<=cL;l++){
	      vary[l]=XQ[l][(nvQ[i])]; /*on remplit vary avec la variable i de Q*/
            }
            
            taballoc (&LtR, cL, lL ); /* on transpose L*/
            for (l=1;l<=lL;l++){
	      for (k=1;k<=cL;k++){
		LtR[k][l]=XLpermute[l][k]; 
            
	      }
            }
            
            /* Calcul de D et du pseudo F */
            vecalloc (&varx, dimx); /*va contenir les valeurs d. une par modalite*/
	    resF=calculF(LtR, tabx, vary, varx);             
             
	    XG[npermut + 1][(i - 1) * vR + j]= resF;
            for (k=1;k<=dimx;k++){
	      XD[npermut + 1][(nvQ[i] -1) * cR + nvR[j] + k-1]=varx[k]; /*on remplit D avec les valeurs observes*/
	    }
            vecalloc(&indica,lL);
            for (k=1;k<=dimx;k++){
	      for (l=1;l<=lL;l++){
		indica[l]=tabx[l][k];                    
	      }
	      /*on remplit D avec les valeurs observes*/
	      XD2[npermut + 1][(nvQ[i] - 1) * cR + nvR[j] + k-1]=calculcorr(XLpermute,indica,vary);
	    }
            
            
            freevec(indica);           
            freetab(tabx);
            freevec(vary);
            freevec(varx);
            freetab(LtR);
	  } 
	  /*  Q qualitatif et R quantitatif */   
	  /*--------------------------------*/
	  if ((typQ[i]==2)&(typR[j]==1)) {
            if (i==vQ) {dimy=cQ-nvQ[i]+1;}
	    else {dimy=nvQ[i+1]-nvQ[i];}

            taballoc (&taby, cL,dimy); /*variable de Q*/
            for (k=1;k<=dimy;k++){
	      for (l=1;l<=cL;l++){
		taby[l][k]=XQ[l][(nvQ[i])+k-1]; /*on remplit taby avec la variable i qualitative de Q*/
            
	      }
            }
            vecalloc (&varx, lL);
            for (l=1;l<=lL;l++){
	      varx[l]=XR[l][(nvR[j])]; /*on remplit varx avec la variable j de R*/
            }
            
            
            /* Calcul de D et du pseudo F */
            vecalloc (&vary, dimy); /*va contenir les valeurs d. une par modalite*/
	    resF=calculF(XLpermute, taby, varx, vary);             
             
            XG[npermut + 1][(i - 1) * vR + j]= resF;
            for (k=1;k<=dimy;k++){
	      /*on remplit D avec les valeurs observes*/
	      XD[npermut + 1][(nvQ[i] + k-1 -1) * cR + nvR[j]]=vary[k];
		
	    }
            vecalloc(&indica,cL);
            for (k=1;k<=dimy;k++){
	      for (l=1;l<=cL;l++){
		indica[l]=taby[l][k];                    
	      }
	      /*on remplit D avec les valeurs observes*/
	      XD2[npermut + 1][(nvQ[i] +k-1 -1) *cR + nvR[j]]=calculcorr(XLpermute,varx,indica);
	    }
            
            
            freevec(indica);         
	    freetab(taby);
            freevec(vary);
            freevec(varx);
	  } 

      
     

       
       
            
        
	} /* fin boucle sur les colonnes*/

      } /* fin boucle sur les lignes*/

    } /* fin boucle permutation . npermut incremente*/




  /* On renvoie les valeurs dans R*/
    
  k = 0;
  for (npermut = 1; npermut <= (*nrepet) + 1; npermut++) 
    {
      for (j=1; j<= cQ * cR; j++) 
	{
	  tabD[k]= XD[npermut][j]; /* D observe */
	  tabD2[k]= XD2[npermut][j]; /* D observe */
	  k = k + 1;
	}
    }
  
  k = 0;
  for (npermut = 1; npermut <= (*nrepet) + 1; npermut++) 
    {
      for (j=1; j<= vQ * vR ; j++) 
	{
	  tabG[k]= XG[npermut][j]; /* G observe */
	  k = k + 1;
	}
    }

 

    
  


  freetab(XR);
  freetab(XL);
  freetab(XQ);
  freetab(XLpermute);

  freetab(XD);
  freetab(XG);
  freetab(XD2);

  freeintvec (nvR);
  freeintvec (nvQ);
  freeintvec (typR);
  freeintvec (typQ);
  freeintvec (assignR);
  freeintvec (assignQ);

}


/*=============================================================*/
/*==================================================================*/

void quatriemecoin2 (double *tabR, double *tabL, 
		     double *tabQ , int *ncolR, int *nvarR, int *nlL,
		     int *ncL, int *ncolQ, int *nvarQ,int *nrepet, int *modeltype,
		     double *tabG, double *trRLQ,
		     int *RtypR,int *RtypQ, int *RassignR, int *RassignQ)
                       
{
  /* Calcul quatrieme coin de type rlq (r2, rapport de correlation ou chi2/n */
  /* couplage quantitative/quantitative OU qualitative/quantitative OU qualitative/qualitative */


  /* tabG resutlats globaux (Chi2/n pour quali/quali) observes */

  /* typR et typQ vecteur avec le type de chaque variable (1=quant, 2=qual) longueur nvarR et nvarQ */
  /* assignR et assignQ vecteur avec le numero de variable pour chaque colonne de R et Q longueur ncolR et ncolQ */

  /* le tableau est transpose par rapport a l'article original mais
     on garde la typologie des modeles par rapport a espece/site et non ligne colonne
     Par exemple,
     model 1 permute dans les espece independament (lignes dans l'article original), donc dans chaque colonne ici... */

  /* Declarations de variables C locales */
  double  **XR,**XL,**XQ,**LtR, **XG;
  double  **XLpermute,**contingxy;
  double  *varx, *vary, **tabx,**taby,resF=0, *reschi2G, *indica;
  int i,j,k,l,lL,cL,cQ,cR,vR,vQ, *nvR, *nvQ, *assignR, *assignQ, *typR, *typQ,dimx=0,dimy=0,npermut;


  /* Allocation memoire pour les variables C locales */
  cR = *ncolR;
  cQ = *ncolQ;
  vR = *nvarR;
  vQ = *nvarQ;
  cL = *ncL;
  lL = *nlL;

  taballoc (&XR, lL, cR);
  taballoc (&XL, lL, cL);
  taballoc (&XLpermute, lL, cL);
  taballoc (&XQ, cL, cQ);
  taballoc (&XG, *nrepet + 1, vQ * vR);

  vecintalloc (&nvR, vR);
  vecintalloc (&nvQ, vQ);
  vecintalloc (&typR, vR);
  vecintalloc (&typQ, vQ);
  vecintalloc (&assignR, cR);
  vecintalloc (&assignQ, cQ);

  /* Passage des objets R en C */    
  k = 0;
  for (i=1; i<=lL; i++) {
    for (j=1; j<=cL; j++) {
      XL[i][j] = tabL[k];
      k = k + 1;
    }
  }

  k = 0;
  for (i=1; i<=lL; i++) {
    for (j=1; j<=cR; j++) {
      XR[i][j] = tabR[k];
      k = k + 1;
    }
  }
    
  k = 0;
  for (i=1; i<=cL; i++) {
    for (j=1; j<=cQ; j++) {
      XQ[i][j] = tabQ[k];
      k = k + 1;
    }
  }
    
  for (i=1; i<=cR; i++) { assignR[i]=RassignR[i-1];   }
  for (i=1; i<=cQ; i++) { assignQ[i]=RassignQ[i-1];   }
  for (i=1; i<=vR; i++) { typR[i]=RtypR[i-1];   }
  for (i=1; i<=vQ; i++) { typQ[i]=RtypQ[i-1];   }
    

  /* Numero de colonne auquel commence une variable */

  nvR[1]=1;
  nvQ[1]=1;
  for (i=2;i<=cR;i++) {
    if (assignR[i]!=assignR[i-1]){nvR[assignR[i]]=i;}
  }
 
  for (i=2;i<=cQ;i++) {
    if (assignQ[i]!=assignQ[i-1]){nvQ[assignQ[i]]=i;}
  }

  /*-----------------------------------*/
  /* ---- calculs valeurs observes ----*/
  /*-----------------------------------*/

  for (i=1;i<=vQ;i++){
    for (j=1;j<=vR;j++){
        
      /*  quantitatif et quantitatif */   
      /*-----------------------------*/
      if ((typQ[i]==1)&(typR[j]==1)) {
	vecalloc (&varx, lL); /*variable de R*/
	for (k=1;k<=lL;k++){
	  varx[k]=XR[k][(nvR[j])]; /*on remplit vary avec la variable j de R*/
	}
	vecalloc (&vary, cL); /*variable de Q*/
	for (l=1;l<=cL;l++){
	  vary[l]=XQ[l][(nvQ[i])]; /*on remplit vary avec la variable i de Q*/
	}
            
	XG[1][(i - 1) * vR + j]=pow(calculcorr(XL,varx,vary),2);
	freevec(varx);
	freevec(vary);
      } 
        
      /*  qualitatif et qualitatif */   
      /*---------------------------*/
      if ((typQ[i]==2)&(typR[j]==2)) {
	if (j==vR) {dimx=cR-nvR[j]+1;}
	else {dimx=nvR[j+1]-nvR[j];}
	if (i==vQ) {dimy=cQ-nvQ[i]+1;}
	else {dimy=nvQ[i+1]-nvQ[i];}
        
	taballoc (&tabx, lL,dimx); /*variable de R*/
	for (k=1;k<=dimx;k++){
	  for (l=1;l<=lL;l++){
	    tabx[l][k]=XR[l][(nvR[j])+k-1]; /*on remplit tabx avec la variable j de R*/
            
	  }
	}
	taballoc (&taby, cL,dimy); /*variable de Q*/
	for (k=1;k<=dimy;k++){
	  for (l=1;l<=cL;l++){
	    taby[l][k]=XQ[l][(nvQ[i])+k-1]; /*on remplit taby avec la variable i de Q*/
            
	  }
	}
            
	/* Construction du tableau de contingence */
	/* produit D=QtLtR */
	taballoc(&contingxy,dimy,dimx);
	taballoc (&LtR, cL, dimx );
	prodmatAtBC(XL,tabx,LtR);
	prodmatAtBC(taby,LtR,contingxy);           
	    
	XG[1][(i - 1) * vR + j]= calculkhi2surn(contingxy);          
                        
	freetab(tabx);
	freetab(taby);
	freetab(contingxy);
	freetab(LtR);
      } 

      /*  Q quantitatif et R qualitatif */   
      /*--------------------------------*/
      if ((typQ[i]==1)&(typR[j]==2)) {
	if (j==vR) {dimx=cR-nvR[j]+1;}
	else {dimx=nvR[j+1]-nvR[j];}

	taballoc (&tabx, lL,dimx); /*variable de R*/
	for (k=1;k<=dimx;k++){
	  for (l=1;l<=lL;l++){
	    tabx[l][k]=XR[l][(nvR[j])+k-1]; /*on remplit tabx avec la variable j qualitative de R*/
            
	  }
	}
	vecalloc (&vary, cL);
	for (l=1;l<=cL;l++){
	  vary[l]=XQ[l][(nvQ[i])]; /*on remplit vary avec la variable i de Q*/
	}
            
	taballoc (&LtR, cL, lL ); /* on transpose L*/
	for (l=1;l<=lL;l++){
	  for (k=1;k<=cL;k++){
	    LtR[k][l]=XL[l][k]; 
            
	  }
	}
          
	/* Calcul du rapport de correlation*/
	XG[1][(i - 1) * vR + j]= calculcorratio(LtR, tabx, vary); 
 
	freetab(tabx);
	freevec(vary);
	freetab(LtR);
      } 
      /*  R quantitatif et Q qualitatif */   
      /*--------------------------------*/
      if ((typQ[i]==2)&(typR[j]==1)) {
	if (i==vQ) {dimy=cQ-nvQ[i]+1;}
	else {dimy=nvQ[i+1]-nvQ[i];}

	taballoc (&taby, cL,dimy); /*variable de Q*/
	for (k=1;k<=dimy;k++){
	  for (l=1;l<=cL;l++){
	    taby[l][k]=XQ[l][(nvQ[i])+k-1]; /*on remplit taby avec la variable i qualitative de Q*/
            
	  }
	}
	vecalloc (&varx, lL);
	for (l=1;l<=lL;l++){
	  varx[l]=XR[l][(nvR[j])]; /*on remplit vary avec la variable j de R*/
	}
            
            
	/* Calcul du rapport de correlation */
                  
	XG[1][(i - 1) * vR + j]= calculcorratio(XL, taby, varx); 
                   
	freetab(taby);
	freevec(varx);
      } 



      trRLQ[0]=trRLQ[0] + XG[1][(i - 1) * vR + j];

    } /* fin boucle sur les colonnes*/

  } /* fin boucle sur les lignes*/




  /*----------------------------------------*/    
  /*----------------------------------------*/
  /* ----       DEBUT PERMUTATIONS      ----*/
  /*----------------------------------------*/
  /*----------------------------------------*/


  for (npermut=1; npermut<=*nrepet;npermut++) /* Boucle permutation*/
    {
      /* modele de permutation 1*/
      if(*modeltype==1) 
	{
	  permutmodel1(XL,XLpermute,&lL,&cL);
	}
            
      /* modele de permutation 2*/
      if(*modeltype==2) 
	{
	  permutmodel2(XL,XLpermute,&lL,&cL);     
	}
            
      /* modele de permutation 3*/
      if(*modeltype==3)
	{
	  permutmodel3(XL,XLpermute,&lL,&cL);
	}
             
      /* modele de permutation 4*/
      if(*modeltype==4)
	{
	  permutmodel4(XL,XLpermute,&lL,&cL);
	}

      /* modele de permutation 5*/
      if(*modeltype==5)
	{
	  permutmodel5(XL,XLpermute,&lL,&cL);
	}
            
      /* Calcul des statistiques pour la permutation k*/

      /*----------------------------------------*/
      /* ---- calculs des valeurs permutees ----*/
      /*----------------------------------------*/

      for (i=1;i<=vQ;i++){
	for (j=1;j<=vR;j++){
        
	  /*  quantitatif et quantitatif */   
	  /*-----------------------------*/
	  if ((typQ[i]==1)&(typR[j]==1)) {
            vecalloc (&varx, lL); /*variable de R*/
            for (k=1;k<=lL;k++){
	      varx[k]=XR[k][(nvR[j])]; /*on remplit vary avec la variable j de R*/
            }
            vecalloc (&vary, cL); /*variable de Q*/
            for (l=1;l<=cL;l++){
	      vary[l]=XQ[l][(nvQ[i])]; /*on remplit vary avec la variable i de Q*/
            }
            
	    XG[npermut + 1][(i - 1) * vR + j]=pow(calculcorr(XLpermute,varx,vary),2);
           
            freevec(varx);
            freevec(vary);
            
	  } 
        
	  /*  qualitatif et qualitatif */   
	  /*---------------------------*/
	  if ((typQ[i]==2)&(typR[j]==2)) {
            if (j==vR) {dimx=cR-nvR[j]+1;}
	    else {dimx=nvR[j+1]-nvR[j];}
            if (i==vQ) {dimy=cQ-nvQ[i]+1;}
	    else {dimy=nvQ[i+1]-nvQ[i];}
        
            taballoc (&tabx, lL,dimx); /*variable de R*/
            for (k=1;k<=dimx;k++){
	      for (l=1;l<=lL;l++){
		tabx[l][k]=XR[l][(nvR[j])+k-1]; /*on remplit tabx avec la variable j de R*/
            
	      }
            }
            taballoc (&taby, cL,dimy); /*variable de Q*/
            for (k=1;k<=dimy;k++){
	      for (l=1;l<=cL;l++){
		taby[l][k]=XQ[l][(nvQ[i])+k-1]; /*on remplit taby avec la variable i de Q*/
            
	      }
            }

            /* Construction du tableau de contingence */
            /* produit D=QtLtR */
            taballoc(&contingxy,dimy,dimx);
            taballoc (&LtR, cL, dimx );
            prodmatAtBC(XLpermute,tabx,LtR);
            prodmatAtBC(taby,LtR,contingxy);
            
            XG[npermut + 1][(i - 1) * vR + j]=calculkhi2surn(contingxy); /*calcul du chi/n*/
           
            
            freetab(tabx);
            freetab(taby);
            freetab(contingxy);
            freetab(LtR);
	  } 

	  /*  Q quantitatif et R qualitatif */   
	  /*--------------------------------*/
	  if ((typQ[i]==1)&(typR[j]==2)) {
            if (j==vR) {dimx=cR-nvR[j]+1;}
	    else {dimx=nvR[j+1]-nvR[j];}

            taballoc (&tabx, lL,dimx); /*variable de R*/
            for (k=1;k<=dimx;k++){
	      for (l=1;l<=lL;l++){
		tabx[l][k]=XR[l][(nvR[j])+k-1]; /*on remplit tabx avec la variable j qualitative de R*/
            
	      }
            }
            vecalloc (&vary, cL);
            for (l=1;l<=cL;l++){
	      vary[l]=XQ[l][(nvQ[i])]; /*on remplit vary avec la variable i de Q*/
            }
            
            taballoc (&LtR, cL, lL ); /* on transpose L*/
            for (l=1;l<=lL;l++){
	      for (k=1;k<=cL;k++){
		LtR[k][l]=XLpermute[l][k]; 
            
	      }
            }
            
            /* Calcul de D et du pseudo F */
           
	    XG[npermut + 1][(i - 1) * vR + j]= calculcorratio(LtR, tabx, vary); 
             
            freetab(tabx);
            freevec(vary);
           
            freetab(LtR);
	  } 
	  /*  Q qualitatif et R quantitatif */   
	  /*--------------------------------*/
	  if ((typQ[i]==2)&(typR[j]==1)) {
            if (i==vQ) {dimy=cQ-nvQ[i]+1;}
	    else {dimy=nvQ[i+1]-nvQ[i];}

            taballoc (&taby, cL,dimy); /*variable de Q*/
            for (k=1;k<=dimy;k++){
	      for (l=1;l<=cL;l++){
		taby[l][k]=XQ[l][(nvQ[i])+k-1]; /*on remplit taby avec la variable i qualitative de Q*/
            
	      }
            }
            vecalloc (&varx, lL);
            for (l=1;l<=lL;l++){
	      varx[l]=XR[l][(nvR[j])]; /*on remplit varx avec la variable j de R*/
            }
            
            
            /* Calcul de D et du pseudo F */
	    XG[npermut + 1][(i - 1) * vR + j]= calculcorratio(XLpermute, taby, varx);   
                
            
            freetab(taby);
            freevec(varx);
	  } 

       

	  trRLQ[npermut] = trRLQ[npermut] + XG[npermut + 1][(i - 1) * vR + j];
           
        
	} /* fin boucle sur les colonnes*/

      } /* fin boucle sur les lignes*/
    } /* fin boucle permutation . npermut incremente*/


  /* On renvoie les valeurs dans R*/
    
  k = 0;
  for (npermut = 1; npermut <= (*nrepet) + 1; npermut++) 
    {
      for (j=1; j<= vQ * vR ; j++) 
	{
	  tabG[k]= XG[npermut][j]; /* G observe */
	  k = k + 1;
	}
    }

  freetab(XR);
  freetab(XL);
  freetab(XQ);
  freetab(XLpermute);
  freetab(XG);

  freeintvec (nvR);
  freeintvec (nvQ);
  freeintvec (typR);
  freeintvec (typQ);
  freeintvec (assignR);
  freeintvec (assignQ);


}
/*=============================================================*/
void quatriemecoinRLQ (double *tabR, double *tabL, double *tabQ,
		       int *ncolR, int *nvarR, int *nlL, int *ncL,
		       int *ncolQ, int *nvarQ,
		       int *nrepet, int *modeltype,
		       double *tabD, double *tabD2, double *tabG,
		       int *nrowD, int *ncolD, int *nrowG, int *ncolG,
                       int *RtypR, int *RtypQ, int *RassignR, int *RassignQ,
		       double *c1, double *l1, int *typeTest, int *naxes, int *typAnalRr, int *typAnalQr,
		       double *pcRr, double *pcQr)
       
{

  /* Calcul quatrieme coin sur analyse RLQ*/
  /* couplage quantitative/quantitative OU qualitative/quantitative  */

  /* resultats dans tabD statistique pour chaque cellule (homogeneite ds le cas quanti/quali)*/
  /* resultats dans tabD2 statistique pour chaque cellule (r ds le cas quanti/quali)*/
  /* tabG resutlats globaux observes */
  /* typR et typQ vecteur avec le type de chaque variable (1=quant, 2=qual) longueur nvarR et nvarQ */
  /* assignR et assignQ vecteur avec le numero de variable pour chaque colonne de R et Q longueur ncolR et ncolQ */

  /* le tableau est transpose par rapport a l'article original mais
     on garde la typologie des modeles par rapport a espece/site et non ligne colonne
     Par exemple,
     model 1 permute dans les espece independament (lignes dans l'article original), donc dans chaque colonne ici... */

  /* Declarations de variables C locales */
  double  **XR,**XL,**XQ,**XD, **XD2, **XG, **LtR;
  double  **XLpermute, **contingxy;
  double  *varx, *vary, **tabx,**taby,resF=0, *reschi2G, *indica;
  int i,j,k,l,lL,cL,cQ,cR,vR,vQ, *nvR, *nvQ, *assignR, *assignQ, *typR, *typQ,dimx=0,dimy=0,npermut;
  int    typAnalR, typAnalQ;
  double  **tabc1, **tabl1, **axesR, **axesQ, *pcR, *pcQ, **initR, **initQ, Ntot=0.0, *pcL, *plL;
    

  /* Allocation memoire pour les variables C locales */

  cR = *ncolR;
  cQ = *ncolQ;
  vR = *nvarR;
  vQ = *nvarQ;
  cL = *ncL;
  lL = *nlL;

  typAnalR =  *typAnalRr;
  typAnalQ =  *typAnalQr;

  vecalloc (&pcR, cR);
  vecalloc (&pcQ, cQ);
  vecalloc (&pcL, cL);
  vecalloc (&plL, lL);
  
  if ((*typeTest==1) || (*typeTest==2)) {
    /*axes or R.axes
      R. axes measures the link between table R and axes (axesQ)*/
    taballoc (&tabc1, cQ, *naxes); 
    taballoc (&axesQ, cL, *naxes);
  }

  if ((*typeTest==1) || (*typeTest==3)) {
    /*axes or Q.axes*/
    taballoc (&tabl1, cR, *naxes);
    taballoc (&axesR, lL, *naxes);

  }

  
  taballoc (&initR, lL, cR); 
  taballoc (&initQ, cL, cQ); 
  
  taballoc (&XR, lL, cR);
  taballoc (&XL, lL, cL);
  taballoc (&XLpermute, lL, cL);
  taballoc (&XQ, cL, cQ);


  taballoc (&XD, *nrepet + 1, (*nrowD) * (*ncolD));
  taballoc (&XG, *nrepet + 1, (*nrowG) * (*ncolG));  
  taballoc (&XD2, *nrepet + 1, (*nrowD) * (*ncolD));


  vecintalloc (&nvR, vR);
  vecintalloc (&nvQ, vQ);
  vecintalloc (&typR, vR);
  vecintalloc (&typQ, vQ);
  vecintalloc (&assignR, cR);
  vecintalloc (&assignQ, cQ);

  /* Passage des objets R en C */    
  k = 0;
  for (i=1; i<=lL; i++) {
    for (j=1; j<=cL; j++) {
      XL[i][j] = tabL[k];
      Ntot = Ntot + tabL[k];
      k = k + 1;
    }
  }

  k = 0;
  for (i=1; i<=lL; i++) {
    for (j=1; j<=cR; j++) {
      XR[i][j] = tabR[k];
      initR[i][j] = tabR[k];
      k = k + 1;
    }
  }
    
  k = 0;
  for (i=1; i<=cL; i++) {
    for (j=1; j<=cQ; j++) {
      XQ[i][j] = tabQ[k];
      initQ[i][j] = tabQ[k];
      k = k + 1;
    }
  }



  if ((*typeTest==1) || (*typeTest==2)) {
    /*axes or R.axes*/
    k = 0;
    for (i=1; i<=cQ; i++) {
      for (j=1; j<= *naxes; j++) {
	tabc1[i][j] = c1[k];
	k = k + 1;
      }
    }
   
  }

  if ((*typeTest==1) || (*typeTest==3)) {
    /*axes or Q.axes*/
    k = 0;
    for (i=1; i<=cR; i++) {
      for (j=1; j<= *naxes; j++) {
	tabl1[i][j] = l1[k];
	k = k + 1;
      }
    }

  }


  /* Compute row and column weights*/
  
  for (i=1; i<=lL; i++) {
    for (j=1; j<=cL; j++) {
      pcL[j]=pcL[j] + XL[i][j] / Ntot;
      plL[i]=plL[i] + XL[i][j] / Ntot;
      
    }
  }
  
    
  
  for (i=1; i<=cR; i++) { assignR[i]=RassignR[i-1];   }
  for (i=1; i<=cQ; i++) { assignQ[i]=RassignQ[i-1];   }
  for (i=1; i<=vR; i++) { typR[i]=RtypR[i-1];   }
  for (i=1; i<=vQ; i++) { typQ[i]=RtypQ[i-1];   }

  for (i=1; i<=cR; i++) {
    pcR[i] = pcRr[i-1];
  }
  for (i=1; i<=cQ; i++) {
    pcQ[i] = pcQr[i-1];
  }

  /* Numero de colonne auquel commence une variable */

  nvR[1]=1;
  nvQ[1]=1;
  for (i=2;i<=cR;i++) {
    if (assignR[i]!=assignR[i-1]){nvR[assignR[i]]=i;}
  }
 
  for (i=2;i<=cQ;i++) {
    if (assignQ[i]!=assignQ[i-1]){nvQ[assignQ[i]]=i;}
  }

  /*-----------------------------------*/
  /* ---- calculs valeurs observes ----*/
  /*-----------------------------------*/
  
  if ((*typeTest==1) || (*typeTest==2)) {
    /*axes or R.axes
      compute lQ= Q * Dq * c1 (axesQ linear combination of traits) */
    if (typAnalQ == 8) {
      matcentragehi(XQ,pcL,typQ,assignQ);
    }
    else {
      matcentrage (XQ, pcL, typAnalQ);
    }

    prodmatAdBC(XQ,pcQ, tabc1,axesQ);

  }
  
  if ((*typeTest==1) || (*typeTest==3)) {
    /*axes or Q.axes*/
    if (typAnalR == 8) {
      matcentragehi(XR,plL,typR,assignR);
    }
    else {matcentrage (XR, plL, typAnalR);
    }
    
    prodmatAdBC(XR,pcR, tabl1,axesR);

  }

  if (*typeTest==1){
    vecalloc (&vary, cL); /* Q axes*/
    vecalloc (&varx, lL); /* R axes*/
    /* axes and axes */
    for (i=1;i<= *naxes;i++){
      for (j=1;j<= *naxes;j++){  
	  
	for (k=1;k<=lL;k++){
	  varx[k]=axesR[k][j]; /* fill 'varx' the j-th linear combination of R variables*/
	}
	for (l=1;l<=cL;l++){
	  vary[l]=axesQ[l][i]; /*fill 'vary' the i-th linear combination of Q variables */
	}
	XG[1][(i-1) * (*ncolG) +j]=calculcorr(XL,varx,vary);
	XD[1][(i-1) * (*ncolD) +j]=XG[1][(i-1) * (*ncolG) +j];
	XD2[1][(i-1) * (*ncolD) +j]=XG[1][(i-1) * (*ncolG) +j];
      }    
    }
    freevec(varx);
    freevec(vary);
  }

  if (*typeTest==2){
    /* R.axes*/
    vecalloc (&vary, cL); /* Q axis */
    for (i=1;i<= *naxes;i++){
      for (l=1;l<=cL;l++){
	vary[l]=axesQ[l][i]; /* fill 'vary' the i-th linear combination of Q variables */
      }
	
      for (j=1;j<= vR;j++){ 
	/* R quantitative */
	if (typR[j]==1) {
	  vecalloc (&varx, lL);
	  for (k=1;k<=lL;k++){
	    varx[k]=XR[k][(nvR[j])]; /* remplit varx avec la variable de R*/
	  }
	  XG[1][(i-1) * (*ncolG) + j]=calculcorr(XL,varx,vary);
	  XD[1][(i-1) * (*ncolD) + (nvR[j])]=XG[1][(i-1) * (*ncolG) +j];
	  XD2[1][(i-1) * (*ncolD) + (nvR[j])]=XG[1][(i-1) * (*ncolG) +j];
	  freevec(varx);
	}    
	  
	/* R qualitative */
	if (typR[j]==2) {
	  if (j==vR) {dimx=cR-nvR[j]+1;}
	  else {dimx=nvR[j+1]-nvR[j];}
	    
	  taballoc (&tabx, lL,dimx); /*variable de R*/
	  for (k=1;k<=dimx;k++){
	    for (l=1;l<=lL;l++){
	      tabx[l][k]=XR[l][(nvR[j])+k-1]; /*on remplit tabx avec la variable j qualitative de R*/
		
	    }
	  }
	    
	  taballoc (&LtR, cL, lL ); /* on transpose L*/
	  for (l=1;l<=lL;l++){
	    for (k=1;k<=cL;k++){
	      LtR[k][l]=XL[l][k]; 
		
	    }
	  }
	    
	  /* Calcul de D et du pseudo F */
	  vecalloc (&varx, dimx); /*va contenir les valeurs d. une par modalite*/
	  
	  resF=calculF(LtR, tabx, vary, varx);             
	    
	  XG[1][(i-1) * (*ncolG) +j]= resF;
	  for (k=1;k<=dimx;k++){
	    XD[1][(i-1) * (*ncolD) + (nvR[j]) + k-1]=varx[k]; /*on remplit D avec les valeurs observes*/
	  }
            
	  vecalloc(&indica,lL);
	  for (k=1;k<=dimx;k++){
	    for (l=1;l<=lL;l++){
	      indica[l]=tabx[l][k];                    
	    }
	    XD2[1][(i-1) * (*ncolD) + (nvR[j]) + k-1]=calculcorr(XL,indica,vary); /*on remplit D avec les valeurs observes*/
	      
	  }
            
            
	  freevec(indica);
	  freetab(tabx);
	  freevec(varx);
	  
	  freetab(LtR);
	    
	}
      }
    }
    freevec(vary);	
  }
    
  if ((*typeTest==3)){
    /* Q.axes*/
    for (j=1;j<= *naxes;j++){
      vecalloc (&varx, lL); /*R axis*/
      for (l=1;l<=lL;l++){
	varx[l]=axesR[l][j]; /* fill 'varx' the j-th linear combination of R variables */
      }
	
      for (i=1;i<= vQ;i++){ 
	/* Q quantitative */
	if (typQ[i]==1) {
	  vecalloc (&vary, cL);
	  for (k=1;k<=cL;k++){
	    vary[k]=XQ[k][(nvQ[i])]; /* remplit vary avec la variable de Q*/
	  }
	  XG[1][(i-1) * (*ncolG) + j]=calculcorr(XL,varx,vary);
	  XD[1][(nvQ[i]-1) * (*ncolD) + j]=XG[1][(i-1) * (*ncolG) + j];
	  XD2[1][(nvQ[i]-1) * (*ncolD) + j]=XG[1][(i-1) * (*ncolG) + j];
	  freevec(vary);
	}    
	  
	/* Q qualitative */
	if (typQ[i]==2) {
	  if (i==vQ) {dimy=cQ-nvQ[i]+1;}
	  else {dimy=nvQ[i+1]-nvQ[i];}
	    
	  taballoc (&taby, cL,dimy); /*variable de Q*/
	  for (k=1;k<=dimy;k++){
	    for (l=1;l<=cL;l++){
	      taby[l][k]=XQ[l][(nvQ[i])+k-1]; /*on remplit taby avec la variable i qualitative de Q*/
		
	    }
	  } 
	    
	               
	  /* Calcul de D et du pseudo F */
	  vecalloc (&vary, dimy); /*va contenir les valeurs d. une par modalite*/
	  
	  resF=calculF(XL, taby, varx, vary); 
	  
	    
	  XG[1][(i-1) * (*ncolG) + j]= resF;
	  for (k=1;k<=dimy;k++){
	    XD[1][(nvQ[i]-1+ k-1) * (*ncolD) + j ]=vary[k]; /*on remplit D avec les valeurs observes*/
	  }
	    
	  vecalloc(&indica,cL);
	  for (k=1;k<=dimy;k++){
	    for (l=1;l<=cL;l++){
	      indica[l]=taby[l][k];                    
	    }
	    XD2[1][(nvQ[i]-1+ k-1) * (*ncolD) + j ]=calculcorr(XL,varx,indica); /*on remplit D avec les valeurs observes*/
	     
	  }
           
	    
	  freevec(indica);         
	  freetab(taby);
	  freevec(vary);
	    
	  
	} 
      }
    }
    freevec(varx);
  }
    
     
       
  /*----------------------------------------*/    
  /*----------------------------------------*/
  /* ----       DEBUT PERMUTATIONS      ----*/
  /*----------------------------------------*/
  /*----------------------------------------*/


  for (npermut=1; npermut<=*nrepet;npermut++) /* Boucle permutation*/
    {

            
      /* modele de permutation 2*/
      if(*modeltype==2) 
	{
	  permutmodel2(XL,XLpermute,&lL,&cL);     
	}
            
             
      /* modele de permutation 4*/
      if(*modeltype==4)
	{
	  permutmodel4(XL,XLpermute,&lL,&cL);
	}

      /* modele de permutation 5*/
      if(*modeltype==5)
	{
	  permutmodel5(XL,XLpermute,&lL,&cL);
	}
            
      /* Calcul des statistiques pour la permutation k*/

      /*----------------------------------------*/
      /* ---- calculs des valeurs permutees ----*/
      /*----------------------------------------*/

      /* Get the original tables */
      for (i=1; i<=cL; i++) {
	for (j=1; j<=cQ; j++) {
	  XQ[i][j] = initQ[i][j];
	}
      }

      for (i=1; i<=lL; i++) {
	for (j=1; j<=cR; j++) {
	  XR[i][j] = initR[i][j];
	}
      }

      /* Re-compute row and column weights*/
      for (i=1; i<=lL; i++) {plL[i]=0;}
      for (j=1; j<=cL; j++) {pcL[j]=0;}


      for (i=1; i<=lL; i++) {
	for (j=1; j<=cL; j++) {
	  pcL[j]=pcL[j] + XLpermute[i][j] / Ntot;
	  plL[i]=plL[i] + XLpermute[i][j] / Ntot;
	   
	}
      }

 
      if ((*typeTest==1) || (*typeTest==2)) {
	/*axes or R.axes */
 
	if((*modeltype==4) || (*modeltype==5)) {
	  /* modeltype=4 permute Q (i.e. column of L) */
	  if (typAnalQ == 8) {
	    /* on recalcule le poids colonne pour les qualitatives*/
	    for(j=1;j<=cQ;j++){
	      if(typQ[assignQ[j]]==2){
		pcQ[j]=0;
	      }
	    }
	    for(i=1;i<=cL;i++){
	      for(j=1;j<=cQ;j++){
		if(typQ[assignQ[j]]==2){
		  pcQ[j]=pcQ[j]+XQ[i][j]*pcL[i];
		}
	      }
	    }
	
	    matcentragehi(XQ,pcL,typQ,assignQ);
	
	  }
	  else {
	    /* on recalcule le poids colonne pour les qualitatives pour une acm*/
	    if (typAnalQ == 2) {
	      for(j=1;j<=cQ;j++){
		pcQ[j]=0;
	      }
	      for(i=1;i<=cL;i++){
		for(j=1;j<=cQ;j++){
		  pcQ[j]=pcQ[j]+XQ[i][j]*pcL[i];
		}
	      }
	      for(j=1;j<=cQ;j++){
		pcQ[j]=pcQ[j]/(cQ);
	      }	
	    }
	
	
	    matcentrage (XQ, pcL, typAnalQ);
    	

	  }
	}

	prodmatAdBC(XQ,pcQ, tabc1,axesQ);
    
      }
  
      if ((*typeTest==1) || (*typeTest==3)) {
	/*axes or Q.axes*/
	/* compute new weights and recenter  columns of R and Q */
	if((*modeltype==2) || (*modeltype==5)) {
	  /* modeltype=2 permute R (i.e. row of L) */
	  if (typAnalR == 8) {
	    for(j=1;j<=cR;j++){
	      if(typR[assignR[j]]==2){
		pcR[j]=0;
	      }
	    }
	    for(i=1;i<=lL;i++){
	      for(j=1;j<=cR;j++){
		if(typR[assignR[j]]==2){
		  pcR[j]=pcR[j]+XR[i][j]*plL[i];
		}
	      }
	    }
	    matcentragehi(XR,plL,typR,assignR);
	    /* on recalcule le poids colonne pour les qualitatives */
	  }
	  else {
	    /* on recalcule le poids colonne pour les qualitatives pour une acm*/
	    if (typAnalR == 2) {
	      for(j=1;j<=cR;j++){
		pcR[j]=0;
	      }
	      for(i=1;i<=lL;i++){
		for(j=1;j<=cR;j++){
		  pcR[j]=pcR[j]+XR[i][j]*plL[i];
		}
	      }
	      for(j=1;j<=cR;j++){
		pcR[j]=pcR[j]/(cR);				
	      }
			
	
	    }
    
	    matcentrage (XR, plL, typAnalR);
    	
    	
	  }
	}
   
	prodmatAdBC(XR,pcR, tabl1,axesR);
    
      }

      if (*typeTest==1){
	vecalloc (&vary, cL); /* Q axes*/
	vecalloc (&varx, lL); /* R axes*/
	/* axes and axes */
	for (i=1;i<= *naxes;i++){
	  for (j=1;j<= *naxes;j++){  
	  
	    for (k=1;k<=lL;k++){
	      varx[k]=axesR[k][j]; /* fill 'varx' the j-th linear combination of R variables*/
	    }
	    for (l=1;l<=cL;l++){
	      vary[l]=axesQ[l][i]; /*fill 'vary' the i-th linear combination of Q variables */
	    }
	    XG[npermut+1][(i-1) * (*ncolG) +j]=calculcorr(XLpermute,varx,vary);
	    XD[npermut+1][(i-1) * (*ncolD) +j]=XG[npermut+1][(i-1) * (*ncolG) +j];
	    XD2[npermut+1][(i-1) * (*ncolD) +j]=XG[npermut+1][(i-1) * (*ncolG) +j];
	  

	  }    
	}
	freevec(varx);
	freevec(vary);
      }

      if (*typeTest==2){
	/* R.axes*/
	vecalloc (&vary, cL); /* Q axis */
	for (i=1;i<= *naxes;i++){
	  for (l=1;l<=cL;l++){
	    vary[l]=axesQ[l][i]; /* fill 'vary' the i-th linear combination of Q variables */
	  }
	
	  for (j=1;j<= vR;j++){ 
	    /* R quantitative */
	    if (typR[j]==1) {
	      vecalloc (&varx, lL);
	      for (k=1;k<=lL;k++){
		varx[k]=XR[k][(nvR[j])]; /* remplit varx avec la variable de R*/
	      }
	      XG[npermut+1][(i-1) * (*ncolG) + j]=calculcorr(XLpermute,varx,vary);
	      XD[npermut+1][(i-1) * (*ncolD) + (nvR[j])]=XG[npermut+1][(i-1) * (*ncolG) +j];
	      XD2[npermut+1][(i-1) * (*ncolD) + (nvR[j])]=XG[npermut+1][(i-1) * (*ncolG) +j];
	      freevec(varx);
	    }    
	  
	    /* R qualitative */
	    if (typR[j]==2) {
	      if (j==vR) {dimx=cR-nvR[j]+1;}
	      else {dimx=nvR[j+1]-nvR[j];}
	    
	      taballoc (&tabx, lL,dimx); /*variable de R*/
	      for (k=1;k<=dimx;k++){
		for (l=1;l<=lL;l++){
		  tabx[l][k]=XR[l][(nvR[j])+k-1]; /*on remplit tabx avec la variable j qualitative de R*/
		
		}
	      }
	    
	      taballoc (&LtR, cL, lL ); /* on transpose L*/
	      for (l=1;l<=lL;l++){
		for (k=1;k<=cL;k++){
		  LtR[k][l]=XLpermute[l][k]; 
		
		}
	      }
	    
	      /* Calcul de D et du pseudo F */
	      vecalloc (&varx, dimx); /*va contenir les valeurs d. une par modalite*/
	     
	      resF=calculF(LtR, tabx, vary, varx);             
	    
	      XG[npermut+1][(i-1) * (*ncolG) +j]=resF;
	      for (k=1;k<=dimx;k++){
		XD[npermut+1][(i-1) * (*ncolD) + (nvR[j]) + k-1]=varx[k];
	      }
            
	      vecalloc(&indica,lL);
	      for (k=1;k<=dimx;k++){
		for (l=1;l<=lL;l++){
		  indica[l]=tabx[l][k];                    
		}
		XD2[npermut+1][(i-1) * (*ncolD) + (nvR[j]) + k-1]=calculcorr(XLpermute,indica,vary);
	      
	      }
            
            
	      freevec(indica);
	      freetab(tabx);
	      freevec(varx);
	      
	      freetab(LtR);
	    
	    }
	  }
	}
	freevec(vary);	
      }
       
      if ((*typeTest==3)){
	/* Q.axes*/
	for (j=1;j<= *naxes;j++){
	  vecalloc (&varx, lL); /*R axis*/
	  for (l=1;l<=lL;l++){
	    varx[l]=axesR[l][j]; /* fill 'varx' the j-th linear combination of R variables */
	  }
	
	  for (i=1;i<= vQ;i++){ 
	    /* Q quantitative */
	    if (typQ[i]==1) {
	      vecalloc (&vary, cL);
	      for (k=1;k<=cL;k++){
		vary[k]=XQ[k][(nvQ[i])]; /* remplit vary avec la variable de Q*/
	      }
	      XG[npermut+1][(i-1) * (*ncolG) + j]=calculcorr(XLpermute,varx,vary);
	      XD[npermut+1][(nvQ[i]-1) * (*ncolD) + j]=XG[npermut+1][(i-1) * (*ncolG) + j];
	      XD2[npermut+1][(nvQ[i]-1) * (*ncolD) + j]=XG[npermut+1][(i-1) * (*ncolG) + j];
	      freevec(vary);
	    }    
	  
	    /* Q qualitative */
	    if (typQ[i]==2) {
	      if (i==vQ) {dimy=cQ-nvQ[i]+1;}
	      else {dimy=nvQ[i+1]-nvQ[i];}
	    
	      taballoc (&taby, cL,dimy); /*variable de Q*/
	      for (k=1;k<=dimy;k++){
		for (l=1;l<=cL;l++){
		  taby[l][k]=XQ[l][(nvQ[i])+k-1]; /*on remplit taby avec la variable i qualitative de Q*/
		
		}
	      } 
	    
	               
	      /* Calcul de D et du pseudo F */
	      vecalloc (&vary, dimy); /*va contenir les valeurs d. une par modalite*/
	     
	      resF=calculF(XLpermute, taby, varx, vary);             
	      
	      XG[npermut+1][(i-1) * (*ncolG) + j]= resF;
	      for (k=1;k<=dimy;k++){
		XD[npermut+1][(nvQ[i]-1+ k-1) * (*ncolD) + j ]=vary[k];
	      }
	    
	      vecalloc(&indica,cL);
	      for (k=1;k<=dimy;k++){
		for (l=1;l<=cL;l++){
		  indica[l]=taby[l][k];                    
		}
		XD2[npermut+1][(nvQ[i]-1+ k-1) * (*ncolD) + j ]=calculcorr(XLpermute,varx,indica); 
	      
	      }
            
	    
	      freevec(indica);         
	      freetab(taby);
	      freevec(vary);
	    
	      
	    } 
	  }
	}
	freevec(varx);
      }


    

    } /* fin boucle permutation . npermut incremente*/
  
  /* On renvoie les valeurs dans R*/
    
  k = 0;
  for (npermut = 1; npermut <= (*nrepet) + 1; npermut++) 
    {
      for (j=1; j<=(*nrowD) * (*ncolD); j++) 
	{
	  tabD[k]= XD[npermut][j]; /* D observe */
	  tabD2[k]= XD2[npermut][j]; /* D observe */
	  k = k + 1;
	}
    }
  
  k = 0;
  for (npermut = 1; npermut <= (*nrepet) + 1; npermut++) 
    {
      for (j=1; j<=(*ncolG) * (*nrowG); j++) 
	{
	  tabG[k]= XG[npermut][j]; /* G observe */
	  k = k + 1;
	}
    }


  freetab(XR);
  freetab(XL);
  freetab(XQ);
  freetab(XLpermute);

  freetab(XD);
  freetab(XG);
  freetab(XD2);
  
  freeintvec (nvR);
  freeintvec (nvQ);
  freeintvec (typR);
  freeintvec (typQ);
  freeintvec (assignR);
  freeintvec (assignQ);


  freevec (pcR);
  freevec (pcQ);
  freevec (pcL);
  freevec (plL);

  freetab(initR); 
  freetab(initQ); 

  
  if ((*typeTest==1) || (*typeTest==2)) {
    /*axes or R.axes
      R. axes measures the link between table R and axes (axesQ)*/
    freetab(tabc1); 
    freetab(axesQ);
  }

  if ((*typeTest==1) || (*typeTest==3)) {
    /*axes or Q.axes*/
    freetab(tabl1);
    freetab(axesR);

  }


}

/*==================================================================*/
/*====================        Utilities        =====================*/
/*==================================================================*/

void calculkhi2 (double **obs, double *res){
  /* calcul le chi2 et G pour une table de contingence */
  /* les deux statistiques sont mises dans res. nl et nc sont nb de lignes et de colonnes */ 
  /* res1 contient chi2 et res2 contient G */


  double  **theo,tot=0;
  double  *rowsum,*colsum,res1,res2;
  int i,j,nl,nc;

  nl=obs[0][0];
  nc = obs[1][0];
  taballoc (&theo, nl, nc);
  vecalloc (&rowsum,nl);
  vecalloc (&colsum,nc);



  /* calcul des totaux*/
  for (i=1; i<=nl; i++) {
    for (j=1; j<=nc; j++) {
      rowsum[i] = rowsum[i]+obs[i][j];
      colsum[j] = colsum[j]+obs[i][j];
      tot=tot+obs[i][j];
    }
  }
  /* calcul des effectis theoriques*/
  for (i=1; i<=nl; i++) {
    for (j=1; j<=nc; j++) {
      theo[i][j] = rowsum[i]*colsum[j]/tot;
    }
  }

  /* calcul des statistiques*/
  res1=0;
  res2=0;
    
  for (i=1; i<=nl; i++) {
    for (j=1; j<=nc; j++) {
      res1 = res1+pow(theo[i][j]-obs[i][j],2)/theo[i][j]; /* chi2*/
      if (obs[i][j]>0)
	res2= res2+2*obs[i][j]*log(obs[i][j]/theo[i][j]); /* G */
    }
  }

  freevec(rowsum);
  freevec(colsum);
  freetab(theo);
  res[1]=res1;
  res[2]=res2;

}


/*==================================================================*/
double calculkhi2surn (double **obs){
  /* calcul le chi2 sur n pour une table de contingence */
  /* nl et nc sont nb de lignes et de colonnes */ 


  double  **theo,tot=0;
  double  *rowsum,*colsum,res1;
  int i,j,nl,nc;

  nl=obs[0][0];
  nc = obs[1][0];
  taballoc (&theo, nl, nc);
  vecalloc (&rowsum,nl);
  vecalloc (&colsum,nc);



  /* calcul des totaux*/
  for (i=1; i<=nl; i++) {
    for (j=1; j<=nc; j++) {
      rowsum[i] = rowsum[i]+obs[i][j];
      colsum[j] = colsum[j]+obs[i][j];
      tot=tot+obs[i][j];
    }
  }
  /* calcul des effectis theoriques*/
  for (i=1; i<=nl; i++) {
    for (j=1; j<=nc; j++) {
      theo[i][j] = rowsum[i]*colsum[j]/tot;
    }
  }

  /* calcul des statistiques*/
  res1=0;
    
  for (i=1; i<=nl; i++) {
    for (j=1; j<=nc; j++) {
      res1 = res1+pow(theo[i][j]-obs[i][j],2)/theo[i][j]; /* chi2*/
    }
  }

  freevec(rowsum);
  freevec(colsum);
  freetab(theo);
  res1=res1/tot;
  return(res1);

}


/*==================================================================*/
void vecstandar (double *tab, double *poili, double n)
/*--------------------------------------------------
 * tab est un vecteur                                
 * poili est un vecteur n composantes avec somme par ligne (somme total dans n)
 * la procedure retourne tab norme par colonne 
 * pour la ponderation poili variance en 1/n 
 --------------------------------------------------*/
{
  double      poid, z, v2,x;
  int             i, l1;
  double      moy=0, var=0;

  l1 = tab[0];

    


  /*--------------------------------------------------
   * calcul du tableau centre/norme
   --------------------------------------------------*/

  for (i=1;i<=l1;i++) {
    poid = poili[i];
    moy = moy + tab[i] * (poid/n);
  }
    
  for (i=1;i<=l1;i++) {
    poid=poili[i];
    x = tab[i] - moy;
    var = var + (poid/n) * x * x;
  }
    

  v2 = var;
  if (v2<=0) v2 = 1;
  v2 = sqrt(v2);
  var = v2;
    
 
  for (i=1;i<=l1;i++) {
    z = (tab[i] - moy)/var;
    tab[i] = z;
  }
    
}

/*=============================================================*/

double calculcorr (double **XL, double *varx, double *vary){
  /*  calcul la correlation entre varx (n) et vary (p) avec le lien exprime par L (n,p) */
  int i,j,l1,c1;
  double sumL=0, *poiR, *poiQ, *Ly, res=0;
  l1 = XL[0][0];
  c1 = XL[1][0];
  vecalloc (&poiR, l1);
  vecalloc (&poiQ, c1);
  vecalloc (&Ly, l1);

  /* normalisation des deux vecteurs avec poids provenant de L*/

  for (i=1; i<=l1; i++) {
    for (j=1; j<=c1; j++) {
      poiR[i] = poiR[i]+XL[i][j];
      poiQ[j] = poiQ[j]+XL[i][j];
      sumL=sumL+XL[i][j];
    }
  }

  vecstandar(varx, poiR, sumL);
  vecstandar(vary, poiQ, sumL);

  /* calcul de D*/
  for (i=1; i<=l1; i++) {
    for (j=1; j<=c1; j++) {
      Ly[i]=Ly[i]+XL[i][j]*vary[j];
    }
  }
  for (i=1; i<=l1; i++) {res=res+(Ly[i]*varx[i]);}

  res=res/sumL;
  freevec(poiR);
  freevec(poiQ);
  freevec(Ly);
  return(res);

}


/*=========================================================================*/
double calculF(double **XL, double **XQual, double *XQuant, double *D){             

  /*      Fonction qui prend une variable quantitative (n) et une 
	  qualitative (p) et une table de contingence L (n p) qui calcul la
	  valeur de D et la valeur d'un pseudo F (var inter/var intra)    */

  /* If the permutation is not valid for the class i, D[i] = -999.
     If the complete permutation is not valid F=-999*/ 


  /* Calcul de la valeur de d et F pour ces deux variables */    
    
  double *SY,*SY2,SX=0, SX2=0,*compt,tot=0,F;
  int lL,cL, i, j, nclass,*classvec,kk=0;
  double ScIntra, ScTotal,temp;
    
  lL = XL[0][0];
  cL = XL[1][0]; 
  nclass = XQual[1][0]; 
  /* Allocation locale */
    
  vecalloc (&compt,nclass);
  vecalloc(&SY,nclass);
  vecalloc(&SY2,nclass);
  vecintalloc(&classvec,cL);
    
  /* compt contient le nombre d'individus par classe et classvec le numero de classe de chaque individu*/
  for (i=1; i<=cL; i++)
    {
      for (j=1; j<=nclass; j++){
	if (XQual[i][j]==1){
	  classvec[i]=j;
            
	}
        
      }
    }
    
  /* Calcul des statistiques*/
    
  for (i=1; i<=lL; i++)  // Pour chaque ligne de XL
    {
      for (j=1; j<=cL; j++) // Pour chaque colone de XL
        {
	  if(XL[i][j]>0)// Si XL' n'est pas nul
            {
	      compt[classvec[j]]=compt[classvec[j]]+XL[i][j];/*nb d'individu par classe*/
	      tot=tot+XL[i][j]; /*nb total d'individu*/
	      SX=SX+XL[i][j]*XQuant[i]; /* somme des x */
	      SX2=SX2+XL[i][j]*XQuant[i]*XQuant[i]; /* somme des x^2 */
	      SY[classvec[j]]=SY[classvec[j]]+XL[i][j]*XQuant[i];
	      SY2[classvec[j]]=SY2[classvec[j]]+XL[i][j]*XQuant[i]*XQuant[i];
                
            }   
        }
    }
            
        
  ScTotal=SX2-(SX*SX)/tot;
  /* Calcul de ScIntra */
  ScIntra=0; //initialisation
    
  for (i=1;i<=nclass; i++)
    {
      if(compt[i]>1)
        {
	  temp=SY2[i]-(SY[i]*SY[i])/(double)compt[i];
	  D[i]=temp/ScTotal;
	  ScIntra=ScIntra+temp;
	  kk=kk+1;
            
        }
      else { D[i]=-999;}
                
    }
                
       
  if (kk<=1)
    {F=-999;}
  else
    {F=((ScTotal-ScIntra)/(double)(kk-1))/(ScIntra/(double)(tot-kk));}
    
  freevec(SY);
  freevec(SY2);
  freevec(compt);
  freeintvec(classvec);
  return(F);
}


/*=========================================================================*/
double calculcorratio(double **XL, double **XQual, double *XQuant){             

  /*      Fonction qui prend une variable quantitative (n) et une 
	  qualitative (p) et une table de contingence L (n p) qui calcul la
	  valeur du rapport de correlation (SS inter/SS total)    */


  /* Calcul de la valeur de d et F pour ces deux variables */    
    
  double *SY,*SY2,SX=0, SX2=0,*compt,tot=0,F;
  int lL,cL, i, j, nclass,*classvec,kk=0;
  double ScIntra, ScTotal,temp;
    
  lL = XL[0][0];
  cL = XL[1][0]; 
  nclass = XQual[1][0]; 
  /* Allocation locale */
    
  vecalloc (&compt,nclass);
  vecalloc(&SY,nclass);
  vecalloc(&SY2,nclass);
  vecintalloc(&classvec,cL);
    
  /* compt contient le nombre d'individus par classe et classvec le numero de classe de chaque individu*/
  for (i=1; i<=cL; i++)
    {
      for (j=1; j<=nclass; j++){
	if (XQual[i][j]==1){
	  classvec[i]=j;
            
	}
        
      }
    }
    
  /* Calcul des statistiques*/
    
  for (i=1; i<=lL; i++)  // Pour chaque ligne de XL
    {
      for (j=1; j<=cL; j++) // Pour chaque colone de XL
        {
	  if(XL[i][j]>0)// Si XL' n'est pas nul
            {
	      compt[classvec[j]]=compt[classvec[j]]+XL[i][j];/*nb d'individu par classe*/
	      tot=tot+XL[i][j]; /*nb total d'individu*/
	      SX=SX+XL[i][j]*XQuant[i]; /* somme des x */
	      SX2=SX2+XL[i][j]*XQuant[i]*XQuant[i]; /* somme des x^2 */
	      SY[classvec[j]]=SY[classvec[j]]+XL[i][j]*XQuant[i];
	      SY2[classvec[j]]=SY2[classvec[j]]+XL[i][j]*XQuant[i]*XQuant[i];
                
            }   
        }
    }
            
        
  ScTotal=SX2-(SX*SX)/tot;
  /* Calcul de ScIntra */
  ScIntra=0; //initialisation
    
  for (i=1;i<=nclass; i++)    
    {
      if(compt[i]>1)
	{
	  temp=SY2[i]-(SY[i]*SY[i])/(double)compt[i];
	  ScIntra=ScIntra+temp;
	  kk=kk+1;
	}
	
    } 
                
       
  if (kk<=1)
    {F=-999;}
  else
    {F=((ScTotal-ScIntra)/(ScTotal));}
    
  freevec(SY);
  freevec(SY2);
  freevec(compt);
  freeintvec(classvec);
  return(F);
}
