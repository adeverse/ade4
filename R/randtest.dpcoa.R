randtest.dpcoa <- function(xtest, model = c("1p","1s"), nrep = 99, alter = c("greater", "less", "two-sided"), ...){

    if (!inherits(xtest, "dpcoa")) 
        stop("Type 'dpcoa' expected")

    appel <- as.list(xtest$call)
    df0 <- eval.parent(appel$df)
    df <- as.data.frame(t(df0))
    dis <- eval.parent(appel$dis)
    if(is.character(model)) model <- model[1]

	if(nrow(df) < 3) stop("df is too small for a permutation test")
	obs <- apqe(df, dis)
	obs <- obs$results[1,]/obs$results[3,]

        funrandomization <- function(i){
		if(is.function(model)) 
			simdf <- as.data.frame(t(model(df0, ...)))
		else{
		if(model=="1s"){
			funperm <- function(x){
				begin <- (1:length(x))[x>0]
				if(length(begin)==1) return(x)
				else{
					end <- sample(begin)
					simx <- x
					simx[begin] <- x[end]
					return(simx)
				}
			}
			simdf <- sapply(df, funperm)
		}
		else{
		if(model=="1p")
			simdf <- df[sample(1:nrow(df)), ]
		else
			stop("The definition of the parameter 'model' is not correct")
		}
		}
		sim <- apqe(simdf, dis)
		sim <- sim$results[1,]/sim$results[3,]
		return(sim)

	}
		
	ressim <- sapply(1:nrep, funrandomization)
	res <- as.randtest(obs = obs, sim = ressim, alter = alter)
	res$call <- match.call()
	return(res)

}
