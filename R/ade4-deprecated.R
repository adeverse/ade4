"between" <- function (dudi, fac, scannf = TRUE, nf = 2) {
  .Deprecated(new="bca", package="ade4", 
              msg="To avoid some name conflicts, the 'between' function is now deprecated. Please use 'bca' instead")
  res <- bca(x=dudi, fac=fac, scannf = scannf, nf = nf)
  res$call <- match.call()
  return(res)
}

"betweencoinertia" <- function (obj, fac, scannf = TRUE, nf = 2) {
  .Deprecated(new="bca", package="ade4", 
              msg="To avoid some name conflicts, the 'betweencoinertia' function is now deprecated. Please use 'bca.coinertia' instead")
  res <- bca(x=obj, fac=fac, scannf = scannf, nf = nf)
  res$call <- match.call()
  return(res)
}

"within" <- function (dudi, fac, scannf = TRUE, nf = 2) {
  .Deprecated(new="wca", package="ade4", 
              msg="To avoid some name conflicts, the 'within' function is now deprecated. Please use 'wca' instead")
  res <- wca(x=dudi, fac=fac, scannf = scannf, nf = nf)
  res$call <- match.call()
  return(res)
}

"withincoinertia" <-  function (obj, fac, scannf = TRUE, nf = 2){
  .Deprecated(new="wca", package="ade4", 
              msg="To avoid some name conflicts, the 'withincoinertia' function is now deprecated. Please use 'wca.coinertia' instead")
  res <- wca(x=obj, fac=fac, scannf = scannf, nf = nf)
  res$call <- match.call()
  return(res)
}