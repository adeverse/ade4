# "cca" <- function (sitspe, sitenv, scannf = TRUE, nf = 2) {
#     sitenv <- data.frame(sitenv)
#     if (!inherits(sitspe, "data.frame")) 
#         stop("data.frame expected")
#     if (!inherits(sitenv, "data.frame")) 
#         stop("data.frame expected")
#     coa1 <- dudi.coa(sitspe, scannf = FALSE, nf = 8)
#     x <- pcaiv(coa1, sitenv, scannf = scannf, nf = nf)
#     class(x) <- c("cca", "pcaiv", "dudi")
#     x$call <- match.call()
#     return(x)
# }
# 
# summary.caiv <- function(object, ...){
#     thetitle <- "Canonical correspondence analysis"
#     cat(thetitle)
#     cat("\n\n")
#     summary.dudi(object, ...)
# 
#     thecall <- as.list(object$call)
#     thecoa <- eval.parent(as.list(caiv1$call)$dudi)
#     thecallcoa <- as.list(thecoa$call)
#     
#     # df <- as.data.frame(eval.parent(appel$sitenv))
#     # spe <- eval.parent(appel$sitspe)
#     # coa1 <- dudi.coa(spe, scannf = FALSE)
# 
#     cat(paste("Total unconstrained inertia (", deparse(thecallcoa$df), "): ", sep = ""))
#     cat(signif(sum(thecoa$eig), 4))
#     cat("\n\n")
# 
#     cat(paste("Inertia of" , deparse(thecallcoa$df), "explained by", deparse(thecall$df), "(%): "))
#     cat(signif(sum(object$eig) / sum(thecoa$eig) * 100, 4))
#     cat("\n\n")
# }
# 
