#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* .C calls */
extern void gearymoran(void *, void *, void *, void *, void *, void *, void *);
extern void MSTgraph(void *, void *, void *, void *);
extern void quatriemecoin(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void quatriemecoin2(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void quatriemecoinRLQ(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void testamova(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void testdimRVpca(void *, void *, void *, void *, void *, void *, void *, void *);
extern void testdiscrimin(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void testdistRV(void *, void *, void *, void *, void *);
extern void testertrace(void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void testertracenu(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void testertracenubis(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void testertracerlq(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void testinter(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void testmantel(void *, void *, void *, void *, void *);
extern void testmultispati(void *, void *, void *, void *, void *, void *, void *, void *);
extern void testprocuste(void *, void *, void *, void *, void *, void *, void *);
extern void VarianceDecompInOrthoBasis(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void _ade4_RVrandtestCpp(void *, void *, void *);
extern void _ade4_RVintrarandtestCpp(void *, void *, void *, void *);
extern void _ade4_procusterandtestCpp(void *, void *, void *);

static const R_CMethodDef CEntries[] = {
  {"gearymoran",                 (DL_FUNC) &gearymoran,                  7},
  {"MSTgraph",                   (DL_FUNC) &MSTgraph,                    4},
  {"quatriemecoin",              (DL_FUNC) &quatriemecoin,              18},
  {"quatriemecoin2",             (DL_FUNC) &quatriemecoin2,             17},
  {"quatriemecoinRLQ",           (DL_FUNC) &quatriemecoinRLQ,           30},
  {"testamova",                  (DL_FUNC) &testamova,                  15},
  {"testdimRVpca",               (DL_FUNC) &testdimRVpca,                8},
  {"testdiscrimin",              (DL_FUNC) &testdiscrimin,              10},
  {"testdistRV",                 (DL_FUNC) &testdistRV,                  5},
  {"testertrace",                (DL_FUNC) &testertrace,                 9},
  {"testertracenu",              (DL_FUNC) &testertracenu,              14},
  {"testertracenubis",           (DL_FUNC) &testertracenubis,           15},
  {"testertracerlq",             (DL_FUNC) &testertracerlq,             22},
  {"testinter",                  (DL_FUNC) &testinter,                  12},
  {"testmantel",                 (DL_FUNC) &testmantel,                  5},
  {"testmultispati",             (DL_FUNC) &testmultispati,              8},
  {"testprocuste",               (DL_FUNC) &testprocuste,                7},
  {"VarianceDecompInOrthoBasis", (DL_FUNC) &VarianceDecompInOrthoBasis, 12},
  {NULL, NULL, 0}
};

static const R_CallMethodDef CallEntries[] = {
    {"_ade4_procusterandtestCpp", (DL_FUNC) &_ade4_procusterandtestCpp, 3},
    {"_ade4_RVrandtestCpp", (DL_FUNC) &_ade4_RVrandtestCpp, 3},
    {"_ade4_RVintrarandtestCpp", (DL_FUNC) &_ade4_RVintrarandtestCpp, 4},
    {NULL, NULL, 0}
};

void R_init_ade4(DllInfo *dll)
{
  R_registerRoutines(dll, CEntries, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
