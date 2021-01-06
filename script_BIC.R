## BIC stands for Bayesian information criterion

## Load data
num_files <- length(list.files("./data/"))
files_name <- list.files(path = "./data/")
for (i in 1:num_files)
{
  fname = unlist(strsplit(files_name[i], split='.', fixed=TRUE))[1]
  sim_data <- get(fname)

  ## Run FLLat.BIC to choose optimal hyper parameter for a specific J

  result.bic <- FLLat.BIC(sim_data, J=9)

  ## Plot the features for the optimal FLLat model.
  png(paste(fname, "png", sep='.'))
  plot(result.bic$opt.FLLat)
  dev.off()
  ## Plot a heatmap of the weights for the optimal FLLat model.
  #plot(result.bic$opt.FLLat,type="weights")
}
