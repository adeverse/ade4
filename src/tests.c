#include <math.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include "adesub.h"

double betweenvar (double **tab, double *pl, double *indica);
double inerbetween (double *pl, double *pc, int moda, double *indica, double **tab);
void testdiscrimin(int *npermut,double *rank,double *pl1,int *npl,int *moda1,double *indica1,int *nindica,double *tab1, int *il1, int *ic1,double *inersim);
void testertrace (int *npermut,double *pc1r, int *npc1,double *pc2r, int *npc2,double *tab1r, int *l1r, int *c1r,double *tab2r, int *l1r1, int *c2r,double *inersimul);
void testertracenu (int *npermut,double *pc1r, int *npc1,double *pc2r, int *npc2,double *plr, int *npl,double *tab1r, int *l1r, int *c1r,double *tab2r, int *l1r1, int *c2r,double *tabinit1r,double *tabinit2r,int *typ1r,int *typ2r,double *inersimul);
void testertracenubis ( int *npermut,double *pc1r, int *npc1,double *pc2r, int *npc2,double *plr, int *npl,double *tab1r, int *l1r, int *c1r,double *tab2r, int *l1r1, int *c2r,double *tabinit1r,double *tabinit2r,int *typ1r,int *typ2r,int *ntabr,double *inersimul);
void testinter( int *npermut,double *pl1,int *npl,double *pc1,int *npc,int *moda1,double *indica1,int *nindica,double *tab1, int *l1, int *c1,double *inersim);
void testmantel(int *npermut1,int *lig1,double *init11,double *init21,double *inersim);
void testprocuste(int *npermut1,int *lig1,int *c11,int *c21,double *init11,double *init21,double *inersim);
void testmultispati (int *npermut, int *lig1, int *col1, double *tab, double *mat, double *lw, double *cw, double *inersim) ;
void testdistRV(int *npermut1,int *lig1,double *init11,double *init21,double *RV);
void MSTgraph (double *distances, int *nlig, int *ngmax, double *voisi);

/**************************/
void MSTgraph (double *distances, int *nlig, int *ngmax, double *voisi)
{
    int N, NITP, KP, i, k, j, lig;
    double **DM, **voisiloc, *UI, CST, D, UK;
    double a0;
    int **MST, *JI, *NIT, IMST, NI, numg, numgmax;
    double borne = 1.0e20;
    
    lig = N = *nlig;
    numgmax=*ngmax;
    
    taballoc (&DM, N, N);
    taballoc (&voisiloc, N, N);
    tabintalloc (&MST, 2, N);
    vecalloc (&UI, N);
    vecintalloc (&JI, N);
    vecintalloc (&NIT, N);
    
    k = 0;
    for (i=1; i<=lig; i++) {
        for (j=1; j<=lig; j++) {
            DM[i][j] = distances[k];
            k = k + 1;
        }
    }
    for (i=1; i<=N; i++) DM[i][i] = borne;
    
    for (numg=1; numg<=numgmax; numg++) {       
        /* Algorithm 422, Kevin & Whitney Comm. ACM 15, 273, 1972 */
        CST = 0.;
        NITP = N -1;
        KP = N;
        IMST = 0;
        for (i=1; i<=NITP; i++) {
            NIT[i] = i;
            UI[i] = DM [i][KP];
            JI[i] = KP;
        }
        while (NITP > 0) {
            for (i=1; i<=NITP; i++) {
                NI = NIT[i];
                D = DM[NI][KP];
                if (UI[i]>D) {
                    UI[i] = D;
                    JI[i] = KP;
                }
            }
            UK = UI[1];
            for (i=1; i<=NITP; i++) {
                if (UI[i]<=UK) {
                    UK = UI[i];
                    k = i;
                }
            }
            IMST = IMST + 1;
            MST[1][IMST] = NIT[k];
            MST[2][IMST] = JI[k];
            CST = CST + UK;
            KP = NIT[k];
        
            UI[k]=UI[NITP];
            NIT[k] = NIT[NITP];
            JI[k]=JI[NITP];
            NITP = NITP - 1;
        }
        for (i=1; i<=IMST; i++) {
            voisiloc [MST[1][i]] [MST[2][i]] = numg;
            voisiloc [MST[2][i]] [MST[1][i]] = numg;            
            DM [MST[1][i]] [MST[2][i]] = borne;
            DM [MST[2][i]] [MST[1][i]] = borne;         
        }
    }
    for (i=1; i<=lig; i++) {
        for (j=1; j<=lig; j++) {
            a0 = voisiloc [i][j];
            if ( (a0>0) &&  (a0<=numgmax) ){
                voisiloc [i][j] = 1;
            } else voisiloc [i][j] = 0;
        }
    }

    k = 0;
    for (i=1; i<=lig; i++) {
        for (j=1; j<=lig; j++) {
            voisi[k]=voisiloc[i][j];
            k = k + 1;
        }
    }

    freetab (DM);
    freetab (voisiloc);
    freeinttab (MST);
    freevec (UI);
    freeintvec (JI);
    freeintvec (NIT);
}

/*********************************************/
void testdistRV(int *npermut1,int *lig1,double *init11,double *init21,double *RV)
{
/* Declarations de variables C locales */

    int         i, j, k, lig, i0, j0, npermut, *numero, isel;
    double      **m1, **m2, *pl;
    double      trace, trace0, car1, car2, a0;

/* Allocation memoire pour les variables C locales */

    npermut = *npermut1;
    lig = *lig1;

    taballoc(&m1, lig, lig);
    taballoc(&m2, lig, lig);
    vecintalloc (&numero, lig);
    vecalloc (&pl, lig);

/* On recopie les objets R dans les variables C locales */

    k = 0;
    for (i=1; i<=lig; i++) {
        for (j=1; j<=lig; j++) {
            m1[i][j] = init11[k];
            k = k + 1;
        }
    }

    k = 0;
    for (i=1; i<=lig; i++) {
        for (j=1; j<=lig; j++) {
            m2[i][j] = init21[k];
            k = k + 1;
        }
    }

/* m1 et m2 sont des matrices de distances simples */
    initvec(pl, 1.0/(double)lig);
    dtodelta (m1, pl);
    dtodelta (m2,pl);           
    car1 = 0;
    trace=0;
    car2 = 0;
    for (i=1; i<=lig; i++) {
        for (j=1; j<=lig; j++) {
            car1 = car1 + m1[i][j]*m1[i][j];
            trace = trace + m1[i][j]*m2[i][j];
            car2 = car2 + m2[i][j]*m2[i][j];
        }
    }
    car1 = sqrt ( (double) car1);
    car2 = sqrt ( (double) car2);
    a0 = trace/car1/car2;
    if (a0<-1) a0 = -1;
    if (a0>1) a0 = 1;
    RV[0] = a0;
    for (isel=1; isel<=npermut; isel++) {
        getpermutation (numero, isel);
        trace0=0;
        for (i=1; i<=lig; i++) {
            i0 = numero[i];
            for (j=1; j<=lig; j++) {
                j0 = numero[j];
                trace0 = trace0 + m1[i][j]*m2[i0][j0];
            }
        }
        a0 = trace0/car1/car2;
        if (a0<-1) a0 = -1;
        if (a0>1) a0 = 1;
        RV[isel] = a0;
    }
    freevec(pl);
    freeintvec(numero); 
    freetab (m1);
    freetab (m2);
}

/*********************************************/
/*  On commence par une première version ou l'on importe la liste listw sous forme matricielle. 
    On pourrait suivre la logique de Bivand qui est plus judicieuse, surtout quand les matrices
    L on beaucoup de 0. Il travaille avec des listes et calcul le produit L%*%X par la fonction
    lagw.c. */

void testmultispati (int *npermut, int *lig1, int *col1, double *tab, double *mat, double *lw, double *cw, double *inersim) 
{
/* Declarations de variables C locales */
    
    int         i, j, k, lig, col, nper, *numero;
    double      **X, **L, **Xperm;
    double      *d, *q, *dperm;
    
/* Allocation memoire pour les variables C locales */
    
    nper = *npermut;
    lig = *lig1;
    col= *col1;
    
    

    taballoc(&X, lig, col);
    taballoc(&L, lig, lig);
    taballoc(&Xperm, lig, col);
    vecintalloc (&numero, lig);
    vecalloc(&dperm, lig);
    vecalloc(&d, lig);
    vecalloc(&q, col);
    
/* On recopie les objets R dans les variables C locales */

    k = 0;
    for (j=1; j<=col; j++) {
        for (i=1; i<=lig; i++) {
            X[i][j] = tab[k];
            k = k + 1;
        }
    }

    k = 0;
    for (i=1; i<=lig; i++) {
        for (j=1; j<=lig; j++) {
            L[j][i] = mat[k];
            k = k + 1;
        }
    }

    k=0;
    for (i=1; i<=lig; i++) {
        d[i]=lw[k];
        k = k + 1;
    }
    
    k=0;
    for (i=1; i<=col; i++) {
        q[i]=cw[k];
        k = k + 1;
    }
    
/* On calcul la valeur observée */
    inersim[0]=traceXtdLXq(X, L, d, q);
    
/* On calcul les valeurs pour chaque simulation */

    for (j=1; j<=nper; j++) {
        getpermutation(numero, j);
        matpermut(X, numero ,Xperm);
        vecpermut(d, numero, dperm);
        inersim[j]=traceXtdLXq(Xperm, L, dperm, q);
    }
    
    
/* Libération des réservations locales */
    
freetab(X);
freetab(L);
freetab(Xperm);
freeintvec(numero);
freevec(dperm);
freevec(d);
freevec(q);
}

/*********************************************/
void testmantel(int *npermut1,
                int *lig1,
                double *init11,
                double *init21,
                
                double *inersim)
{
/* Declarations de variables C locales */

    int         i, j, k, lig, i0, j0, npermut, *numero, isel;
    double      **m1, **m2;
    double      trace, trace0, moy1, moy2, car1, car2, a0;

/* Allocation memoire pour les variables C locales */

    npermut = *npermut1;
    lig = *lig1;

    taballoc(&m1, lig, lig);
    taballoc(&m2, lig, lig);
    vecintalloc (&numero, lig);

/* On recopie les objets R dans les variables C locales */

    k = 0;
    for (i=1; i<=lig; i++) {
        for (j=1; j<=lig; j++) {
            m1[i][j] = init11[k];
            k = k + 1;
        }
    }

    k = 0;
    for (i=1; i<=lig; i++) {
        for (j=1; j<=lig; j++) {
            m2[i][j] = init21[k];
            k = k + 1;
        }
    }

    trace=0;
    moy1 = 0; moy2=0; car1 = 0; car2 = 0;
    for (i=1; i<=lig; i++) {
        for (j=1; j<=lig; j++) {
            trace = trace + m1[i][j]*m2[i][j];
            if (j>i) {
                moy1 = moy1 + m1[i][j];
                moy2 = moy2 + m2[i][j];
                car1 = car1 + m1[i][j]*m1[i][j];
                car2 = car2 + m2[i][j]*m2[i][j];
            }
        }
    }
    trace = trace/2;
    a0 = trace - moy1*moy2*2/lig/(lig-1);
    a0 = a0/ sqrt ( (double) (car1 - moy1*moy1*2/lig/(lig-1)) );
    a0 = a0/ sqrt ( (double) (car2 - moy2*moy2*2/lig/(lig-1)) );
    trace = a0;
    
    inersim[0] = a0;

    for (isel=1; isel<=npermut; isel++) {
        getpermutation (numero, isel);
        trace0=0;
        for (i=1; i<=lig; i++) {
            i0 = numero[i];
            for (j=1; j<=lig; j++) {
                j0 = numero[j];
                trace0 = trace0 + m1[i][j]*m2[i0][j0];
            }
        }
        trace0 = trace0/2;
        a0 = trace0 - moy1*moy2*2/lig/(lig-1);
        a0 = a0/ sqrt ( (double) (car1 - moy1*moy1*2/lig/(lig-1)) );
        a0 = a0/ sqrt ( (double) (car2 - moy2*moy2*2/lig/(lig-1)) );
        inersim[isel] = a0;
    }

    freetab(m1);
    freetab(m2);
    freeintvec(numero); 
}

/*********************************************/
void testprocuste(  int *npermut1,
                int *lig1,
                int *c11,
                int *c21,
                double *init11,
                double *init21,
                
                double *inersim)
{
/* Declarations de variables C locales */

    int         i, j, k, res, lig, c1, c2, npermut, rang, *numero;
    double      **tabperm, **init1, **init2, tinit, tsim;
    double      **cov, **w, *valpro, *tvecsim;

/* Allocation memoire pour les variables C locales */

    npermut = *npermut1;
    lig = *lig1;
    c1 = *c11;
    c2 = *c21;

/*
    if (c1<=c2) {
        taballoc(&tabperm, lig, c1);
        taballoc(&init1, lig, c1);
        taballoc(&init2, lig, c2);
    } else {
        taballoc(&tabperm, lig, c2);
        taballoc(&init1, lig, c2);
        taballoc(&init2, lig, c1);

        res=c1;
        c1=c2;
        c2=res;
    }
*/   
    taballoc(&tabperm, lig, c1);
    taballoc(&init1, lig, c1);
    taballoc(&init2, lig, c2);

    taballoc(&cov, c1, c2);
    taballoc(&w, c1, c1);
    vecalloc(&valpro,c1);
    vecintalloc (&numero, lig);
    vecalloc(&tvecsim, npermut);

/* On recopie les objets R dans les variables C locales */

    k = 0;
    for (i=1; i<=lig; i++) {
        for (j=1; j<=c1; j++) {
            init1[i][j] = init11[k];
            k = k + 1;
        }
    }

    k = 0;
    for (i=1; i<=lig; i++) {
        for (j=1; j<=c2; j++) {
            init2[i][j] = init21[k];
            k = k + 1;
        }
    }

/* Calculs */

    tinit = 0;
    prodmatAtBC (init1, init2, cov);
    prodmatAAtB (cov,w);
    DiagobgComp(c1, w, valpro, &rang);
    for (i=1;i<=rang;i++) {
        tinit=tinit+sqrt(valpro[i]);
    }
    
    for (k=1; k<=npermut; k++) {
    
        getpermutation (numero,k);
        matpermut (init1, numero, tabperm);
        
        prodmatAtBC (tabperm, init2, cov);
        prodmatAAtB (cov,w);
        DiagobgComp(c1, w, valpro, &rang);
        tsim=0;
        for (i=1;i<=rang;i++) {
            tsim=tsim+sqrt(valpro[i]);
        }
        tvecsim[k] = tsim;
    }

    inersim[0] = tinit;

    for (k=1; k<=npermut; k++) {
        inersim[k] = tvecsim[k];
    }   
    
    freetab(tabperm);
    freetab(cov);
    freetab(init1);
    freetab(init2);
    freetab(w);
    freevec(tvecsim);
    freevec(valpro);
    freeintvec(numero);
}

/*********************************************/
void testdiscrimin( int *npermut,
                double *rank,
                double *pl1,
                int *npl,
                int *moda1,
                double *indica1,
                int *nindica,
                double *tab1, int *il1, int *ic1,
                double *inersim)
{
/* Declarations de variables C locales */

    int         l1, c1;
    
    double  **tab, **tabp, *pl, *plp, *indica, rang;
    int     moda, i, j, k, *numero;

/* Allocation memoire pour les variables C locales */

    l1 = *il1;
    c1 = *ic1;
    moda = *moda1;
    rang = *rank;

    vecalloc (&pl, *npl);
    vecalloc (&plp, *npl);
    vecalloc (&indica, *nindica);
    taballoc (&tab, l1, c1);
    taballoc (&tabp, l1, c1);
    vecintalloc(&numero, l1);

/* On recopie les objets R dans les variables C locales */

    k = 0;
    for (i=1; i<=l1; i++) {
        for (j=1; j<=c1; j++) {
            tab[i][j] = tab1[k];
            k = k + 1;
        }
    }
    for (i=1; i<=*npl; i++) {
        pl[i] = pl1[i-1];
    }
    for (i=1; i<=*nindica; i++) {
        indica[i] = indica1[i-1];
    }

/* Calculs
    inertie initiale est stockee dans le premier element du vecteur
    des simulations */

    inersim[0] = betweenvar(tab, pl, indica)/rang;

    for (k=1; k<=*npermut; k++) {
        getpermutation (numero, k);
        matpermut (tab, numero, tabp);
        vecpermut (pl, numero, plp);
        inersim[k] = betweenvar (tabp, plp, indica)/rang;
    }

    freevec (pl);
    freevec (plp);
    freevec (indica);
    freetab (tab);
    freetab (tabp);
    freeintvec (numero);
}

/*********************************************/
double betweenvar (double **tab, double *pl, double *indica)
{
    double  *m, s, bvar, *indicaw;
    int     i, j, l1, c1, ncla, icla;
    
    l1 = tab[0][0];
    c1 = tab[1][0];

    ncla = indica[1];
    for (i=1;i<=l1;i++) {
        if (indica[i] > ncla) ncla = indica[i];
    }
    
    vecalloc(&m, ncla);
    vecalloc(&indicaw, ncla);
    
    bvar = 0;
    for (j=1;j<=c1;j++) {

        for (i=1;i<=ncla;i++) {
            m[i] = 0;
            indicaw[i] = 0;
        }

        for (i=1;i<=l1;i++) {
            icla = indica[i];
            indicaw[icla] = indicaw[icla] + pl[i];
            m[icla] = m[icla] + tab[i][j] * pl[i];
        }
        
        s = 0;
        for (i=1;i<=ncla;i++) {
            s = s + m[i] * m[i] / indicaw[i];
        }
        
        bvar = bvar + s;
    }
    
    freevec(m);
    freevec(indicaw);

    return (bvar);
}

/************************************/
void testinter( int *npermut,
                double *pl1,
                int *npl,
                double *pc1,
                int *npc,
                int *moda1,
                double *indica1,
                int *nindica,
                double *tab1, int *l1, int *c1,
                double *inersim)
{
/* Declarations de variables C locales */

    double  **tab, **tabp, *pl, *plp, *pc, *indica;
    int     moda, i, j, k;
    int     *numero;
    
/* Allocation memoire pour les variables C locales */

    moda = *moda1;
    vecalloc (&pl, *npl);
    vecalloc (&plp, *npl);
    vecalloc (&pc, *npc);
    vecalloc (&indica, *nindica);
    taballoc (&tab, *l1, *c1);
    taballoc (&tabp, *l1, *c1);
    vecintalloc(&numero, *l1);

/* On recopie les objets R dans les variables C locales */

    k = 0;
    for (i=1; i<=*l1; i++) {
        for (j=1; j<=*c1; j++) {
            tab[i][j] = tab1[k];
            k = k + 1;
        }
    }
    for (i=1; i<=*npl; i++) {
        pl[i] = pl1[i-1];
    }
    for (i=1; i<=*npc; i++) {
        pc[i] = pc1[i-1];
    }
    for (i=1; i<=*nindica; i++) {
        indica[i] = indica1[i-1];
    }

/* Calculs
    inertie initiale est stockee dans le premier element du vecteur
    des simulations */
    
    inersim[0] = inerbetween (pl, pc, moda, indica, tab);

    for (k=1; k<=*npermut; k++) {
        getpermutation (numero,k);
        matpermut (tab, numero, tabp);
        vecpermut (pl, numero, plp);
        inersim[k] = inerbetween (plp, pc, moda, indica, tabp);
    }

    freetab(tab);
    freetab(tabp);
    freevec(pl);
    freevec(plp);
    freevec(pc);
    freevec(indica);
    freeintvec(numero);
}

/************************************/
double inerbetween (double *pl, double *pc, int moda, double *indica, double **tab)
{
    int i, j, k, l1, rang;
    double poi,  inerb, a0, a1, s1;
    double **moy;
    double *pcla;
    
    l1 = tab[0][0];
    rang = tab[1][0];
    taballoc (&moy, moda, rang);
    vecalloc (&pcla, moda);
    
    for (i=1;i<=l1;i++) { 
        k = (int) indica[i];
        poi = pl[i];
        pcla[k]=pcla[k]+poi;
    }

    
    for (i=1;i<=l1;i++) {
        k = (int) indica[i];
        poi = pl[i];
        for (j=1;j<=rang;j++) {
            moy[k][j] = moy[k][j] + tab[i][j]*poi;
        }
    }
    
    for (k=1;k<=moda;k++) { 
        a0 = pcla[k];
        for (j=1;j<=rang;j++) {
            moy[k][j] = moy[k][j]/a0;
        }
    }

    inerb = 0;
    for (i=1;i<=moda;i++) {
        a1 = pcla[i];
        for (j=1;j<=rang;j++) {
            s1 = moy[i][j];
            inerb = inerb + s1 * s1 *a1 * pc[j];
        }
    }
    freetab (moy);
    freevec (pcla);
    return inerb;
    
}

/*****************/
void testertrace (  int *npermut,
                double *pc1r, int *npc1,
                double *pc2r, int *npc2,
                double *tab1r, int *l1r, int *c1r,
                double *tab2r, int *l1r1, int *c2r,
                double *inersimul)
{

/* Declarations des variables C locales */

    double  **X1, **X2, *pc1, *pc2, **cov;
    int     i, j, k, l1, c1, c2;
    double  poi, inertot, s1, inersim;
    int     *numero;
    
/* On recopie les objets R dans les variables C locales */

    l1 = *l1r;
    c1 = *c1r;
    c2 = *c2r;
        
/* Allocation memoire pour les variables C locales */

    vecalloc (&pc1, *npc1);
    vecalloc (&pc2, *npc2);
    vecintalloc(&numero, l1);
    taballoc (&X1, l1, c1);
    taballoc (&X2, l1, c2);
    taballoc(&cov, c2, c1);

/* On recopie les objets R dans les variables C locales */

    k = 0;
    for (i=1; i<=l1; i++) {
        for (j=1; j<=c1; j++) {
            X1[i][j] = tab1r[k];
            k = k + 1;
        }
    }
    k = 0;
    for (i=1; i<=l1; i++) {
        for (j=1; j<=c2; j++) {
            X2[i][j] = tab2r[k];
            k = k + 1;
        }
    }
    for (i=1; i<=*npc1; i++) {
        pc1[i] = pc1r[i-1];
    }
    for (i=1; i<=*npc2; i++) {
        pc2[i] = pc2r[i-1];
    }

/* Calculs */

    for (j=1;j<=c1;j++) {
        poi = sqrt(pc1[j]);
        for (i=1; i<=l1;i++) {
            X1[i][j]=X1[i][j]*poi;
        }
    }
    for (j=1;j<=c2;j++) {
        poi = sqrt(pc2[j]);
        for (i=1; i<=l1;i++) {
            X2[i][j]=X2[i][j]*poi;
        }
    }
    
    prodmatAtBC (X2, X1, cov);
    
    inertot = 0;
    for (i=1;i<=c2;i++) {
        for (j=1;j<=c1;j++) {
            s1 = cov[i][j];
            inertot = inertot + s1 * s1;
        }
    }
    inertot = inertot / l1 / l1;
    inersimul[0] = inertot;
    
    for (k=1; k<=*npermut; k++) {
        getpermutation (numero,k);
        prodmatAtBrandomC (X2, X1, cov, numero);

        inersim = 0;
        for (i=1;i<=c2;i++) {
            for (j=1;j<=c1;j++) {
                s1 = cov[i][j];
                inersim = inersim + s1 * s1;
            }
        }
        inersimul[k] = inersim / l1 / l1;
    }
    
    freevec (pc1);
    freevec (pc2);
    freeintvec (numero);
    freetab (X1);
    freetab (X2);
    freetab (cov);
}

/*****************/
void testertracenu (    int *npermut,
                double *pc1r, int *npc1,
                double *pc2r, int *npc2,
                double *plr, int *npl,
                double *tab1r, int *l1r, int *c1r,
                double *tab2r, int *l1r1, int *c2r,
                double *tabinit1r,
                double *tabinit2r,
                int *typ1r,
                int *typ2r,
                double *inersimul)
{
/* Declarations des variables C locales */

    double  **X1, **X2, **init1, **init2, *pc1, *pc2, *pl, **cov;
    int     i, j, k, l1, c1, c2;
    double  poi, inertot, s1, inersim, a1;
    int     *numero1, *numero2;
    char    typ1[3], typ2[3];
    
/* On recopie les objets R dans les variables C locales */

    l1 = *l1r;
    c1 = *c1r;
    c2 = *c2r;
    strncpy(typ1, (char const *) *typ1r, 2);
    strncpy(typ2, (char const *) *typ2r, 2);
    typ1[2] = 0;
    typ2[2] = 0;

/* Allocation memoire pour les variables C locales */

    vecalloc (&pc1, *npc1);
    vecalloc (&pc2, *npc2);
    vecalloc (&pl, l1);
    vecintalloc (&numero1, l1);
    vecintalloc (&numero2, l1);
    taballoc (&X1, l1, c1);
    taballoc (&X2, l1, c2);
    taballoc (&init1, l1, c1);
    taballoc (&init2, l1, c2);
    taballoc (&cov, c2, c1);

/* On recopie les objets R dans les variables C locales */

    k = 0;
    for (i=1; i<=l1; i++) {
        for (j=1; j<=c1; j++) {
            init1[i][j] = tab1r[k];
            k = k + 1;
        }
    }
    k = 0;
    for (i=1; i<=l1; i++) {
        for (j=1; j<=c2; j++) {
            init2[i][j] = tab2r[k];
            k = k + 1;
        }
    }
    for (i=1; i<=*npc1; i++) {
        pc1[i] = pc1r[i-1];
    }
    for (i=1; i<=*npc2; i++) {
        pc2[i] = pc2r[i-1];
    }
    for (i=1; i<=*npl; i++) {
        pl[i] = plr[i-1];
    }
    
/* Calculs */

    inertot = 0;
    for (i=1; i<=l1;i++) {
        poi = pl[i];
        for (j=1;j<=c1;j++) {
            init1[i][j]=init1[i][j]*poi;
        }
    }

    prodmatAtBC (init2, init1, cov);
    
    for (i=1;i<=c2;i++) {
        a1 = pc2[i];
        for (j=1;j<=c1;j++) {
            s1 = cov[i][j];
            inertot = inertot + s1 * s1 * a1 * pc1[j];
        }
    }

    inersimul[0] = inertot;

    k = 0;
    for (i=1; i<=l1; i++) {
        for (j=1; j<=c1; j++) {
            init1[i][j] = tabinit1r[k];
            k = k + 1;
        }
    }
    k = 0;
    for (i=1; i<=l1; i++) {
        for (j=1; j<=c2; j++) {
            init2[i][j] = tabinit2r[k];
            k = k + 1;
        }
    }
    
    for (k=1; k<=*npermut; k++) {
    
        getpermutation (numero1,k);
        getpermutation (numero2,2*k);
        
        matpermut (init1, numero1, X1);
        matpermut (init2, numero2, X2);
	
/* calcul de poids colonnes dans le cas d'une acm*/
	
	if (strcmp (typ1,"cm") == 0) {
		for(j=1;j<=c1;j++){
			pc1[j]=0;
			}
    		for(i=1;i<=l1;j++){
			for(j=1;j<=c1;i++){
				pc1[j]=pc1[j]+X1[i][j]*pl[i];
			}
		}

	}

	if (strcmp (typ2,"cm") == 0) {
		for(j=1;j<=c2;j++){
			pc2[j]=0;
			}
    		for(i=1;i<=l1;i++){
			for(j=1;j<=c2;j++){
				pc2[j]=pc2[j]+X2[i][j]*pl[i];
			}
		}

	
	}	        
        matcentrage (X1, pl, typ1);
        matcentrage (X2, pl, typ2);

        for (i=1; i<=l1;i++) {
            poi = pl[i];
            for (j=1;j<=c1;j++) {
                X1[i][j]=X1[i][j]*poi;
            }
        }

        prodmatAtBC (X2, X1, cov);

        inersim = 0;
        for (i=1;i<=c2;i++) {
            a1 = pc2[i];
            for (j=1;j<=c1;j++) {
                s1 = cov[i][j];
                inersim = inersim + s1 * s1 * a1 * pc1[j];
            }
        }
        inersimul[k] = inersim;
    }
    freevec (pc1);
    freevec (pc2);
    freevec (pl);
    freeintvec (numero1);
    freeintvec (numero2);
    freetab (X1);
    freetab (X2);
    freetab (init1);
    freetab (init2);
    freetab (cov);
}


/*****************/
void testertracenubis ( int *npermut,
                double *pc1r, int *npc1,
                double *pc2r, int *npc2,
                double *plr, int *npl,
                double *tab1r, int *l1r, int *c1r,
                double *tab2r, int *l1r1, int *c2r,
                double *tabinit1r,
                double *tabinit2r,
                int *typ1r,
                int *typ2r,
                int *ntabr,
                double *inersimul)

{
/* Declarations des variables C locales */

    double  **X1, **X2, **init1, **init2, *pc1, *pc2, *pl, **cov;
    int     i, j, k, l1, c1, c2;
    double  poi, inertot, s1, inersim, a1;
    int     *numero1, *numero2, ntab;
    char    typ1[3], typ2[3];

/* On recopie les objets R dans les variables C locales */

    l1 = *l1r;
    c1 = *c1r;
    c2 = *c2r;
    ntab = *ntabr;
    strncpy(typ1, (char const *) *typ1r, 2);
    strncpy(typ2, (char const *) *typ2r, 2);
    typ1[2] = 0;
    typ2[2] = 0;
            
/* Allocation memoire pour les variables C locales */

    vecalloc (&pc1, *npc1);
    vecalloc (&pc2, *npc2);
    vecalloc (&pl, l1);
    vecintalloc (&numero1, l1);
    vecintalloc (&numero2, l1);
    taballoc (&X1, l1, c1);
    taballoc (&X2, l1, c2);
    taballoc (&init1, l1, c1);
    taballoc (&init2, l1, c2);
    taballoc (&cov, c2, c1);

/* On recopie les objets R dans les variables C locales */

    k = 0;
    for (i=1; i<=l1; i++) {
        for (j=1; j<=c1; j++) {
            init1[i][j] = tab1r[k];
            k = k + 1;
        }
    }
    k = 0;
    for (i=1; i<=l1; i++) {
        for (j=1; j<=c2; j++) {
            init2[i][j] = tab2r[k];
            k = k + 1;
        }
    }
    for (i=1; i<=*npc1; i++) {
        pc1[i] = pc1r[i-1];
    }
    for (i=1; i<=*npc2; i++) {
        pc2[i] = pc2r[i-1];
    }
    for (i=1; i<=*npl; i++) {
        pl[i] = plr[i-1];
    }
    
    inertot = 0;
    for (i=1; i<=l1;i++) {
        poi = pl[i];
        for (j=1;j<=c1;j++) {
            init1[i][j]=init1[i][j]*poi;
        }
    }

    prodmatAtBC (init2, init1, cov);
    
    for (i=1;i<=c2;i++) {
        a1 = pc2[i];
        for (j=1;j<=c1;j++) {
            s1 = cov[i][j];
            inertot = inertot + s1 * s1 * a1 * pc1[j];
        }
    }
    
    inersimul[0] = inertot;

    k = 0;
    for (i=1; i<=l1; i++) {
        for (j=1; j<=c1; j++) {
            X1[i][j] = tab1r[k];
            k = k + 1;
        }
    }
    for (i=1; i<=l1;i++) {
        poi = pl[i];
        for (j=1;j<=c1;j++) {
            X1[i][j]=X1[i][j]*poi;
        }
    }
    
    k = 0;
    for (i=1; i<=l1; i++) {
        for (j=1; j<=c2; j++) {
            X2[i][j] = tab2r[k];
            k = k + 1;
        }
    }
    for (i=1; i<=l1;i++) {
        poi = pl[i];
        for (j=1;j<=c2;j++) {
            X2[i][j]=X2[i][j]*poi;
        }
    }
    
    if (ntab == 1) {
        k = 0;
        for (i=1; i<=l1; i++) {
            for (j=1; j<=c2; j++) {
                init2[i][j] = tabinit2r[k];
                k = k + 1;
            }
        }
    } else {
        k = 0;
        for (i=1; i<=l1; i++) {
            for (j=1; j<=c1; j++) {
                init1[i][j] = tabinit1r[k];
                k = k + 1;
            }
        }
    }

    for (k=1; k<=*npermut; k++) {
    
        if (ntab == 1) {
            getpermutation (numero2,k);
            matpermut (init2, numero2, X2);
	    /* poids colonne recalculé si acm*/
	    if (strcmp (typ2,"cm") == 0) {
		for(j=1;j<=c2;j++){
			pc2[j]=0;
			}
    		for(i=1;i<=l1;i++){
			for(j=1;j<=c2;j++){
				pc2[j]=pc2[j]+X2[i][j]*pl[i];
			}
		}

	    }
	 		        
            matcentrage (X2, pl, typ2);
        } else {
            getpermutation (numero1,k);
            matpermut (init1, numero1, X1);
	    /* poids colonne recalculé si acm*/
	    if (strcmp (typ1,"cm") == 0) {
		for(j=1;j<=c1;j++){
			pc1[j]=0;
			}
    		for(i=1;i<=l1;i++){
			for(j=1;j<=c1;j++){
				pc1[j]=pc1[j]+X1[i][j]*pl[i];
			}
		}
	
	    }	    
	    matcentrage (X1, pl, typ1);
        }
        
        prodmatAtBC (X2, X1, cov);

        inersim = 0;
        for (i=1;i<=c2;i++) {
            a1 = pc2[i];
            for (j=1;j<=c1;j++) {
                s1 = cov[i][j];
                inersim = inersim + s1 * s1 * a1 * pc1[j];
            }
        }
        inersimul[k] = inersim;
    }
    freevec (pc1);
    freevec (pc2);
    freevec (pl);
    freeintvec (numero1);
    freeintvec (numero2);
    freetab (X1);
    freetab (X2);
    freetab (init1);
    freetab (init2);
    freetab (cov);
}
