## BIC stands for Bayesian information criterion

## Load data
num_files <- length(list.files("./data/"))
files_name <- list.files(path = "./data/")
methods_name <- list("FLLat", "SFLLat", "RFLLat")
empty_vec <- vector(mode="character", length=num_files * 3)
opt_lam <- list(fname=empty_vec, lam1=numeric(num_files*3), lam2=numeric(num_files*3))
for (i in 1:num_files)
{
  fname = unlist(strsplit(files_name[i], split='.', fixed=TRUE))[1]
  sim_data <- get(fname)

  ## Run FLLat.BIC to choose optimal hyper parameter for a specific J
  for (k in 1:length(methods_name))
  {
    if (methods_name[k] == "FLLat")
      result.bic <- FLLat.BIC(sim_data, J=opt_feat$opt_feat_num[i+(k-1)*num_files])
    else if (methods_name[k] == "SFLLat")
      result.bic <- FLLat.BIC(sim_data, J=opt_feat$opt_feat_num[i+(k-1)*num_files])
    else if (methods_name[k] == "RFLLat")
      result.bic <- FLLat.BIC(sim_data, J=opt_feat$opt_feat_num[i+(k-1)*num_files])
  }


  ## Plot the features for the optimal FLLat model.
  png(paste(paste(paste("./outputs/features_",fname,sep="/"), methods_name[k], sep="_"), "png", sep='.'))
  plot(result.bic$opt.FLLat)
  dev.off()
  ## Plot a heatmap of the weights for the optimal FLLat model.
  #plot(result.bic$opt.FLLat,type="weights")
  dev.off()
}
