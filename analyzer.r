# Set up the working directory 
path_lib_M3 <- file.path('old/')
setwd(path_lib_M3)


# Set up directory to save results
save_dir <- 
dir.create(format( Sys.time(), "%Y_%m_%d_%H_%M" ))
