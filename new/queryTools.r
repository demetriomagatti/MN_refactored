library(RPostgreSQL)


# Load data from PostgreSQL database. 
# Arguments:
#    query [string]: sql-like query string;
#    dbname [string]: database name; default: NULL;
#    conffile [source file]: configuration file to be sourced; contains connection infos (username, pwd, port, ...);
#    connectionParameters [i have to look]: allows to use custom connection parameters; default: NULL;
#    maxResty [int]: maximum number of iterations to attempt in case of connection error;
#    wait [int]: wait time after a failed connection attempt (milliseconds?).
#
# Returns: dataFrame containing downloaded data.
load_db <- function(query, dbname=NULL, conffile=DEFCONFFILE, connectionParameters=NULL, maxRetry=8000, wait=5){
    drv <- dbDriver("PostgreSQL")

    if(is.null(connectionParameters)){
        source(conffile)
        if(is.null(dbname)){
            dbname <- dball
        }
    }
  
    on.exit({
        lapply(dbListConnections(drv), dbDisconnect)
        dbUnloadDriver(drv)
    })

    for(i in 1:maxRetry){
        tryCatch({
            lapply(dbListConnections(drv), dbDisconnect)
            if(is.null(connectionParameters)){
                connection <- dbConnect(drv, dbname=dbname,user=user,password=passwd,host=server,port=port)
            }else{
                connection <- do.call(dbConnect, c(drv, as.list(connectionParameters)))
            }
            reg <- dbGetQuery(connection, query)
            if(is.null(reg)){
                stop('Query failed')
            }
            return(reg)
            },
            error = function(e){
                message(e, ' - attempt number ', i)
                Sys.sleep(wait)
            },
            finally = {
                lapply(dbListConnections(drv), dbDisconnect)
            }
        )
    }

    stop('Cannot run query: ', query, '\nmaxRetry reached.')
}


# Modifies a query by adding extra filters
# Arguments:
#    query[str]: query to be modified;
#    centers_list[character array]: list of the centers to be kept; default: NULL;
#    condition_list[character array]: extra conditions; default: NULL. 
#
#    condition_list example: class(condition_list) = character;
#       [1] "LOWER(\"PRINCIPIOATTIVO\") SIMILAR TO '%(glucosio|destrosio)%'"
#       [2] "LOWER(\"PRINCIPIOATTIVO\") SIMILAR TO '%(glucosio|destrosio)%'"
#    add to documentation and remove from here
customize_query <- function(query, centers_list=NULL, conditions_list=NULL){
    if(!is.null(centers_list)){
        query <- paste(query, 'WHERE (', paste('"CodiceGiViTI" IN (\'', paste(centreCode2CodiceGiViTI(centers_list), collapse="','"),'\'))', sep = ''))
    }
    if(!is.null(conditions_list)){
        if(!is.null(centers_list)){
            query <- paste(query, 'AND (')
        }
        else{
            query <- paste(query, 'WHERE (')
        }
        query <- paste(query, paste(unlist(conditions_list), collapse = ' ) AND ( ' ), ')')
    }
    return(query)
}


# Loader object
# Attributes:
# Methods:
fields=list(data='data.frame',
            query='character',
            dbname='character', 
            conffile='character', 
            connectionParameters='character', 
            maxRetry='numeric', 
            wait='numeric',
            remove_duplicates='logical',
            centers_list='character')

methods=list(initialize_default_values=function(){
                dbname <<- ""
                conffile <<- DEFCONFFILE
                connectionParameters <<- ""
                maxRetry <<- 8000
                wait <<- 5
                centers_list <<- ""
                },
             load=function(){
                if((nchar(dbname)==0) & (nchar(connectionParameters)==0)){
                    data <<- load_db(query, as.null(dbname), conffile, as.null(connectionParameters), maxRetry, wait)
                }
                else if(nchar(dbname)==0){
                    data <<- load_db(query, as.null(dbname), conffile, connectionParameters, maxRetry, wait)
                }
                else if(nchar(connectionParameters)==0){
                    data <<- load_db(query, dbname, conffile, as.null(connectionParameters), maxRetry, wait)  
                }
             })

setRefClass("db_loader", fields=fields, methods=methods)