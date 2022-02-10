library(stringr)
library(data.table)


clean_merge <- function(df_x, df_y, by_x, by_y){
   # returns merged dataFrame with no duplicate columns
   # Arguments:
   #   df_x, df_y: dataFrames to merge
   #   by_x: df_x column(s) to use for the the merge operation
   #   by_y: df_y column(s) to use for the the merge operation
   merged <- merge(df_x,df_y,by.x=by_x,by.y=by_y)
   merged[grepl('..y', names(merged))] <- NULL
   setnames(merged, old = names(merged), new = str_replace(names(merged), ".x", ""))
}


