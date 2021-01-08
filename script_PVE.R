# PVE stands for percentage of variation explained (PVE)
# This script help us to find a proper value for the Number of Features (J) depends on the data set

## Load data
num_files <- length(list.files("./data/"))
files_name <- list.files(path = "./data/")
methods_name <- list("FLLat", "SFLLat", "RFLLat")
empty_vec <- vector(mode="character", length=num_files * 3)
opt_feat <- list(method = empty_vec,fname = empty_vec, opt_feat_num = numeric(num_files*3))
for (i in 1:num_files)
{
  fname = unlist(strsplit(files_name[i], split = '.', fixed = TRUE))[1]
  sim_data <- get(fname)
  for (k in 1:length(methods_name))
  {
    ## Generate PVEs for J ranging from 1 to the number of samples divided by 2.
    if (methods_name[k] == "FLLat")
      result.pve <- FLLat.PVE(sim_data, maxiter=10)
    else if (methods_name[k] == "SFLLat")
      result.pve <- FLLat.PVE(sim_data, maxiter=10)
    else if (methods_name[k] == "RFLLat")
      result.pve <- FLLat.PVE(sim_data, maxiter=10)

    ## Find and save optimal J for later
    opt_feat$opt_feat_num[i+(k-1)*num_files] = optimal_j_calculator(result.pve)
    opt_feat$fname[i+(k-1)*num_files] = fname
    opt_feat$method[i+(k-1)*num_files] = methods_name[k]
    ## plot
    setEPS()
    postscript(paste(paste(fname, methods_name[k], sep="_"), "eps", sep = "."))
    plot(result.pve)
    dev.off()
  }
}
