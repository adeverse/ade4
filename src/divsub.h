#include <math.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include "adesub.h"

void popweighting(int **b, int *som, double *res);
void popsum(int **b, int *res);
void newsamples(int **b, int *vstru, int **res);
void alphadiv(double **a, int **b, int *som, double *res);
void sums(double **a, int **b, int **c, int *som, double *sst, int *prindicstr, double *res);
int maxvecint (int *vec);
void means(double *psse, double *pdf, double *res);
void nvalues(int **b, int **c, int *som, double *pdf, int *prindicstr, double *res);
void repintvec(int *vecp, int *vecd, int *res);
void repdvecint(int *vecp, int nbd, int *res);
void sigmas(double *pms, double *pn, double *res);
void getinttable(int *vp, int *vd, int **res);
void unduplicint(int *vecp, int *res);
void vpintunduplicvdint(int *vecp, int *vecd, int *res);
void changeintlevels(int *vecp, int *res);
void getneworder(int *vecp, int *res);
void vecintpermut (int *A, int *num, int *B);
