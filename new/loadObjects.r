source("parameters.r")
source("queryTools.r")
library(doBy)
library(methods)

##################################################################################################################################
# registry

fields = list(start_date='character',
              end_date='character',
              discharged_only='logical')

methods = list(filter=function(){
                data <<- data[!is.na(data$DATAORAINGTI) & !is.na(as.Date(data$DATAORAINGTI)),]
                if(nchar(start_date)!=0){
                    data <<- data[as.Date(data$DATAORAINGTI) >= start_date,]
                }
                if(nchar(end_date)!=0){
                    data <<- data[as.Date(data$DATAORAINGTI) <= end_date,]
                }
                if(discharged_only){
                    data <<- data[!is.na(data$DATAORAUSCTI),]
                }
            })

setRefClass("registry", 
            fields=fields,
            methods=methods,
            contains="db_loader")


##################################################################################################################################
# beds

fields = list(registry_df='data.frame')

methods = list(clean=function(){
                     # CodiceGiViTI2centreCode ancora non definita nel refactoring!
                     data <<- CodiceGiViTI2centreCode(data)
                     data <<- orderBy(~ centreCode + IDRICOVERO + DATARIFERIMENTO + ID, data)
                     data <<- data[!duplicated(data[, setdiff(names(data), 'ID')]), ] 
                },
               registry_merge=function(){
                     data <<- merge(data, registry_df[, c('centreCode','IDRICOVERO','DATAORAINGTI','DATAORAUSCTI')])    
                })

setRefClass("beds", 
            fields=fields,
            methods=methods,
            contains="db_loader")


##################################################################################################################################
# antibiotics

fields = list(loadAdministration='logical')

methods = list()

setRefClass("antibiotics", 
            fields=fields,
            methods=methods,
            contains="db_loader")