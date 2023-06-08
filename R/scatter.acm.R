"scatter.acm" <- function (x, xax = 1, yax = 2, mfrow=NULL, csub = 2, possub = "topleft", ...) {
    if (!inherits(x, "acm")) 
        stop("For 'acm' object")
    if (x$nf == 1) {
        score.acm(x, 1)
        return(invisible())
    }
    def.par <- graphics::par(no.readonly = TRUE)
    on.exit(graphics::par(def.par))
    oritab <- eval.parent(as.list(x$call)[[2]])
    nvar <- ncol(oritab)
    # modif samedi, juin 11, 2005 at 15:38 
    # message de Ivailo Stoyanov istoyanov@ecolab.bas.bg
    if (is.null(mfrow)) mfrow = grDevices::n2mfrow(nvar)
    old.par <- graphics::par(no.readonly = TRUE)
    on.exit(graphics::par(old.par))
    graphics::par(mfrow = mfrow)
    if (prod(mfrow)<nvar) graphics::par(ask=TRUE)
    # modif lundi, décembre 16, 2002 at 16:48 
    # suite à message d'Alain Guerreau  
    for (i in 1:(nvar)) s.class(x$li, oritab[, i], xax=xax, yax=yax, clabel = 1.5, 
        sub = names(oritab)[i], csub = csub, possub = possub, 
        cgrid = 0, cstar = 0, ...)
}
