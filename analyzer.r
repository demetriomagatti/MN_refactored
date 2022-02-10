# Load libraries


# Set up the working directory 
path_lib_M3 <- file.path('new/')
setwd(path_lib_M3)


# Load analysis parameters
source('parameters.r')
source('loadObjects.r')


# Manual source for ongoing development 


# Set up directory to save results
if(save_results){
    path_save_dir <- file.path('../results',format( Sys.time(), "%Y%m%d_%H%M" ))
    dir.create(path_save_dir)
} 


# Load registry 
query <- 'SELECT * FROM "EXPORT_RICOVERI"'
registry <- new("registry")
registry$initialize_default_values()
registry$query <- query
registry$load()




