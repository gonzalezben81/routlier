# routlierh
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
#' Routlier: Outlier in Rhandsontable
#' \if{html}{\figure{routlier_rh.png}{options: width=25\% alt="R logo"}}
#' \if{latex}{\figure{routlier_rh.png}{options: width=0.5in}}
#' The outlier will highlighted in green and the word 'Outlier' will replace the value in the cell.
#' @param data filepath to data
#' @keywords routlier_rh_sd
#' @return Return's an outlier dataset from the original dataset in a rhandonstable. The user must specify the standard deviation to determine the outlier.
#' @name routlier_rh
#' @title routlier_rh
#' @export
#'

routlier_rh_sd <- function(data,sd){

  require(rhandsontable,quietly = TRUE)
  require(DT,quietly = TRUE)
  require(dplyr,quietly = TRUE)

  ##Removes all columns that are not numeric from the dataset
  data<- data[, sapply(data, is.numeric)]
  ##Count the number of outliers in the dataset
  numout<- sum(abs(scale(data))>sd )
  if(TRUE%in%abs(scale(data)>sd)){
    for(i in seq_along(data)){
      #if(sum(scale(data[,i])>1)){data[,i][scale(data[,i])>1] <- "Outlier"}
      ##Calculates the abs of the z-score of the dataset using the scale function
      data[[i]][abs(scale(data[[i]]))>sd ] <- "Outlier"

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
