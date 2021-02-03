# PVE stands for percentage of variation explained (PVE)
# This script help us to find a proper value for the Number of Features (J) depends on the data set

## Load data
num_files <- length(list.files("./data/"))
files_name <- list.files(path = "./data/")
methods_name <- list("FLLat", "SFLLat", "RFLLat")
empty_vec <- vector(mode="character", length=num_files * 3)
opt_feat <- list(method = empty_vec,fname = empty_vec, opt_feat_num = numeric(num_files*3))
num_of_methods <- length(methods_name)
odd_val <- -3
for (i in 1:num_files)
{
  odd_val <- odd_val+2
  fname = unlist(strsplit(files_name[i], split = '.', fixed = TRUE))[1]
  sim_data <- get(fname)

  for (k in 1:num_of_methods)
  {
    ## Generate PVEs for J ranging from 1 to the number of samples divided by 2.
    if (methods_name[k] == "FLLat")
      result.pve <- FLLat.PVE(sim_data, maxiter=5)
    else if (methods_name[k] == "SFLLat")
      result.pve <- FLLat.PVE(sim_data, maxiter=5)
    else if (methods_name[k] == "RFLLat")
      result.pve <- FLLat.PVE(sim_data, maxiter=5)

    ## Find and save optimal J for later
    opt_feat$opt_feat_num[i+k+odd_val] = optimal_j_calculator(result.pve)
    opt_feat$fname[i+k+odd_val] = fname
    opt_feat$method[i+k+odd_val] = methods_name[k]
    ## plot
    setEPS()
    postscript(paste(paste(paste("./outputs",fname,sep="/"), methods_name[k], sep="_"), "eps", sep = "."))
    plot(result.pve)
    dev.off()
  }
}
save(opt_feat, file="./outputs/opt_feat.RData")
