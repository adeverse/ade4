#include <R.h>
#include <stddef.h>
#include <math.h>
#include <time.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <Rmath.h>
#include <R_ext/RS.h>
#include <R_ext/Utils.h>
#include <R_ext/Linpack.h>
#include <R_ext/Lapack.h>
#include "adesub.h"


/*     Test of Dimensionality (Dray, CSDA, 2007) */

 
int svd(double **X, double **vecU, double **vecVt, double *vecD);
int svdd(double **X,double *vecD);
void recX(double **Xi, double **XU, double **XVt, double *D, int i);
void permutmodel1(double **X1,double **X1permute,int *ligL,int *colL);
double denum(double *vec, int i, int ncol);
void testdimRVpca (double *tabXR, int *nrow, int *ncol, int *nrepet, int *nbaxtest, double *sim1, double *obs1);






/*================================================================= */
void testdimRVpca (double *tabXR, int *nrow, int *ncol, int *nrepet, int *nbaxtest, double *sim1,  double *obs1) {
  /* RV */
  /* one test for each axis (RVDIM2) */
  double **X, **result1,  **XU, **XV, *D, **Xperm;
  double **Xi, **Riperm, **Ri, *Dperm;
  int nr,nc,nb,i,j,k,rankX, toto;
  nr = *nrow;
  nc = *ncol;
  nb = nc;
  if(nr<nb) nb=nr;
  taballoc (&X, nr, nc);
  taballoc (&Xperm, nr, nc);
  taballoc (&XU, nr, nb);
  taballoc (&XV, nc, nb);
  vecalloc (&D,nb);
  taballoc (&Xi, nr, nc);
  taballoc (&Riperm, nr, nc);
  taballoc (&Ri, nr, nc);
  vecalloc (&Dperm,nb);
  
  /* From R to C */    
  k = 0;
  for (i=1; i<=nr; i++) {
    for (j=1; j<=nc; j++) {
      X[i][j] = tabXR[k];
      Ri[i][j] = X[i][j];
      Xi[i][j] =0;
      k = k + 1;
    }
  }
  rankX=svd(X,XU,XV,D);
  if(*nbaxtest>rankX) nbaxtest[0]=rankX;
  taballoc (&result1, *nrepet, *nbaxtest);
  
  
  
  for(i=1;i<=*nbaxtest;i++) {
    recX(Xi,XU,XV,D,i);
    obs1[i-1]=pow(D[i],2)/denum(D,i,rankX); /*RV*/
    
    for(k=1;k<=*nrepet;k++){
      for(j=1;j<=nb;j++) Dperm[j]=0;
      permutmodel1(Ri,Riperm,&nr,&nc);
      toto=svdd(Riperm,Dperm);
      result1[k][i]=pow(Dperm[1],2)/denum(Dperm,1,toto);
      
    }
    for(j=1;j<=nr;j++){
      for(k=1;k<=nc;k++){
	Ri[j][k]=Ri[j][k]-Xi[j][k];
      }
    }
    
    
  }
  
  /* return values to  R */
  
  k = 0;
  for (i=1; i<=*nrepet; i++) 
    {
      for (j=1; j<=*nbaxtest; j++) 
        {
	  sim1[k]= result1[i][j]; 
	  k = k + 1;
        }
    }
  
  freetab(X);
  freetab(Xperm);
  freetab(XU);
  freetab(XV);
  freevec(D);
  freetab(result1);
  freetab(Xi);
  freetab(Riperm);
  freetab(Ri);
  freevec(Dperm);
    
  
}





/*================================================================= */

void permutmodel1(double **X1,double **X1permute,int *ligL,int *colL)
{

/* permute each column independently */
  
  /* Declaration des variables locales */
  double  *a;
  int i,j,k,ligL1,colL1;
  ligL1=*ligL;
  colL1=*colL;
  
  /* Allocation memoire pour les variables C locales */
  vecalloc(&a, ligL1);
  
  /* Permutation de la matrice */
  for(j=1;j<=colL1;j++)
    {
      for(i=1;i<=ligL1;i++)
        {
	  a[i]=X1[i][j];
	  
        }
      
      aleapermutvec (a);
      
      /* Construction de la matrice X1permute*/
      for(k=1;k<=ligL1;k++)
        {   
	  X1permute[k][j]=a[k];
	  
        }
      
    }
  
  freevec(a);
}

/*================================================================= */
/* renvoie ui*di*t(vi) dans Xi*/
void recX(double **Xi, double **XU, double **XV, double *D, int i){
    int k,j,nr,nc;
    nr=(int)Xi[0][0];
    nc=(int)Xi[1][0];
    for(k=1;k<=nr;k++){
        for(j=1;j<=nc;j++){
            Xi[k][j]=D[i]* XU[k][i]* XV[j][i];
        }
    }
}

/*================================================================= */
/*  svd d'une matrice , renvoie le rang de X, U, D et t(V) */
/*DGESVD( JOBU, JOBVT, M, N, A, LDA, S, U, LDU, VT, LDVT,
     $                   WORK, LWORK, INFO ) */
int svd(double **X, double **vecU, double **vecVt, double *vecD)
{
    int i,j, k,error,nr,nc,lwork,nbax,rankX,ldvt;
    char jobu='S',jobvt='A';
    double *A,*U, *D, *V;
    double work1,*work;
    
    nr=(int)X[0][0];
    nc=(int)X[1][0];
    nbax=nc;
    ldvt=nc;
    
    if (nr<nc) {
    	nbax=nr;
	jobu='A';
	jobvt='S';
	ldvt=nbax;
	
	
	}
	
    A = (double *)calloc((size_t)nr*nc, sizeof(double));/*doubleArray(size*size);*/
    D = (double *)calloc((size_t)nbax, sizeof(double));/*doubleArray(nbax*1);*/
    U = (double *)calloc((size_t)nr*nbax, sizeof(double));
    V = (double *)calloc((size_t)nbax*nc, sizeof(double));
    
    
    
  
    lwork=-1; 
    for (i = 0, j = 1; j <= nc; j++) {
    for (k = 1; k <= nr; k++) {
      A[i] = X[k][j];
      i++;
      }
    }
    F77_CALL(dgesvd)(&jobu, &jobvt,&nr, &nc,A, &nr, D,U,&nr,V,&ldvt,&work1, &lwork,&error);
  
    lwork=(int)floor(work1);
    if (work1-lwork>0.5) lwork++;
    work=(double *)calloc((size_t)lwork,sizeof(double));
    /* actual call */
    F77_NAME(dgesvd)(&jobu, &jobvt,&nr, &nc,A, &nr, D,U,&nr,V,&ldvt,work, &lwork,&error);
    free(work);
  
    if (error) {
        Rprintf("error in svd: %d\n", error);
        exit(-1);
        }
    i = 0;
    rankX=0;
    for ( j = 1; j <= nbax; j++) {
        for (k = 1; k <= nr; k++) {
            vecU[k][j] = U[i];
            i++;
            }
        vecD[j]=D[j-1];
	
        if (D[j-1]/D[0]>0.00000000001) rankX=rankX+1;
        }
    
    i = 0;
    for (k = 1; k <= nc; k++) {
         for ( j = 1; j <= nbax; j++){
            
	    vecVt[k][j] = V[i];
            i++;
        }
    }
        
    free(A);
    free(D);
    free(U);
    free(V);
    return(rankX);

}



/* ============================= */


/*================================================================= */
/*  svd d'une matrice , renvoie le rang de X et  D */
/*DGESVD( JOBU, JOBVT, M, N, A, LDA, S, U, LDU, VT, LDVT,
     $                   WORK, LWORK, INFO )
  renvoie seulement les valeurs singulieres, pas les vecteurs -> plus rapide */
int svdd(double **X, double *vecD)
{
    int i,j, k,error,nr,nc,lwork,nbax,rankX,ldvt;
    char jobu='N',jobvt='N';
    double *A,*U,*D,*V;
    double work1,*work;
    
    nr=(int)X[0][0];
    nc=(int)X[1][0];
    nbax=nc;
    ldvt=nc;
    if (nr<nc) {
      nbax=nr;
      ldvt=nbax;
      
    }
    
	
    A = (double *)calloc((size_t)nr*nc, sizeof(double));/*doubleArray(size*size);*/
    D = (double *)calloc((size_t)nbax, sizeof(double));/*doubleArray(nbax*1);*/
    /* double *U = (double *)calloc((size_t)nr*nbax, sizeof(double));
       double *V = (double *)calloc((size_t)nbax*nc, sizeof(double));*/
    U = (double *)calloc((size_t)nbax, sizeof(double));
    V = (double *)calloc((size_t)nbax, sizeof(double));
    
    
  
    lwork=-1; 
    for (i = 0, j = 1; j <= nc; j++) {
    for (k = 1; k <= nr; k++) {
      A[i] = X[k][j];
      i++;
      }
    }
    F77_CALL(dgesvd)(&jobu, &jobvt,&nr, &nc,A, &nr, D,U,&nr,V,&ldvt,&work1, &lwork,&error);
  
    lwork=(int)floor(work1);
    if (work1-lwork>0.5) lwork++;
    work=(double *)calloc((size_t)lwork,sizeof(double));
    /* actual call */
    F77_NAME(dgesvd)(&jobu, &jobvt,&nr, &nc,A, &nr, D,U,&nr,V,&ldvt,work, &lwork,&error);
    free(work);
  
    if (error) {
        Rprintf("error in svd: %d\n", error);
        exit(-1);
        }

    rankX=0;
    for ( j = 1; j <= nbax; j++) {
        vecD[j]=D[j-1];
	
        if (D[j-1]/D[0]>0.00000000001) rankX=rankX+1;
        }
    

    free(A);
    free(D);
    free(U);
    free(V);
    return(rankX);

}



/* ============================= */

double denum(double *vec, int i, int ncol){
	int j;
	double tot=0;
	for(j=i;j<=ncol;j++){
	tot=tot+pow(vec[j],4);
	}
	tot=sqrt(tot);
	return(tot);
}
