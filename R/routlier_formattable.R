# routlier_formattable
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:   'Ctrl + Shift + T'
#' @title Outlier(s) returned in an formattable table
#'
#' @description
#' The outlier will be highlighted in green and the word 'Outlier' will replace the value in the cell.
#'
#' \if{html}{\figure{routlier_formattable_two.png}{options: width=100\% alt="R logo"}}
#' \if{latex}{\figure{routlier_fromattable_two.png}{options: width=0.5in}}
#'
#' @param data filepath to data.
#' @param sd number of standard deviations to check the data against.
#' @keywords routlier_formattable
#' @return Returns an outlier dataset from the original dataset in a DT table
#' @name routlier_formattable
#' @title routlier_formattable
#' @import dplyr
#' @import DT
#' @import formattable
#' @usage routlier_formattable(data,sd)
#' @examples
#'
#'
#'   routlier_formattable(data = detroit,sd = 2)
#'
#' @export
utils::globalVariables(c("."))

routlier_formattable <- function(data,sd){
  # require(rhandsontable,quietly = TRUE)
  # require(DT,quietly = TRUE)
  # require(dplyr,quietly = TRUE)
  ##Removes all columns that are not numeric from the dataset
  original_set <- data
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
      data[[i]][abs(scale(data[[i]],center = TRUE,scale = TRUE))>=sd ] <- 0
    }
    ##Bind the data back together
    binded <- cbind(data,datac,dataf,datal)
    binded <- as.data.frame(binded)
    colnames(binded) <- c(names(original_set))
    # final<- binded[,sort.list(names(original)decreasing = T)]
    # colnames(final) <- c(names(original_set))
    # original_set <- original_set[,sort.list(names(original))]
    final <- binded %>% select(sort(names(.),decreasing = T))
    # colnames(original_set) <- c(names(original_set))
    original_set <- original_set %>% select(sort(names(.),decreasing = T))

    message(paste("You have ",numout," outliers in your dataset"))
    ##Create datatable with Outliers
    print(names(final))
    # print(final)
    print(names(original_set))
    dataset <- formattable(original_set, list(area(col = c(1:length(original_set))) ~ formatter('span', style = original_set ~ style(color= ifelse(original_set == final,'green', 'red')))))
    return(dataset)}else{
      message(paste("You have NO outliers in your dataset"))
      ##Create datatable without Outliers
      return(original)
    }
}
