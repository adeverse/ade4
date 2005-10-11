mstree <- function(xdist, ngmax=1) { 
    if(!inherits (xdist,"dist")) stop ("Object of class 'dist' expected")
    xdist <- as.matrix(xdist)
    nlig=nrow(xdist)
    xdist <- as.double(xdist)
    if (ngmax<=1) ngmax=1
    if (ngmax>=nlig) ngmax=1
    ngmax=as.integer(ngmax)
    voisi=as.double(matrix(0,nlig,nlig))
    #MSTgraph (double *distances, int *nlig, int *ngmax, double *voisi)
    mst = .C("MSTgraph", distances = xdist, nlig = nlig, ngmax = ngmax, voisi = voisi,PACKAGE="ade4")$voisi
    mst = matrix(mst, nlig, nlig)
    mst = neig (mat01=mst)
    return(mst)
}


