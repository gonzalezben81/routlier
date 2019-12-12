# routlier_simple
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
#' Routlier: Simple data frame from routlier:
#'
#' The word 'Outlier' will replace the value that is an outlier in the respective cell.
#'
#' \if{html}{\figure{routlier_simple.png}{options: width=60\% alt="R logo"}}
#'
#'
#'
#' @param data filepath to data
#' @param sd number of standard deviations.
#' @keywords routlier_simple
#' @return Return's an outlier dataset from the original dataset in a rhandonstable
#' @name routlier_simple
#' @title routlier_simple
#' @usage routlier_simple(data, sd)
#' @import dplyr
#' @import DT
#' @import rhandsontable
#' @examples
#' ## Load the routlier library
#'
#'
#' ## Look at 2 SD outliers
#'   routlier_simple(data = iris,sd = 2)
#'
#' ## Look at 3 SD outliers
#'
#'   routlier_simple(data = iris,sd = 3)
#' @export
#'


# routlier_simple <- function(data,sd,columns){
#   # require(rhandsontable,quietly = TRUE)
#   # require(DT,quietly = TRUE)
#   # require(dplyr,quietly = TRUE)
#
#   ##Removes all columns that are not numeric from the dataset
#   original <- data[,order(names(data))]
#   datal<- data[, sapply(data, is.logical)]
#   dataf <- data[,sapply(data,is.factor)]
#   datac <- data[,sapply(data, is.character)]
#   data_before<- data[, sapply(data, is.numeric)]
#   data<- data[, sapply(data, is.numeric)]
#   data <- round(data,digits = 2)
#   ###If missing the columns argument default to look for Outlier in the entire dataset.
#   if(missing(columns)){
#     data <- data
#   }else{
#     print(columns)
#     data <- data[,columns]
#   }
#   ##Count the number of outliers in the dataset
#   numout<- sum(abs(scale(data,center = TRUE,scale = TRUE))>sd )
#   if(TRUE%in%abs(scale(data,center = TRUE,scale = TRUE)>sd)){
#     for(i in seq_along(data)){
#       #if(sum(scale(data[,i])>1)){data[,i][scale(data[,i])>1] <- "Outlier"}
#       ##Calculates the abs of the z-score of the dataset using the scale function
#       data[[i]][abs(scale(data[[i]]))>=sd ] <- "Outlier"
#
#     }
#     ##Bind the data back together
#     outlier <- data
#     binded <- cbind(data_before,datac,dataf,datal)
#     final<- binded[,sort.list(names(original))]
#     message(paste("You have ",numout," outliers in your dataset"))
#     ##Create datatable with Outliers
#     dataset <- final
#     data_frames<- list("Original Data Frame"=dataset,"Outlier Data Frame"=outlier)
#     return(outlier)
#   }else{
#     message(paste("You have NO outliers in your dataset"))
#     ##Create datatable without Outliers
#     return(original)
#   }
#
# }

routlier_simple <- function(data,sd){
 # require(rhandsontable,quietly = TRUE)
 # require(DT,quietly = TRUE)
 # require(dplyr,quietly = TRUE)
 ##Removes all columns that are not numeric from the dataset
 original <- data[,order(names(data))]
 datal<- data[, sapply(data, is.logical)]
 dataf <- data[,sapply(data,is.factor)]
 datac <- data[,sapply(data, is.character)]
 data<- data[, sapply(data, is.numeric)]
 # data <- round(data,digits = 2)
 ##Count the number of outliers in the dataset
 numout<- sum(abs(scale(data,center = TRUE,scale = TRUE))>sd )
 if(TRUE%in%abs(scale(data,center = TRUE,scale = TRUE)>sd)){
   for(i in seq_along(data)){
     #if(sum(scale(data[,i])>1)){data[,i][scale(data[,i])>1] <- "Outlier"}
     ##Calculates the abs of the z-score of the dataset using the scale function
     data[[i]][abs(scale(data[[i]]))>=sd ] <- "Outlier"
   }
   ##Bind the data back together
   binded <- cbind(data,datac,dataf,datal)
   final<- binded[,sort.list(names(original))]
   message(paste("You have ",numout," outliers in your dataset"))
   ##Create datatable with Outliers
   dataset <- final
   return(dataset)}else{
     message(paste("You have NO outliers in your dataset"))
     ##Create datatable without Outliers
     return(original)
   }
}
