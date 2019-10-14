"suprowpta" <- function(ptaX, dfY, facY, scaling = c("partial", "total")) {
  if (!inherits(ptaX, "pta"))
    stop("Object of class 'pta' expected")
  if(!inherits(dfY, "data.frame"))
    stop("Object of class 'data.frame' expected")
  if(!is.factor(facY))
    stop("factor expected")
  lig <- nrow(dfY)
  if(length(facY) != lig)
    stop("Non convenient dimension")
  appel <- as.list(ptaX$call)
  kta2 <- eval.parent(appel$X)
  appel.kta2 <- as.list(kta2$call)
  kta1 <- eval.parent(appel.kta2$x)
  appel.kta1 <- as.list(kta1$call)
  wit1 <- eval.parent(appel.kta1$dudiwit)
  appel.wit1 <- as.list(wit1$call)
  dfX <- eval.parent(appel.wit1$df)
  facX <- eval.parent(appel.wit1$fac)
  dfXw <- scalewt(dfX, center = TRUE, scale = TRUE)
  mean.dfXw <- attr(dfXw, "scaled:center")
  var.dfXw <- attr(dfXw, "scaled:scale")
  dfYmean <- sweep(dfY, 2, mean.dfXw, "-")
  dfYw <- sweep(dfYmean, 2, var.dfXw, "/")
  scaling <- match.arg(scaling)
  if (scaling == "total") {
    dfXw <- scalewt(dfXw, center = FALSE, scale = TRUE)
    dfXw2 <- data.frame()
    for (i in levels(facX)) {
      w <- dfXw[facX == i, ]
      w <- scalewt(w, center = TRUE, scale = FALSE)
      dfXw2 <- rbind(dfXw2, w)
      mean.w <- attr(w, "scaled:center")
      dfYw[facY == i, ] <- sweep(dfYw[facY == i, ], 2, mean.w, "-")
    }
    dfXw2 <- scalewt(dfXw2, center = FALSE, scale = TRUE)
    var.dfXw2 <- attr(dfXw2, "scaled:scale")
    dfYw <- sweep(dfYw, 2, var.dfXw2, "/")
  }
  if (scaling == "partial") {
    for (i in levels(facX)) {
      w <- dfXw[facX == i, ]
      w <- scalewt(w, center = TRUE, scale = TRUE)
      mean.w <- attr(w, "scaled:center")
      var.w <- attr(w, "scaled:scale")
      dfYw[facY == i, ] <- sweep(dfYw[facY == i, ], 2, mean.w, "-")
      dfYw[facY == i, ] <- sweep(dfYw[facY == i, ], 2, var.w, "/")
    }
  }
  coosup <- as.matrix(dfYw) %*% (as.matrix(ptaX$c1) * ptaX$cw)
  return(list(tabsup = dfYw, lisup = coosup))
}