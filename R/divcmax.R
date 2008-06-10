divcmax <- function(dis, epsilon = 1e-008, comment = FALSE)
{
# inititalisation
    if(!inherits(dis, "dist")) stop("Distance matrix expected")
    if(epsilon <= 0) stop("epsilon must be positive")
    if(!is.euclid(dis)) stop("Euclidean property is expected for dis")
    D2 <- as.matrix(dis)^2 / 2
    n <- dim(D2)[1]
    result <- data.frame(matrix(0, n, 4))
    names(result) <- c("sim", "pro", "met", "num")
    relax <- 0    # determination de la valeur initiale x0
    x0 <- apply(D2, 1, sum) / sum(D2)
    result$sim <- x0    # ponderation simple
    objective0 <- t(x0) %*% D2 %*% x0
    if (comment == TRUE)
        print("evolution of the objective function:")
    xk <- x0    # grande boucle de test des conditions de Kuhn-Tucker
    repeat {
        # boucle de test de nullite du gradient projete
        repeat {
            maxi.temp <- t(xk) %*% D2 %*% xk
            if(comment == TRUE) print(as.character(maxi.temp))    
            #calcul du gradient
            deltaf <- (-2 * D2 %*% xk)    
            # determination des contraintes saturees
            sature <- (abs(xk) < epsilon)
            if(relax != 0) {
                sature[relax] <- FALSE
                relax <- 0
            }
            # construction du gradient projete
            yk <- ( - deltaf)
            yk[sature] <- 0
            yk[!(sature)] <- yk[!(sature)] - mean(yk[!(
                sature)])    
            # test de la nullite du gradient projete
            if (max(abs(yk)) < epsilon) {
                break
            }
            # determination du pas le plus grand compatible avec les contraintes
            alpha.max <- as.vector(min( - xk[yk < 0] / yk[yk < 
                0]))
            alpha.opt <- as.vector( - (t(xk) %*% D2 %*% yk) / (
                t(yk) %*% D2 %*% yk))
            if ((alpha.opt > alpha.max) | (alpha.opt < 0)) {
                alpha <- alpha.max
            }
            else {
                alpha <- alpha.opt
            }
            if (abs(maxi.temp - t(xk + alpha * yk) %*% D2 %*% (
                xk + alpha * yk)) < epsilon) {
                break
            }
            xk <- xk + alpha * yk
        }
        # verification des conditions de KT
        if (prod(!sature) == 1) {
            if (comment == TRUE)
                print("KT")
            break
        }
        vectD2 <- D2 %*% xk
        u <- 2 * (mean(vectD2[!sature]) - vectD2[sature])
        if (min(u) >= 0) {
            if (comment == TRUE)
                print("KT")
            break
        }
        else {
            if (comment == TRUE)
                print("relaxation")
            satu <- (1:n)[sature]
            relax <- satu[u == min(u)]
            relax <-relax[1]
        }
    }
    if (comment == TRUE)
        print(list(objective.init = objective0, objective.final
             = maxi.temp))
    result$num <- as.vector(xk, mode = "numeric")
    result$num[result$num < epsilon] <- 0
    # ponderation numerique
    xk <- x0 / sqrt(sum(x0 * x0))
    repeat {
        yk <- D2 %*% xk
        yk <- yk / sqrt(sum(yk * yk))
        if (max(xk - yk) > epsilon) {
            xk <- yk
        }
        else break
    }
    x0 <- as.vector(yk, mode = "numeric")
    result$pro <- x0 / sum(x0)    # ponderation propre
    result$met <- x0 * x0    # ponderation propre
    restot <- list()
    restot$value <- divc(cbind.data.frame(result$num), dis)[,1]
    restot$vectors <- result
    return(restot)
}

