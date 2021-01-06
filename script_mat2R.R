mat_path <- "C:/Users/Amir/Desktop/bio_majid/tvsp_edit/outputs"

num_files <- length(list.files(mat_path))

files_name <- list.files(path = mat_path)

for (i in 1:num_files)
{
  file_adress <- file.path(mat_path, files_name[i])
  tempname <- readMat(file_adress)
  tempname = tempname[[1]]
  fname = unlist(strsplit(files_name[i], split='.', fixed=TRUE))[1]
  assign(fname, tempname)
  save(list=fname, file = paste(paste('data', fname, sep="/") , "RData", sep = "."))
}

