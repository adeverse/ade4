#include <math.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include <R.h>
#include "adesub.h"


void quatriemecoin (double *tabR, double *tabL, 
                       double *tabQ , double *tabD, int *ncolR, int *nvarR, int *nlL,
                       int *ncL, int *ncolQ, int *nvarQ,int *nrepet, int *modeltype,
                       double *tabDmoy, double *tabDmin, double *tabDmax, int *tabDNLT,
                       int *tabDNEQ, double *tabDProb, int *tabDNperm, double *tabG, double *tabGProb,
                       double *tabGmoy, double *tabGmin, double *tabGmax, int *tabGNLT,
                       int *tabGNEQ,
                       double *tabD2, double *tabD2moy, double *tabD2min, double *tabD2max, int *tabD2NLT,
                       int *tabD2NEQ, double *tabD2Prob, double *tabG2, double *tabG2Prob,
                       double *tabG2moy, double *tabG2min, double *tabG2max, int *tabG2NLT,
                       int *tabG2NEQ,
                       int *RtypR, int *RtypQ, int *RassignR, int *RassignQ);

void quatriemecoin2 (double *tabR, double *tabL, 
                       double *tabQ , int *ncolR, int *nvarR, int *nlL,
                       int *ncL, int *ncolQ, int *nvarQ,int *nrepet, int *modeltype,
                       double *tabG, double *tabGProb,
                       double *tabGmoy, double *tabGmin, double *tabGmax, int *tabGNLT,
                       int *tabGNEQ,         
                       int *RtypR, int *RtypQ, int *RassignR, int *RassignQ, double *trRLQ);

double calculcorratio(double **XL, double **XQual, double *XQuant, int *nbind);
double calculF(double **XL, double **XQual, double *XQuant, double *D, int *nbind);
double calculcorr (double **L, double *varx, double *vary);
void vecstandar (double *tab, double *poili, int n);
void calculkhi2 (double **obs, double *res);
double calculkhi2surn (double **obs);
/*void permutmodel1(double **X1,double **X1permute,int *ligL,int *colL);
still defined in testdim.c
 */



/*=============================================================*/

void quatriemecoin (double *tabR, double *tabL, 
                       double *tabQ , double *tabD, int *ncolR, int *nvarR, int *nlL,
                       int *ncL, int *ncolQ, int *nvarQ,int *nrepet, int *modeltype,
                       double *tabDmoy, double *tabDmin, double *tabDmax, int *tabDNLT,
                       int *tabDNEQ, double *tabDProb, int *tabDNperm, double *tabG, double *tabGProb,
                       double *tabGmoy, double *tabGmin, double *tabGmax, int *tabGNLT,
                       int *tabGNEQ, 
                       double *tabD2, double *tabD2moy, double *tabD2min, double *tabD2max, int *tabD2NLT,
                       int *tabD2NEQ, double *tabD2Prob, double *tabG2, double *tabG2Prob,
                       double *tabG2moy, double *tabG2min, double *tabG2max, int *tabG2NLT,
                       int *tabG2NEQ,
                       int *RtypR,int *RtypQ, int *RassignR, int *RassignQ)
                       
{
/* Calcul quatrieme coin */
/* couplage quantitative/quantitative OU qualitative/quantitative OU qualitative/qualitative */

/* resutlats dans tabD statistique pour chaque cellule (homogeneite ds le cas quanti/quali)*/
/* resutlats dans tabD2 statistique pour chaque cellule (r ds le cas quanti/quali)*/
/* Dmoy moyenne sur les repetitions */
/* Dmin minimum sur les repetitions */
/* Dmax maximum sur les repetitions */
/* DNLT nombre de repetitions avec D inferieures a observe*/
/* DNEQ nombre de repetitions avec D egales a observe */
/* DProb Probabilite*/

/* tabG resutlats globaux (Chi2 pour quali/quali) observes */
/* tabG2 resutlats globaux (G pour quali/quali) observes */
/* Gmoy moyenne sur les repetitions */
/* Gmin minimum sur les repetitions */
/* Gmax maximum sur les repetitions */
/* GNLT nombre de repetitions avec D inferieures a observe*/
/* GNEQ nombre de repetitions avec D egales a observe */
/* GProb probabilites      */
/* typR et typQ vecteur avec le type de chaque variable (1=quant, 2=qual) longueur nvarR et nvarQ */
/* assignR et assignQ vecteur avec le numero de variable pour chaque colonne de R et Q longueur ncolR et ncolQ */

/* le tableau est transpose par rapport a l'article original mais
on garde la typologie des modeles par rapport a espece/site et non ligne colonne
Par exemple,
model 1 permute dans les espece independament (lignes dans l'article original), donc dans chaque colonne ici... */

/* Declarations de variables C locales */
double  **XR,**XL,**XQ,**XD,**LtR, **XD2;
double  **XLpermute,**DMin,**DMax,**DMoy,**DProb,**XDsim, **D2Min,**D2Max,**D2Moy,**D2Prob,**XD2sim,**contingxy;
double  **GMin,**GMax,**GMoy,**GProb,**XGsim, **G2Min,**G2Max,**G2Moy,**G2Prob,**XG2sim, *varx, *vary, **XG, **XG2,
        **tabx,**taby,resF=0, *reschi2G, *indica;
int i,j,k,l,lL,cL,cQ,cR,vR,vQ, *nvR, *nvQ, *assignR, *assignQ, *typR, *typQ,dimx=0,dimy=0,npermut;
int **GNLT,**GNEQ,**DNLT,**DNEQ,**DNperm, **G2NLT,**G2NEQ,**D2NLT,**D2NEQ,*nbperm;

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
taballoc (&XD, cQ, cR);


taballoc (&DMin, cQ, cR);
taballoc (&DMax, cQ, cR);
taballoc (&DMoy, cQ, cR);
tabintalloc (&DNLT, cQ, cR);
tabintalloc (&DNEQ, cQ, cR);
tabintalloc (&DNperm, cQ, cR);
taballoc (&DProb, cQ, cR);
taballoc (&XDsim, cQ, cR);

taballoc (&XG, vQ, vR);   /* observe */
taballoc (&GMin, vQ, vR); /* minimum des permutations */
taballoc (&GMax, vQ, vR); /* maximum des permutations */
taballoc (&GMoy, vQ, vR); /* moyenne des permutations */
tabintalloc (&GNLT, vQ, vR); /* nbre de permutations inferieur a l'obs*/
tabintalloc (&GNEQ, vQ, vR); /* nbre de permutations egal a l'obs*/
taballoc (&GProb, vQ, vR); /* probabilite associe */
taballoc (&XGsim, vQ, vR); /* valeur pour une permutation donnee*/

taballoc (&XD2, cQ, cR);
taballoc (&D2Min, cQ, cR);
taballoc (&D2Max, cQ, cR);
taballoc (&D2Moy, cQ, cR);
tabintalloc (&D2NLT, cQ, cR);
tabintalloc (&D2NEQ, cQ, cR);
taballoc (&D2Prob, cQ, cR);
taballoc (&XD2sim, cQ, cR);

taballoc (&XG2, vQ, vR);   /* observe */
taballoc (&G2Min, vQ, vR); /* minimum des permutations */
taballoc (&G2Max, vQ, vR); /* maximum des permutations */
taballoc (&G2Moy, vQ, vR); /* moyenne des permutations */
tabintalloc (&G2NLT, vQ, vR); /* nbre de permutations inferieur a l'obs*/
tabintalloc (&G2NEQ, vQ, vR); /* nbre de permutations egal a l'obs*/
taballoc (&G2Prob, vQ, vR); /* probabilite associe */
taballoc (&XG2sim, vQ, vR); /* valeur pour une permutation donnee*/

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
            
            XG[i][j]=calculcorr(XL,varx,vary);
            XD[(nvQ[i])][(nvR[j])]=XG[i][j];
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
            XG[i][j]= reschi2G[1];
            XG2[i][j]= reschi2G[2];
            for (k=1;k<=dimx;k++){
                for (l=1;l<=dimy;l++){
                    XD[(nvQ[i])+l-1][(nvR[j])+k-1]=contingxy[l][k]; /*on remplit D avec les valeurs observes*/
                    
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
            vecintalloc (&nbperm, dimx); /* va contenir valeur indiquant si permutation valide ou non */
            resF=calculF(LtR, tabx, vary, varx,nbperm);             
             
            XG[i][j]= resF;
            for (k=1;k<=dimx;k++){
                XD[(nvQ[i])][(nvR[j])+k-1]=varx[k]; /*on remplit D avec les valeurs observes*/
                DNperm[(nvQ[i])][(nvR[j])+k-1]=nbperm[k];
            }
            
            vecalloc(&indica,lL);
            for (k=1;k<=dimx;k++){
                for (l=1;l<=lL;l++){
                    indica[l]=tabx[l][k];                    
                    }
                XD2[(nvQ[i])][(nvR[j])+k-1]=calculcorr(XL,indica,vary); /*on remplit D avec les valeurs observes*/
                
            }
            
            
            freevec(indica);
            freetab(tabx);
            freevec(vary);
            freevec(varx);
            freeintvec(nbperm);
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
            vecintalloc (&nbperm, dimy); 
            resF=calculF(XL, taby, varx, vary,nbperm);             
             
            XG[i][j]= resF;
            for (k=1;k<=dimy;k++){
                XD[(nvQ[i])+k-1][(nvR[j])]=vary[k]; /*on remplit D avec les valeurs observes*/
                DNperm[(nvQ[i])+k-1][(nvR[j])]=nbperm[k];
            }

            vecalloc(&indica,cL);
            for (k=1;k<=dimy;k++){
                for (l=1;l<=cL;l++){
                    indica[l]=taby[l][k];                    
                    }
                XD2[(nvQ[i])+k-1][(nvR[j])]=calculcorr(XL,varx,indica); /*on remplit D avec les valeurs observes*/
                
            }
            
           
            freevec(indica);         
            freetab(taby);
            freevec(vary);
            freevec(varx);
            freeintvec(nbperm);
        } 





} /* fin boucle sur les colonnes*/

} /* fin boucle sur les lignes*/

/* on remplit les differents elements pour les permutations */
/* Initialisation pour D */
for (i=1; i<=cQ; i++) 
    {
    for (j=1; j<=cR; j++) 
    {
        
        DMin[i][j]=XD[i][j];
        DMax[i][j]=XD[i][j];
        DMoy[i][j]=XD[i][j];
        DNEQ[i][j]=DNEQ[i][j]+1;
        D2Min[i][j]=XD2[i][j];
        D2Max[i][j]=XD2[i][j];
        D2Moy[i][j]=XD2[i][j];
        D2NEQ[i][j]=D2NEQ[i][j]+1;
        }
    }

/* Initialisation pour G */

for (i=1; i<=vQ; i++) 
    {
    for (j=1; j<=vR; j++) 
    {
        GMin[i][j]=XG[i][j];
        GMax[i][j]=XG[i][j];
        GMoy[i][j]=XG[i][j];
        GNEQ[i][j]=GNEQ[i][j]+1;
        G2Min[i][j]=XG2[i][j];
        G2Max[i][j]=XG2[i][j];
        G2Moy[i][j]=XG2[i][j];
        G2NEQ[i][j]=G2NEQ[i][j]+1;

        }
    }

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
            
            XGsim[i][j]=calculcorr(XLpermute,varx,vary);
            XDsim[(nvQ[i])][(nvR[j])]=XGsim[i][j];
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
            XGsim[i][j]=reschi2G[1]; 
            XG2sim[i][j]=reschi2G[2]; 
            for (k=1;k<=dimx;k++){
                for (l=1;l<=dimy;l++){
                    XDsim[(nvQ[i])+l-1][(nvR[j])+k-1]=contingxy[l][k]; /*on remplit D avec les valeurs observes*/
            
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
            vecintalloc (&nbperm, dimx);
            resF=calculF(LtR, tabx, vary, varx,nbperm);             
             
            XGsim[i][j]= resF;
            for (k=1;k<=dimx;k++){
                XDsim[(nvQ[i])][(nvR[j])+k-1]=varx[k]; /*on remplit D avec les valeurs observes*/
                DNperm[(nvQ[i])][(nvR[j])+k-1]=DNperm[(nvQ[i])][(nvR[j])+k-1]+nbperm[k];
            }
            vecalloc(&indica,lL);
            for (k=1;k<=dimx;k++){
                for (l=1;l<=lL;l++){
                    indica[l]=tabx[l][k];                    
                    }
                XD2sim[(nvQ[i])][(nvR[j])+k-1]=calculcorr(XLpermute,indica,vary); /*on remplit D avec les valeurs observes*/
                
            }
            
            
            freevec(indica);           
            freetab(tabx);
            freevec(vary);
            freevec(varx);
            freetab(LtR);
            freeintvec(nbperm);
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
            vecintalloc (&nbperm, dimy);
            resF=calculF(XLpermute, taby, varx, vary,nbperm);             
             
            XGsim[i][j]= resF;
            for (k=1;k<=dimy;k++){
                XDsim[(nvQ[i])+k-1][(nvR[j])]=vary[k]; /*on remplit D avec les valeurs observes*/
                DNperm[(nvQ[i])+k-1][(nvR[j])]=DNperm[(nvQ[i])+k-1][(nvR[j])]+nbperm[k];
            }
            vecalloc(&indica,cL);
            for (k=1;k<=dimy;k++){
                for (l=1;l<=cL;l++){
                    indica[l]=taby[l][k];                    
                    }
                XD2sim[(nvQ[i])+k-1][(nvR[j])]=calculcorr(XLpermute,varx,indica); /*on remplit D avec les valeurs observes*/
                
            }
            
            
            freevec(indica);         
            
            freetab(taby);
            freevec(vary);
            freevec(varx);
            freeintvec(nbperm);
        } 

        /* Comparaisons observes/simules pour statistique globale*/
        if (GMin[i][j]>XGsim[i][j]) GMin[i][j]=XGsim[i][j];
        if (GMax[i][j]<XGsim[i][j]) GMax[i][j]=XGsim[i][j];
        GMoy[i][j]=GMoy[i][j]+XGsim[i][j];
        if (XGsim[i][j]<XG[i][j]) GNLT[i][j]=GNLT[i][j]+1;
        if (XGsim[i][j]==XG[i][j]) GNEQ[i][j]=GNEQ[i][j]+1;

        /* Comparaisons observes/simules pour statistique D*/

        /* quantitatif/quantitatif */
        if ((typQ[i]==1)&(typR[j]==1)) {
            if (DMin[(nvQ[i])][(nvR[j])]>XDsim[(nvQ[i])][(nvR[j])]) DMin[(nvQ[i])][(nvR[j])]=XDsim[(nvQ[i])][(nvR[j])];
            if (DMax[(nvQ[i])][(nvR[j])]<XDsim[(nvQ[i])][(nvR[j])]) DMax[(nvQ[i])][(nvR[j])]=XDsim[(nvQ[i])][(nvR[j])];
            DMoy[(nvQ[i])][(nvR[j])]=DMoy[(nvQ[i])][(nvR[j])]+XDsim[(nvQ[i])][(nvR[j])];
            if (XDsim[(nvQ[i])][(nvR[j])]<XD[(nvQ[i])][(nvR[j])]) DNLT[(nvQ[i])][(nvR[j])]=DNLT[(nvQ[i])][(nvR[j])]+1;
            if (XDsim[(nvQ[i])][(nvR[j])]==XD[(nvQ[i])][(nvR[j])]) DNEQ[(nvQ[i])][(nvR[j])]=DNEQ[(nvQ[i])][(nvR[j])]+1;
            }

        /* qualitatif/qualitatif */
        if ((typQ[i]==2)&(typR[j]==2)) {
            if (G2Min[i][j]>XG2sim[i][j]) G2Min[i][j]=XG2sim[i][j];
            if (G2Max[i][j]<XG2sim[i][j]) G2Max[i][j]=XG2sim[i][j];
            G2Moy[i][j]=G2Moy[i][j]+XG2sim[i][j];
            if (XG2sim[i][j]<XG2[i][j]) G2NLT[i][j]=G2NLT[i][j]+1;
            if (XG2sim[i][j]==XG[i][j]) G2NEQ[i][j]=G2NEQ[i][j]+1;
            
            for (k=1;k<=dimx;k++){
                for (l=1;l<=dimy;l++){
                    if (DMin[(nvQ[i])+l-1][(nvR[j])+k-1]>XDsim[(nvQ[i])+l-1][(nvR[j])+k-1]) DMin[(nvQ[i])+l-1][(nvR[j])+k-1]=XDsim[(nvQ[i])+l-1][(nvR[j])+k-1];
                    if (DMax[(nvQ[i])+l-1][(nvR[j])+k-1]<XDsim[(nvQ[i])+l-1][(nvR[j])+k-1]) DMax[(nvQ[i])+l-1][(nvR[j])+k-1]=XDsim[(nvQ[i])+l-1][(nvR[j])+k-1];
                    DMoy[(nvQ[i])+l-1][(nvR[j])+k-1]=DMoy[(nvQ[i])+l-1][(nvR[j])+k-1]+XDsim[(nvQ[i])+l-1][(nvR[j])+k-1];
                    if (XDsim[(nvQ[i])+l-1][(nvR[j])+k-1]<XD[(nvQ[i])+l-1][(nvR[j])+k-1]) DNLT[(nvQ[i])+l-1][(nvR[j])+k-1]=DNLT[(nvQ[i])+l-1][(nvR[j])+k-1]+1;
                    if (XDsim[(nvQ[i])+l-1][(nvR[j])+k-1]==XD[(nvQ[i])+l-1][(nvR[j])+k-1]) DNEQ[(nvQ[i])+l-1][(nvR[j])+k-1]=DNEQ[(nvQ[i])+l-1][(nvR[j])+k-1]+1;
                    }
                }
            }
        
        /*  Q quantitatif et R qualitatif */   
        /*--------------------------------*/
        if ((typQ[i]==1)&(typR[j]==2)) {
            for (k=1;k<=dimx;k++){
                if(XDsim[(nvQ[i])][(nvR[j])+k-1]>(-1)){
                    if (DMin[(nvQ[i])][(nvR[j])+k-1]>XDsim[(nvQ[i])][(nvR[j])+k-1]) DMin[(nvQ[i])][(nvR[j])+k-1]=XDsim[(nvQ[i])][(nvR[j])+k-1];
                    if (DMax[(nvQ[i])][(nvR[j])+k-1]<XDsim[(nvQ[i])][(nvR[j])+k-1]) DMax[(nvQ[i])][(nvR[j])+k-1]=XDsim[(nvQ[i])][(nvR[j])+k-1];
                    DMoy[(nvQ[i])][(nvR[j])+k-1]=DMoy[(nvQ[i])][(nvR[j])+k-1]+XDsim[(nvQ[i])][(nvR[j])+k-1];
                    if (XDsim[(nvQ[i])][(nvR[j])+k-1]<XD[(nvQ[i])][(nvR[j])+k-1]) DNLT[(nvQ[i])][(nvR[j])+k-1]=DNLT[(nvQ[i])][(nvR[j])+k-1]+1;
                    if (XDsim[(nvQ[i])][(nvR[j])+k-1]==XD[(nvQ[i])][(nvR[j])+k-1]) DNEQ[(nvQ[i])][(nvR[j])+k-1]=DNEQ[(nvQ[i])][(nvR[j])+k-1]+1;
                }    
                if (D2Min[(nvQ[i])][(nvR[j])+k-1]>XD2sim[(nvQ[i])][(nvR[j])+k-1]) D2Min[(nvQ[i])][(nvR[j])+k-1]=XD2sim[(nvQ[i])][(nvR[j])+k-1];
                if (D2Max[(nvQ[i])][(nvR[j])+k-1]<XD2sim[(nvQ[i])][(nvR[j])+k-1]) D2Max[(nvQ[i])][(nvR[j])+k-1]=XD2sim[(nvQ[i])][(nvR[j])+k-1];
                D2Moy[(nvQ[i])][(nvR[j])+k-1]=D2Moy[(nvQ[i])][(nvR[j])+k-1]+XD2sim[(nvQ[i])][(nvR[j])+k-1];
                if (XD2sim[(nvQ[i])][(nvR[j])+k-1]<XD2[(nvQ[i])][(nvR[j])+k-1]) D2NLT[(nvQ[i])][(nvR[j])+k-1]=D2NLT[(nvQ[i])][(nvR[j])+k-1]+1;
                if (XD2sim[(nvQ[i])][(nvR[j])+k-1]==XD2[(nvQ[i])][(nvR[j])+k-1]) D2NEQ[(nvQ[i])][(nvR[j])+k-1]=D2NEQ[(nvQ[i])][(nvR[j])+k-1]+1;
                
            }
         }   
        /*  R quantitatif et Q qualitatif */   
        /*--------------------------------*/
        if ((typQ[i]==2)&(typR[j]==1)) {
            for (l=1;l<=dimy;l++){
                    if(XDsim[(nvQ[i])+l-1][(nvR[j])]>(-1)) {/* elimination des cas non valides nb ind <1*/
                    if (DMin[(nvQ[i])+l-1][(nvR[j])]>XDsim[(nvQ[i])+l-1][(nvR[j])]) DMin[(nvQ[i])+l-1][(nvR[j])]=XDsim[(nvQ[i])+l-1][(nvR[j])];
                    if (DMax[(nvQ[i])+l-1][(nvR[j])]<XDsim[(nvQ[i])+l-1][(nvR[j])]) DMax[(nvQ[i])+l-1][(nvR[j])]=XDsim[(nvQ[i])+l-1][(nvR[j])];
                    DMoy[(nvQ[i])+l-1][(nvR[j])]=DMoy[(nvQ[i])+l-1][(nvR[j])]+XDsim[(nvQ[i])+l-1][(nvR[j])];
                    if (XDsim[(nvQ[i])+l-1][(nvR[j])]<XD[(nvQ[i])+l-1][(nvR[j])]) DNLT[(nvQ[i])+l-1][(nvR[j])]=DNLT[(nvQ[i])+l-1][(nvR[j])]+1;
                    if (XDsim[(nvQ[i])+l-1][(nvR[j])]==XD[(nvQ[i])+l-1][(nvR[j])]) DNEQ[(nvQ[i])+l-1][(nvR[j])]=DNEQ[(nvQ[i])+l-1][(nvR[j])]+1;
                }
                if (D2Min[(nvQ[i])+l-1][(nvR[j])]>XD2sim[(nvQ[i])+l-1][(nvR[j])]) D2Min[(nvQ[i])+l-1][(nvR[j])]=XD2sim[(nvQ[i])+l-1][(nvR[j])];
                if (D2Max[(nvQ[i])+l-1][(nvR[j])]<XD2sim[(nvQ[i])+l-1][(nvR[j])]) D2Max[(nvQ[i])+l-1][(nvR[j])]=XD2sim[(nvQ[i])+l-1][(nvR[j])];
                D2Moy[(nvQ[i])+l-1][(nvR[j])]=D2Moy[(nvQ[i])+l-1][(nvR[j])]+XD2sim[(nvQ[i])+l-1][(nvR[j])];
                if (XD2sim[(nvQ[i])+l-1][(nvR[j])]<XD2[(nvQ[i])+l-1][(nvR[j])]) D2NLT[(nvQ[i])+l-1][(nvR[j])]=D2NLT[(nvQ[i])+l-1][(nvR[j])]+1;
                if (XD2sim[(nvQ[i])+l-1][(nvR[j])]==XD2[(nvQ[i])+l-1][(nvR[j])]) D2NEQ[(nvQ[i])+l-1][(nvR[j])]=D2NEQ[(nvQ[i])+l-1][(nvR[j])]+1;
            }
        }
    } /* fin boucle sur les colonnes*/

} /* fin boucle sur les lignes*/

} /* fin boucle permutation . npermut incremente*/


/* calcul des probas pour D*/
for (i=1; i<=cQ; i++) {
    for (j=1; j<=cR; j++) {
        if ((typQ[assignQ[i]]==1)&(typR[assignR[j]]==1)) {
            DMoy[i][j]=DMoy[i][j]/(double)(*nrepet+1);
            D2Moy[i][j]=D2Moy[i][j]/(double)(*nrepet+1);
                
            /* test unilateral en fonction du signe de r */
            if (XD[i][j]<0) DProb[i][j]=(double)(DNLT[i][j]+DNEQ[i][j])/(double)(*nrepet+1);
            else DProb[i][j]=1-(double)(DNLT[i][j]/(double)(*nrepet+1));
            }
        if ((typQ[assignQ[i]]==2)&(typR[assignR[j]]==2)) {
            DMoy[i][j]=DMoy[i][j]/(double)(*nrepet+1);
            D2Moy[i][j]=D2Moy[i][j]/(double)(*nrepet+1);    
            /* test unilateral en fonction de la de moyenne sur simulations */
            if (XD[i][j]<DMoy[i][j]) DProb[i][j]=(double)(DNLT[i][j]+DNEQ[i][j])/(double)(*nrepet+1);
            else DProb[i][j]=1-(double)(DNLT[i][j]/(double)(*nrepet+1));
            }
        if ((typQ[assignQ[i]]==2)&(typR[assignR[j]]==1)) {
            DMoy[i][j]=DMoy[i][j]/(double)(DNperm[i][j]);
            D2Moy[i][j]=D2Moy[i][j]/(double)(*nrepet+1);    
            /* test unilateral a gauche */
            DProb[i][j]=(double)(DNLT[i][j]+DNEQ[i][j])/(double)(DNperm[i][j]);
            if (XD2[i][j]<0) D2Prob[i][j]=(double)(D2NLT[i][j]+D2NEQ[i][j])/(double)(*nrepet+1);
            else D2Prob[i][j]=1-(double)(D2NLT[i][j]/(double)(*nrepet+1));
            
            }
        if ((typQ[assignQ[i]]==1)&(typR[assignR[j]]==2)) {
            DMoy[i][j]=DMoy[i][j]/(double)(DNperm[i][j]);
            D2Moy[i][j]=D2Moy[i][j]/(double)(*nrepet+1);    
            /* test unilateral a gauche */
            DProb[i][j]=(double)(DNLT[i][j]+DNEQ[i][j])/(double)(DNperm[i][j]);
            if (XD2[i][j]<0) D2Prob[i][j]=(double)(D2NLT[i][j]+D2NEQ[i][j])/(double)(*nrepet+1);
            else D2Prob[i][j]=1-(double)(D2NLT[i][j]/(double)(*nrepet+1));
            }

        }
    }

/* calcul des probas pour G statistique globale*/
for (i=1; i<=vQ; i++) 
    {
    for (j=1; j<=vR; j++) 
    {
        GMoy[i][j]=GMoy[i][j]/(*nrepet+1);
        G2Moy[i][j]=G2Moy[i][j]/(*nrepet+1);

        if ((typQ[i]==1)&(typR[j]==1)) {
            /* test unilateral en fonction du signe de r */
            if (XG[i][j]<0) GProb[i][j]=(double)(GNLT[i][j]+GNEQ[i][j])/(double)(*nrepet+1);
            else GProb[i][j]=1-(double)(GNLT[i][j]/(double)(*nrepet+1));
            }
        else {
            GProb[i][j]=1-((double)(GNLT[i][j])/(double)(*nrepet+1));
            G2Prob[i][j]=1-((double)(G2NLT[i][j])/(double)(*nrepet+1));
            }
        }
    }
    
/* On renvoie les valeurs dans R*/
    
    k = 0;
    for (i=1; i<=cQ; i++) 
    {
        for (j=1; j<=cR; j++) 
        {
            tabD[k]= XD[i][j]; /* D observe */
            tabDmoy[k]= DMoy[i][j];/* Dmoy */ 
            tabDmin[k]= DMin[i][j];/* Dmin */
            tabDmax[k]= DMax[i][j];/* Dmax */
            tabDNLT[k]= DNLT[i][j];/* DNLT */
            tabDNEQ[k]= DNEQ[i][j];/* DNEQ */
            tabDProb[k]= DProb[i][j];/* DProb */
            tabDNperm[k]= DNperm[i][j];
            tabD2[k]= XD2[i][j]; /* D observe */
            tabD2moy[k]= D2Moy[i][j];/* Dmoy */ 
            tabD2min[k]= D2Min[i][j];/* Dmin */
            tabD2max[k]= D2Max[i][j];/* Dmax */
            tabD2NLT[k]= D2NLT[i][j];/* DNLT */
            tabD2NEQ[k]= D2NEQ[i][j];/* DNEQ */
            tabD2Prob[k]= D2Prob[i][j];/* DProb */

            k = k + 1;
        }
    }

    k = 0;
    for (i=1; i<=vQ; i++) 
    {
        for (j=1; j<=vR; j++) 
        {
            tabG[k]= XG[i][j]; /* G observe */
            tabGmoy[k]= GMoy[i][j];/* Gmoy */ 
            tabGmin[k]= GMin[i][j];/* Gmin */
            tabGmax[k]= GMax[i][j];/* Gmax */
            tabGNLT[k]= GNLT[i][j];/* GNLT */
            tabGNEQ[k]= GNEQ[i][j];/* GNEQ */
            tabGProb[k]= GProb[i][j];/* GProb */
            tabG2[k]= XG2[i][j]; /* G observe */
            tabG2moy[k]= G2Moy[i][j];/* Gmoy */ 
            tabG2min[k]= G2Min[i][j];/* Gmin */
            tabG2max[k]= G2Max[i][j];/* Gmax */
            tabG2NLT[k]= G2NLT[i][j];/* GNLT */
            tabG2NEQ[k]= G2NEQ[i][j];/* GNEQ */
            tabG2Prob[k]= G2Prob[i][j];/* GProb */

            k = k + 1;
        }
    }


freetab(XR);
freetab(XL);
freetab(XQ);
freetab(XLpermute);

freetab(XD);
freetab(XG);
freetab(DMin);
freetab(DMax);
freetab(DMoy);
freeinttab(DNLT);
freeinttab(DNEQ);
freeinttab(DNperm);
freetab(DProb);
freetab(XDsim);
freetab(GMin);
freetab(GMax);
freetab(GMoy);
freeinttab(GNLT);
freeinttab(GNEQ);
freetab(GProb);
freetab(XGsim);
freeintvec (nvR);
freeintvec (nvQ);
freeintvec (typR);
freeintvec (typQ);
freeintvec (assignR);
freeintvec (assignQ);

freetab(XD2);
freetab(XG2);
freetab(D2Min);
freetab(D2Max);
freetab(D2Moy);
freeinttab(D2NLT);
freeinttab(D2NEQ);

freetab(D2Prob);
freetab(XD2sim);
freetab(G2Min);
freetab(G2Max);
freetab(G2Moy);
freeinttab(G2NLT);
freeinttab(G2NEQ);
freetab(G2Prob);
freetab(XG2sim);


}


/*=============================================================*/
/*=============================================================*/

void quatriemecoin2 (double *tabR, double *tabL, 
                       double *tabQ , int *ncolR, int *nvarR, int *nlL,
                       int *ncL, int *ncolQ, int *nvarQ,int *nrepet, int *modeltype,
                       double *tabG, double *tabGProb,
                       double *tabGmoy, double *tabGmin, double *tabGmax, int *tabGNLT, 
                       int *tabGNEQ,                      
                       int *RtypR,int *RtypQ, int *RassignR, int *RassignQ, double *trRLQ)
                       
{
/* Calcul quatrieme coin de type rlq (r2, rapport de correlation ou chi2/n */
/* couplage quantitative/quantitative OU qualitative/quantitative OU qualitative/qualitative */


/* tabG resutlats globaux (Chi2/n pour quali/quali) observes */
/* Gmoy moyenne sur les repetitions */
/* Gmin minimum sur les repetitions */
/* Gmax maximum sur les repetitions */
/* GNLT nombre de repetitions avec D inferieures a observe*/
/* GNEQ nombre de repetitions avec D egales a observe */
/* GProb probabilites      */
/* typR et typQ vecteur avec le type de chaque variable (1=quant, 2=qual) longueur nvarR et nvarQ */
/* assignR et assignQ vecteur avec le numero de variable pour chaque colonne de R et Q longueur ncolR et ncolQ */

/* le tableau est transpose par rapport a l'article original mais
on garde la typologie des modeles par rapport a espece/site et non ligne colonne
Par exemple,
model 1 permute dans les espece independament (lignes dans l'article original), donc dans chaque colonne ici... */

/* Declarations de variables C locales */
double  **XR,**XL,**XQ,**LtR;
double  **XLpermute,**contingxy,trRLQsim;
double  **GMin,**GMax,**GMoy,**GProb,**XGsim, *varx, *vary, **XG, **XG2,
        **tabx,**taby,resF=0, *reschi2G, *indica;
int i,j,k,l,lL,cL,cQ,cR,vR,vQ, *nvR, *nvQ, *assignR, *assignQ, *typR, *typQ,dimx=0,dimy=0,npermut;
int **GNLT,**GNEQ,**DNLT,**DNEQ,**DNperm, **G2NLT,**G2NEQ,**D2NLT,**D2NEQ,*nbperm;

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




taballoc (&XG, vQ, vR);   /* observe */
taballoc (&GMin, vQ, vR); /* minimum des permutations */
taballoc (&GMax, vQ, vR); /* maximum des permutations */
taballoc (&GMoy, vQ, vR); /* moyenne des permutations */
tabintalloc (&GNLT, vQ, vR); /* nbre de permutations inferieur a l'obs*/
tabintalloc (&GNEQ, vQ, vR); /* nbre de permutations egal a l'obs*/
taballoc (&GProb, vQ, vR); /* probabilite associe */
taballoc (&XGsim, vQ, vR); /* valeur pour une permutation donnee*/


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
            
            XG[i][j]=pow(calculcorr(XL,varx,vary),2);
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

            XG[i][j]= calculkhi2surn(contingxy);;
            
                        
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
          
            /* Calcul de D et du pseudo F */
            vecintalloc (&nbperm, dimx); /* va contenir valeur indiquant si permutation valide ou non */                
             
            XG[i][j]= calculcorratio(LtR, tabx, vary,nbperm); 
            
            
 
            freetab(tabx);
            freevec(vary);
            freeintvec(nbperm);
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
          
            vecintalloc (&nbperm, dimy); 
         
            XG[i][j]= calculcorratio(XL, taby, varx,nbperm); 
                   
            freetab(taby);
            
            freevec(varx);
            freeintvec(nbperm);
        } 



trRLQ[0]=trRLQ[0]+XG[i][j];

} /* fin boucle sur les colonnes*/

} /* fin boucle sur les lignes*/


/* on remplit les differents elements pour les permutations */

/* Initialisation pour G */

for (i=1; i<=vQ; i++) 
    {
    for (j=1; j<=vR; j++) 
    {
        GMin[i][j]=XG[i][j];
        GMax[i][j]=XG[i][j];
        GMoy[i][j]=XG[i][j];
        GNEQ[i][j]=GNEQ[i][j]+1;
        }
    }
trRLQ[1]=trRLQ[0]; /*min*/
trRLQ[2]=0; /*max*/
trRLQ[3]=trRLQ[0]; /*moy*/
trRLQ[4]=trRLQ[4]+1; /*NEQ*/

/*----------------------------------------*/    
/*----------------------------------------*/
/* ----       DEBUT PERMUTATIONS      ----*/
/*----------------------------------------*/
/*----------------------------------------*/


for (npermut=1; npermut<=*nrepet;npermut++) /* Boucle permutation*/
    {
	trRLQsim=0;
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
            
            XGsim[i][j]=pow(calculcorr(XLpermute,varx,vary),2);
           
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
            
            XGsim[i][j]=calculkhi2surn(contingxy); /*calcul du chi/n*/
           
            
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
           
            vecintalloc (&nbperm, dimx);
           
            XGsim[i][j]= calculcorratio(LtR, tabx, vary,nbperm); 
             
            freetab(tabx);
            freevec(vary);
           
            freetab(LtR);
            freeintvec(nbperm);
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
          
            vecintalloc (&nbperm, dimy);
            
            XGsim[i][j]= calculcorratio(XLpermute, taby, varx, nbperm);   
                
            
            freetab(taby);
            freevec(varx);
            freeintvec(nbperm);
        } 

        /* Comparaisons observes/simules pour statistique globale*/
        if (GMin[i][j]>XGsim[i][j]) GMin[i][j]=XGsim[i][j];
        if (GMax[i][j]<XGsim[i][j]) GMax[i][j]=XGsim[i][j];
        GMoy[i][j]=GMoy[i][j]+XGsim[i][j];
        if (XGsim[i][j]<XG[i][j]) GNLT[i][j]=GNLT[i][j]+1;
        if (XGsim[i][j]==XG[i][j]) GNEQ[i][j]=GNEQ[i][j]+1;

  trRLQsim=trRLQsim+XGsim[i][j];
           
        
    } /* fin boucle sur les colonnes*/

} /* fin boucle sur les lignes*/
	if(trRLQ[1]>trRLQsim) trRLQ[1]=trRLQsim; /*min*/
	if(trRLQ[2]<trRLQsim) trRLQ[2]=trRLQsim; /*max*/
	trRLQ[3]=trRLQ[3]+trRLQsim; /*moy*/
	if(trRLQ[0]==trRLQsim) trRLQ[4]=trRLQ[4]+1; /*NEQ*/
	if(trRLQ[0]>trRLQsim) trRLQ[5]=trRLQ[5]+1; /*GNLT*/
} /* fin boucle permutation . npermut incremente*/

trRLQ[3]=trRLQ[3]/(*nrepet+1);
trRLQ[6]=1-((double)(trRLQ[5])/(double)(*nrepet+1)); /* Prob  */

/* calcul des probas pour G statistique globale*/
for (i=1; i<=vQ; i++) 
    {
    for (j=1; j<=vR; j++) 
    {
        GMoy[i][j]=GMoy[i][j]/(*nrepet+1);
        
	GProb[i][j]=1-((double)(GNLT[i][j])/(double)(*nrepet+1));
        }
    }
    
/* On renvoie les valeurs dans R*/
    


    k = 0;
    for (i=1; i<=vQ; i++) 
    {
        for (j=1; j<=vR; j++) 
        {
            tabG[k]= XG[i][j]; /* G observe */
            tabGmoy[k]= GMoy[i][j];/* Gmoy */ 
            tabGmin[k]= GMin[i][j];/* Gmin */
            tabGmax[k]= GMax[i][j];/* Gmax */
            tabGNLT[k]= GNLT[i][j];/* GNLT */
            tabGNEQ[k]= GNEQ[i][j];/* GNEQ */
            tabGProb[k]= GProb[i][j];/* GProb */
           
            k = k + 1;
        }
    }


freetab(XR);
freetab(XL);
freetab(XQ);
freetab(XLpermute);


freetab(XG);

freetab(GMin);
freetab(GMax);
freetab(GMoy);
freeinttab(GNLT);
freeinttab(GNEQ);
freetab(GProb);
freetab(XGsim);
freeintvec (nvR);
freeintvec (nvQ);
freeintvec (typR);
freeintvec (typQ);
freeintvec (assignR);
freeintvec (assignQ);


}


/*=============================================================*/
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
void vecstandar (double *tab, double *poili, int n)
/*--------------------------------------------------
* tab est un vecteur                                
* poili est un vecteur n composantes avec somme par ligne
* la procedure retourne tab norme par colonne 
* pour la ponderation poili variance en n 
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


/*=========================================================================*/
double calculcorratio(double **XL, double **XQual, double *XQuant, int *nbind){             

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
            nbind[i]=1; /* on compte la permutation */
        }
                
    }
                
       
    if (kk==1)
        {F=0;}
    else
        {F=((ScTotal-ScIntra)/(ScTotal));}
    
    freevec(SY);
    freevec(SY2);
    freevec(compt);
    freeintvec(classvec);
    return(F);
}


/*=============================================================*/


/*=========================================================================*/
double calculF(double **XL, double **XQual, double *XQuant, double *D, int *nbind){             

/*      Fonction qui prend une variable quantitative (n) et une 
qualitative (p) et une table de contingence L (n p) qui calcul la
 valeur de D et la valeur d'un pseudo F (var inter/var intra)    */


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
            nbind[i]=1; /* on compte la permutation */
        }
        else { D[i]=-1;}
                
    }
                
       
    if (kk==1)
        {F=0;}
    else
        {F=((ScTotal-ScIntra)/(double)(kk-1))/(ScIntra/(double)(tot-kk));}
    
    freevec(SY);
    freevec(SY2);
    freevec(compt);
    freeintvec(classvec);
    return(F);
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




