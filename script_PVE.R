# PVE stands for percentage of variation explained (PVE)
# This script help us to find a proper value for the Number of Features (J) depends on the data set

## Load data
num_files <- length(list.files("./data/"))
files_name <- list.files(path = "./data/")
for (i in 1:num_files)
{
  fname = unlist(strsplit(files_name[i], split='.', fixed=TRUE))[1]
  sim_data <- get(fname)
  ## Generate PVEs for J ranging from 1 to the number of samples divided by 2.
  result.pve <- FLLat.PVE(sim_data)
  ## Generate PVE plot.
  setEPS()
  postscript(paste(fname, "eps", sep="."))
  plot(result.pve)
  dev.off()
}
#TODO Automatically select best J
