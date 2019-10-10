# routlie_rh_sd
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
#'
#' The outlier will highlighted in green and the word 'Outlier' will replace the value in the cell.
#'
#' \if{html}{\figure{routlier_rh.png}{options: width=40\% alt="R logo"}}
#' \if{latex}{\figure{routlier_rh.png}{options: width=0.5in}}
#'
#' @param data filepath to data
#' @param sd number of standard deviations.
#' @keywords routlier_rh_sd
#' @return Return's an outlier dataset from the original dataset in a rhandonstable. The user must specify the standard deviation to determine the outlier.
#' @name routlier_rh_sd
#' @title routlier_rh_sd
#' @usage routlier_rh_sd(data, sd)
#' @import dplyr
#' @import DT
#' @import rhandsontable
#' @examples
#'
#'
#' ## Look at 2 SD outliers
#'   routlier_rh_sd(data = iris,sd = 2)
#'
#' ## Look at 3 SD outliers
#'
#'   routlier_rh_sd(data = iris, sd = 3)
#' @export
#'

routlier_rh_sd <- function(data,sd){

  # require(rhandsontable,quietly = TRUE)
  # require(DT,quietly = TRUE)
  # require(dplyr,quietly = TRUE)

  ##Removes all columns that are not numeric from the dataset
  original <- data[,order(names(data))]
  datal<- data[, sapply(data, is.logical)]
  dataf <- data[,sapply(data,is.factor)]
  datac <- data[,sapply(data, is.character)]
  data<- data[, sapply(data, is.numeric)]
  data <- round(data,digits = 2)
  ##Count the number of outliers in the dataset
  numout<- sum(abs(scale(data))>sd )
  if(TRUE%in%abs(scale(data)>sd)){
    for(i in seq_along(data)){
      #if(sum(scale(data[,i])>1)){data[,i][scale(data[,i])>1] <- "Outlier"}
      ##Calculates the abs of the z-score of the dataset using the scale function
      data[[i]][abs(scale(data[[i]]))>sd ] <- "Outlier"

    }
    ##Bind the data back together
    binded <- cbind(data,datac,dataf,datal)
    final<- binded[,sort.list(names(original))]
    message(paste("You have ",numout," outliers in your dataset"))
    ##Create datatable with Outliers
    dataset<- rhandsontable(data = final,width = "auto",height = "auto") %>%
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
      dataset<- rhandsontable(data = original,width = "auto",height = "auto") %>%
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
