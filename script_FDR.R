
## Load simulated aCGH data.
#data(tempname)

## Run FLLat for J = 5, lam1 = 1 and lam2 = 9.
#result <- FLLat(tempname,J=10,lam1=1,lam2=9)
#result <- RFLLat(simaCGH,alphaHuber=,J=5,lam1=1,lam2=9)
#result <- SFLLat(simaCGH,J=5,lam1=1,lam2=9)

## Estimate the FDRs.
#result.fdr <- FLLat.FDR(tempname,result)

## Plotting the FDRs against the threshold values.
#plot(result.fdr)

## The threshold value which controls the FDR at 0.05.
#result.fdr$thresh.control


## Load data
num_files <- length(list.files("./data/"))
files_name <- list.files(path = "./data/")
methods_name <- list("FLLat", "SFLLat", "RFLLat")
empty_vec <- vector(mode="character", length=num_files * 3)
fdr_vals <- list(method = empty_vec, fname=empty_vec, lam0=numeric(num_files*3), lam1=numeric(num_files*3), lam2=numeric(num_files*3))
odd_val <- -3
temp <- 0


for (i in 1:num_files * 3)
{

  fname = unlist(strsplit(files_name[i], split='.', fixed=TRUE))[1]
  sim_data <- get(fname)

  for (k in 1:length(methods_name)){

    result.fdr <- result.fdr(sim_data, results$bicinfo[i])

    setEPS()
    postscript(paste(paste(paste("./outputs/FDR/FDR_pred_",fname), methods_name[k], sep="_"), "eps", sep = "."))
    plot(result.fdr)
    dev.off()

  }


}
