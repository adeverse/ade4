"niche" <- function (dudiX, Y, scannf = TRUE, nf = 2) {
    if (!inherits(dudiX, "dudi")) 
        stop("Object of class dudi expected")
    lig1 <- nrow(dudiX$tab)
    if (!is.data.frame(Y)) 
        stop("Y is not a data.frame")
    lig2 <- nrow(Y)
    if (lig1 != lig2) 
        stop("Non equal row numbers")
    w1 <- apply(Y, 2, sum)
    if (any(w1 <= 0)) 
        stop(paste("Column sum <=0 in Y"))
    Y <- sweep(Y, 2, w1, "/")
    w1 <- w1/sum(w1)
    tabcoiner <- t(as.matrix(Y)) %*% (as.matrix(dudiX$tab))
    tabcoiner <- data.frame(tabcoiner)
    names(tabcoiner) <- names(dudiX$tab)
    row.names(tabcoiner) <- names(Y)
    if (nf > dudiX$nf) 
        nf <- dudiX$nf
    nic <- as.dudi(tabcoiner, dudiX$cw, w1, scannf = scannf, 
        nf = nf, call = match.call(), type = "niche")
    U <- as.matrix(nic$c1) * unlist(nic$cw)
    U <- data.frame(as.matrix(dudiX$tab) %*% U)
    row.names(U) <- row.names(dudiX$tab)
    names(U) <- names(nic$c1)
    nic$ls <- U
    U <- as.matrix(nic$c1) * unlist(nic$cw)
    U <- data.frame(t(as.matrix(dudiX$c1)) %*% U)
    row.names(U) <- names(dudiX$li)
    names(U) <- names(nic$li)
    nic$as <- U
    return(nic)
}

"plot.niche" <- function (x, xax = 1, yax = 2, ...) {
    if (!inherits(x, "niche")) 
        stop("Use only with 'niche' objects")
    if (x$nf == 1) {
        warnings("One axis only : not yet implemented")
        return(invisible())
    }
    if (xax > x$nf) 
        stop("Non convenient xax")
    if (yax > x$nf) 
        stop("Non convenient yax")
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), 
        respect = TRUE)
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    s.corcircle(x$as, xax, yax, sub = "Axis", csub = 2, 
        clabel = 1.25)
    s.arrow(x$c1, xax, yax, sub = "Variables", csub = 2, 
        clabel = 1.25)
    scatterutil.eigen(x$eig, wsel = c(xax, yax))
    s.label(x$ls, xax, yax, clabel = 0, cpoint = 2, sub = "Samples and Species", 
        csub = 2)
    s.label(x$li, xax, yax, clabel = 1.5, add.plot = TRUE)
    s.label(x$ls, xax, yax, clabel = 1.25, sub = "Samples", 
        csub = 2)
    s.distri(x$ls, eval.parent(as.list(x$call)[[3]]), 
        cstar = 0, axesell = FALSE, cellipse = 1, sub = "Niches", csub = 2)
}

"print.niche" <- function (x, ...) {
    if (!inherits(x, "niche")) 
        stop("to be used with 'niche' object")
    cat("Niche analysis\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$rank (rank)     :", x$rank)
    cat("\n$nf (axis saved) :", x$nf)
    cat("\n$RV (RV coeff)   :", x$RV)
    cat("\n\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n\n")
    else cat("\n\n")
    sumry <- array("", c(3, 4), list(1:3, c("vector", "length", 
        "mode", "content")))
    sumry[1, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "row weigths (crossed array)")
    sumry[3, ] <- c("$cw", length(x$cw), mode(x$cw), "col weigths (crossed array)")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(7, 4), list(1:7, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "crossed array (averaging species/sites)")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "species coordinates")
    sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "species normed scores")
    sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), "variables coordinates")
    sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "variables normed scores")
    sumry[6, ] <- c("$ls", nrow(x$ls), ncol(x$ls), "sites coordinates")
    sumry[7, ] <- c("$as", nrow(x$as), ncol(x$as), "axis upon niche axis")
    
    print(sumry, quote = FALSE)
    cat("\n")
}

"niche.param" <- function(x) {
  if (!inherits(x, "niche"))
    stop("Object of class 'niche' expected")
  appel <- as.list(x$call)
  X <- eval.parent(appel[[2]])$tab
  Y <- eval.parent(appel[[3]])
  w1 <- apply(Y, 2, sum)
  if (any(w1 <= 0))
    stop(paste("Column sum <=0 in Y"))
  Y <- sweep(Y, 2, w1, "/")
  calcul.param <- function(freq,mil) {
    inertia <- sum(freq * mil * mil)
    m <- apply(freq * mil, 2, sum)
    margi <- sum(m^2)
    mil <- t(t(mil) - m)
    tolt <- sum(freq * mil * mil)
    u <- m/sqrt(sum(m^2))
    z <- mil %*% u
    tolm <- sum(freq * z * z)
    tolr <- tolt - tolm
    w <- c(inertia, margi, tolm, tolr)
    names(w) <- c("inertia", "OMI", "Tol", "Rtol")
    w1 <- round(w[2:4]/w[1], digits = 3) * 100
    names(w1) <- c("omi", "tol", "rtol")
    return(c(w, w1))
  }
  res <- apply(Y, 2, calcul.param,mil=X)
  t(res)
}


rtest.niche <- function(xtest,nrepet=99,...){
  if (!inherits(xtest, "dudi"))
    stop("Object of class dudi expected")
  if (!inherits(xtest, "niche"))
    stop("Type 'niche' expected")
  appel <- as.list(xtest$call)
  X <- eval.parent(appel$dudiX)$tab
  Y <- eval.parent(appel$Y)
  w1 <- apply(Y, 2, sum)
  if (any(w1 <= 0))
    stop(paste("Column sum <=0 in Y"))
  Y <- sweep(Y, 2, w1, "/")
  calcul.margi <- function(freq,mil) {
    m <- apply(freq * mil, 2, sum)
    return(sum(m^2))
  }
  obs <- apply(Y,2,calcul.margi,mil=X)
  ## we compute and test the average marginality for all species (OMI.mean)
  obs <- c(obs, OMI.mean = mean(obs))
  sim <- sapply(1:nrepet,function(x) apply(apply(Y,2,sample),2,calcul.margi,mil=X))
  sim <- rbind(sim, OMI.mean=apply(sim,2,mean))
  res <- as.krandtest(obs=obs,sim=t(sim))
  return(res)
}
