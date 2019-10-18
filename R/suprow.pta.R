"suprow.pta" <- function(x, Xsup, facSup, ...) {
  if (!inherits(x, "pta"))
    stop("Object of class 'pta' expected")
  if(!inherits(Xsup, "data.frame"))
    stop("Object of class 'data.frame' expected")
  if(!is.factor(facSup))
    stop("factor expected")
  lig <- nrow(Xsup)
  if(length(facSup) != lig)
    stop("Non convenient dimension")
  appel <- as.list(x$call)
  kta2 <- eval.parent(appel$X)
  appel.kta2 <- as.list(kta2$call)
  kta1 <- eval.parent(appel.kta2$x)
  appel.kta1 <- as.list(kta1$call)
  wit1 <- eval.parent(appel.kta1$dudiwit)
  appel.wit1 <- as.list(wit1$call)
  ok <-  (appel.wit1[[1]] == "withinpca") && (appel.kta1[[1]] == "ktab.within") && (appel.kta2[[1]] == "t.ktab") && (appel[[1]] == "pta")
  if (!ok) 
    stop("Non convenient call sequence")
  dfX <- eval.parent(appel.wit1$df)
  facX <- eval.parent(appel.wit1$fac)
  dfXw <- scalewt(dfX, center = TRUE, scale = TRUE)
  mean.dfXw <- attr(dfXw, "scaled:center")
  var.dfXw <- attr(dfXw, "scaled:scale")
  Xsupmean <- sweep(Xsup, 2, mean.dfXw, "-")
  Xsupw <- sweep(Xsupmean, 2, var.dfXw, "/")
  scaling <- appel.wit1$scaling
  if (scaling == "total") {
    dfXw <- scalewt(dfXw, center = FALSE, scale = TRUE)
    dfXw2 <- data.frame()
    for (i in levels(facX)) {
      w <- dfXw[facX == i, ]
      w <- scalewt(w, center = TRUE, scale = FALSE)
      dfXw2 <- rbind(dfXw2, w)
      mean.w <- attr(w, "scaled:center")
      Xsupw[facSup == i, ] <- sweep(Xsupw[facSup == i, ], 2, mean.w, "-")
    }
    dfXw2 <- scalewt(dfXw2, center = FALSE, scale = TRUE)
    var.dfXw2 <- attr(dfXw2, "scaled:scale")
    Xsupw <- sweep(Xsupw, 2, var.dfXw2, "/")
  }
  if (scaling == "partial") {
    for (i in levels(facX)) {
      w <- dfXw[facX == i, ]
      w <- scalewt(w, center = TRUE, scale = TRUE)
      mean.w <- attr(w, "scaled:center")
      var.w <- attr(w, "scaled:scale")
      Xsupw[facSup == i, ] <- sweep(Xsupw[facSup == i, ], 2, mean.w, "-")
      Xsupw[facSup == i, ] <- sweep(Xsupw[facSup == i, ], 2, var.w, "/")
    }
  }
  coosup <- as.matrix(Xsupw) %*% (as.matrix(x$c1) * x$cw)
  return(list(tabsup = Xsupw, lisup = coosup))
}