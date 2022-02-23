library(stringr)
library(data.table)


###############################################################################################################################
# DATAFRAME MANIPULATION                                                                                                      
###############################################################################################################################

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


###############################################################################################################################
# VISUAL 
###############################################################################################################################

format_same_y <- function(combined_ggplot){
    # returns a figure with (1 row, 2 cols) plots with the same y limits
    # Arguments: 
    #   combined_ggplot[ggproto object]: 1 row, 2 columns figure constructed using the patchwork library 
    ranges_y <- c(ggplot_build(p_combined[[1]])$layout$panel_scales_y[[1]]$range$range,
                  ggplot_build(p_combined[[2]])$layout$panel_scales_y[[1]]$range$range)

    combined_ggplot <- combined_ggplot & ylim(min(p_ranges_y), max(p_ranges_y))
}