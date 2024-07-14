# routlie_rh
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'
#' @title Outlier in Rhandsontable
#'
#' @description
#' The outlier will highlighted in green and the word 'Outlier' will replace the value in the cell.
#'
#' \if{html}{\figure{routlier_rh.png}{options: width=40\% alt="R logo"}}
#' \if{latex}{\figure{routlier_rh.png}{options: width=0.5in}}
#'
#' @param data filepath to data
#' @keywords routlier_rh
#' @return Return's an outlier dataset from the original dataset in an rhandonstable.
#' @name routlier_rh
#' @title routlier_rh
#' @import dplyr
#' @import DT
#' @import rhandsontable
#' @usage routlier_rh(data)
#' @examples
#'
#'
#'   routlier_rh(data = iris)
#'
#' @export

routlier_rh <- function(data){

  # Check if the DT namespace is available
  if (!requireNamespace("DT", quietly = TRUE)) {
    stop("Package 'DT' is required but not installed.")
  }
  # Check if the dplyr namespace is available
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' is required but not installed.")
  }
  # Check if the rhandsontable namespace is available
  if (!requireNamespace("rhandsontable", quietly = TRUE)) {
    stop("Package 'rhandsontable' is required but not installed.")
  }

  ##Removes all columns that are not numeric from the dataset
  data<- data[, sapply(data, is.numeric)]
  ##Count the number of outliers in the dataset
  numout<- sum(abs(scale(data))>3 )
  if(TRUE%in%abs(scale(data)>3)){
    for(i in seq_along(data)){
      #if(sum(scale(data[,i])>1)){data[,i][scale(data[,i])>1] <- "Outlier"}
      ##Calculates the abs of the z-score of the dataset using the scale function
      data[[i]][abs(scale(data[[i]]))>3 ] <- "Outlier"

    }
    message(paste("You have ",numout," outliers in your dataset"))
    ##Create datatable with Outliers
    dataset<- rhandsontable(data = data,width = "auto",height = "auto") %>%
      hot_cols(renderer = "
               function (instance, td, row, col, prop, value, cellProperties) {
               Handsontable.renderers.NumericRenderer.apply(this, arguments);
               if (value == 'Outlier') {
               td.style.background = 'lightgreen';
               }
               }")
    return(dataset)}else{
      message(paste("You have ",numout," outliers in your dataset"))
      ##Create datatable without Outliers
      dataset<- rhandsontable(data = data,width = "auto",height = "auto") %>%
        hot_cols(renderer = "
                 function (instance, td, row, col, prop, value, cellProperties) {
                 Handsontable.renderers.NumericRenderer.apply(this, arguments);
                 if (value == 'Outlier') {
                 td.style.background = 'lightgreen';
                 }
                 }")
      return(dataset)
    }
}
