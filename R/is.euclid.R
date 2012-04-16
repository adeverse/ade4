"is.euclid" <- function (distmat, plot = FALSE, print = FALSE, tol = 1e-07) {
  if (!inherits(distmat, "dist")) 
    stop("Object of class 'dist' expected")
  if(any(distmat<tol))
    warning("Zero distance(s)")
  distmat <- as.matrix(distmat)
  n <- ncol(distmat)
  delta <- -0.5 * bicenter.wt(distmat * distmat)
  lambda <- eigen(delta, symmetric = TRUE, only.values = TRUE)$values
  w0 <- lambda[n]/lambda[1]
  if (plot) 
    barplot(lambda)
  if (print) 
    print(lambda)
  return((w0 > -tol))
}

"summary.dist" <- function (object, ...) {
  if (!inherits(object, "dist")) 
    stop("For use on the class 'dist'")
  cat("Class: ")
  cat(class(object), "\n")
  cat("Distance matrix by lower triangle : d21, d22, ..., d2n, d32, ...\n")
  cat("Size:", attr(object, "Size"), "\n")
  cat("Labels:", attr(object, "Labels"), "\n")
  cat("call: ")
  print(attr(object, "call"))
  cat("method:", attr(object, "method"), "\n")
  cat("Euclidean matrix (Gower 1966):", is.euclid(object), "\n")
}

