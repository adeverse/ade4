varwt <- function(x, wt, na.rm = FALSE) {
  ## compute weighted biased (divided by n) variance
  if (na.rm) {
    wt <- wt[i <- !is.na(x)]
    x <- x[i]
  }
  sum.wt <- sum(wt)
  mean.wt <- sum(x * wt) / sum(wt)
  res <- sum(wt * (x - mean.wt)^2, na.rm = na.rm) / sum.wt
  return(res)
}


covwt <- function(x, wt, na.rm = FALSE) {
  ## compute weighted biased (divided by n) covariance matrix
  x <- as.matrix(x)
  if (na.rm) {
    x <- na.omit(x)
    wt <- wt[- attr(x,"na.action")]
  }
  wt <- wt / sum(wt)
  mean.x <- colSums(wt * x)
  x <- sqrt(wt) * sweep(x, 2, mean.x, FUN = "-", check.margin = FALSE)
  res <- crossprod(x) / sum(wt)
  return(res)
}

scalewt <- function (df, wt = rep(1/nrow(df), nrow(df)), center = TRUE, scale = TRUE) {
    df <- as.matrix(df)
    mean.df <- FALSE
    if(center){
        mean.df <- apply(df, 2, weighted.mean, w = wt)
        df <- sweep(df, 2, mean.df, "-") 
    }
    
    var.df <- FALSE
    if(scale){
        f <- function(x, w) sum(w * x^2) / sum(w)  
        var.df <- apply(df, 2, f, w = wt)
        temp <- var.df < 1e-14
        if (any(temp)) {
            warning("Variables with null variance not standardized.")
            var.df[temp] <- 1
        }
        var.df <- sqrt(var.df)
        df <- sweep(df, 2, var.df, "/")
    }
    
    if (is.numeric(mean.df)) 
        attr(df, "scaled:center") <- mean.df
    if (is.numeric(var.df)) 
        attr(df, "scaled:scale") <- var.df
    
    return(df)
}



meanfacwt <- function(df, fac = NULL, wt = rep(1/nrow(df), nrow(df)), drop = FALSE) {
  ## return res: rows are groups, columns variables
  df <- data.frame(df)
  if(identical(all.equal(wt, rep(1 / nrow(df), nrow(df))), TRUE)) { ## uniform weights
    if(is.null(fac)) { ## no factor
      res <- colMeans(df)
    } else {
      fac <- as.factor(fac)
      if(drop)
        fac <- factor(fac)
      res <- t(sapply(split(df,fac),colMeans))
    }
  } else {
    if(is.null(fac)) { ## no factor
      res <- apply(df, 2, weighted.mean, w = wt)
    } else {
      fac <- as.factor(fac)
      if(drop)
         fac <- factor(fac)
      df.list <- split(df, fac)
      wt.list <- split(wt, fac)
      if(ncol(df) > 1)
        res <- t(sapply(1:nlevels(fac), function(x) apply(df.list[[x]], 2, weighted.mean, w = wt.list[[x]])))
      else
        res <- as.matrix(sapply(1:nlevels(fac), function(x) apply(df.list[[x]], 2, weighted.mean, w = wt.list[[x]])))
      rownames(res) <- names(df.list)
    }
  }
  return(res)
}



covfacwt <- function(df, fac = NULL, wt = rep(1/nrow(df), nrow(df)), drop = FALSE) {
  df <- data.frame(df)
  nr <- nrow(df)
  if(identical(all.equal(wt, rep(1/nrow(df), nrow(df))), TRUE)) { ## uniform weights
    if(is.null(fac)) { ## no factor
      res <- cov(df) * (nr - 1) / nr
    } else {
      fac <- as.factor(fac)
       if(drop)
         fac <- factor(fac) ## to drop unused levels
      res <- lapply(split(df,fac), function(x) cov(x) * (nrow(x) - 1) / nrow(x))
    }
  } else {
    if(is.null(fac)) {## no factor
      res <- covwt(df, wt = wt)
    } else {
      fac <- as.factor(fac)
      if(drop)
        fac <- factor(fac)
      df.list <- split(df, fac)
      wt.list <- split(wt, fac)
      res <- lapply(1:nlevels(fac), function(x) covwt(df.list[[x]], wt = wt.list[[x]]))
      names(res) <- names(df.list)
    }
  }
  return(res)
  ## liste, matrix var/covar, 1 element=1 group (order according to levels(fac))
}




## attention works only with data.frame or matrix
varfacwt <- function(df, fac = NULL, wt = rep(1 / nrow(df), nrow(df)), drop = FALSE) {
  df <- data.frame(df)
  nr <- nrow(df)
  if(identical(all.equal(wt, rep(1 / nrow(df), nrow(df))), TRUE)) { ## uniform weights
    if(is.null(fac)) { ## no factor
      res <- apply(df, 2, var) * (nr - 1) / nr
    } else {
      fac <- as.factor(fac)
      if(drop)
        fac <- factor(fac)
      df.list <- split(df, fac)
      res <- t(sapply(1:nlevels(fac), FUN = function(x) {apply(df.list[[x]], 2, function(y) var(y) * (NROW(y) - 1) / NROW(y))}))      
    }
  } else {
    if(is.null(fac)) { ## no factor
      res <- apply(df, 2, varwt, wt = wt)
    } else {
      fac <- as.factor(fac)
      if(drop)
        fac <- factor(fac)
      df.list <- split(df, fac)
      wt.list <- split(wt, fac)
      res <- t(sapply(1:nlevels(fac), FUN = function(x) {apply(df.list[[x]], 2, varwt, wt = wt.list[[x]])}))
      rownames(res) <- names(df.list)
    }
  }
  return(res)
}


scalefacwt <- function(df, fac = NULL, wt = rep(1 / nrow(df), nrow(df)), scale = TRUE, drop = FALSE) {
  mean.df <- meanfacwt(df = df, fac = fac, wt = wt)
  if(scale)
    var.df <- varfacwt(df = df, fac = fac, wt = wt)
  else
    var.df <- FALSE
  
  if(is.null(fac))
    res <- scale(df, scale = sqrt(var.df), center = mean.df)
  else {
    fac <- as.factor(fac)
    if(drop)
      fac <- factor(fac)
    df.list <- split(df, fac)
    res <- lapply(1:nlevels(fac), function(x) as.data.frame(scale(df.list[[x]], scale = ifelse(scale, sqrt(var.df[x,]), FALSE), center = mean.df[x,])))
    res <- unsplit(res,fac)
  }
  return(res)
}
