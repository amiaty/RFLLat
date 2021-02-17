## BIC stands for Bayesian information criterion

## Load data
num_files <- length(list.files("./data/"))
files_name <- list.files(path = "./data/")
methods_name <- list("FLLat", "SFLLat", "RFLLat")
empty_vec <- vector(mode="character", length=num_files * 3)
opt_lam <- list(method = empty_vec, fname=empty_vec, lam0=numeric(num_files*3), lam1=numeric(num_files*3), lam2=numeric(num_files*3))
results <- list(bicinfo=numeric(num_files*3))
odd_val <- -3
temp <- 0

for (i in 1:num_files)
{
  odd_val <- odd_val+2
  fname = unlist(strsplit(files_name[i], split='.', fixed=TRUE))[1]
  sim_data <- get(fname)

  ## Run FLLat.BIC to choose optimal hyper parameter for a specific J
  for (k in 1:length(methods_name))
  {
    if (opt_feat$opt_feat_num[i+k+odd_val] != 0){
      temp <- temp +1
      if (methods_name[k] == "FLLat")
        result.bic <- FLLat.BIC(sim_data, J=opt_feat$opt_feat_num[i+k+odd_val])
      else if (methods_name[k] == "SFLLat")
        result.bic <- FLLat.BIC(sim_data, J=opt_feat$opt_feat_num[i+k+odd_val])
      else if (methods_name[k] == "RFLLat")
        result.bic <- FLLat.BIC(sim_data, J=opt_feat$opt_feat_num[i+k+odd_val])


      opt_lam$lam0[i+k+odd_val] = result.bic$lam0
      opt_lam$lam1[i+k+odd_val] = result.bic$lam1
      opt_lam$lam2[i+k+odd_val] = result.bic$lam2

      opt_lam$fname[i+k+odd_val] = fname
      opt_lam$method[i+k+odd_val] = methods_name[k]

      results$bicinfo[i+k+odd_val] <- list(result.bic)

      setEPS()
      postscript(paste(paste(paste("./outputs/Bic/features_",fname), methods_name[k], sep="_"), "eps", sep = "."))
      plot(result.bic$opt.FLLat)

      ## Plot a heatmap of the weights for the optimal FLLat model.
      postscript(paste(paste(paste("./outputs/Bic/features_heatmap_",fname), methods_name[k], sep="_"), "eps", sep = "."))
      plot(result.bic$opt.FLLat,type="weights")


      #plot(result.bic$opt.FLLat,type="weights")
      dev.off()

    }

  }


  ## Plot the features for the optimal FLLat model.
  #png(paste(paste(paste("./outputs/features_ ",fname,sep="/"), methods_name[k], sep="_"), "png", sep='.'))
  #plot(result.bic$opt.FLLat)
  #dev.off()


}

save(opt_lam, file="./outputs/opt_lam.RData")
