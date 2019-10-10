# routlier_dt
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
#' Routlier: Outlier in DT Table
#'
#' The outlier will be highlighted in green and the word 'Outlier' will replace the value in the cell.
#'
#' \if{html}{\figure{routlier.png}{options: width=100\% alt="R logo"}}
#' \if{latex}{\figure{routlier.png}{options: width=0.5in}}
#'
#' @param data filepath to data.
#' @keywords routlier_dt
#' @return Returns an outlier dataset from the original dataset in a DT table
#' @name routlier_dt
#' @title routlier_dt
#' @import dplyr
#' @import DT
#' @import rhandsontable
#' @usage routlier_dt(data)
#' @examples
#'
#'
#'   routlier_dt(data = iris)
#'
#' @export


routlier_dt <- function(data){

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
  numout<- sum(abs(scale(data,center = TRUE,scale = TRUE))>3 )
  if(TRUE%in%abs(scale(data,center = TRUE,scale = TRUE)>3)){
    for(i in seq_along(data)){
      #if(sum(scale(data[,i])>1)){data[,i][scale(data[,i])>1] <- "Outlier"}
      ##Calculates the abs of the z-score of the dataset using the scale function
      data[[i]][abs(scale(data[[i]]))>=3 ] <- "Outlier"

    }
    ##Bind the data back together
    binded <- cbind(data,datac,dataf,datal)
    final<- binded[,sort.list(names(original))]
    message(paste("You have ",numout," outliers in your dataset"))
    ##Create datatable with Outliers
    dataset <- datatable(final, extensions = c('Buttons'), editable = TRUE,options = list(
      initComplete = JS(
        "function(settings, json) {",
        "$(this.api().table().header()).css({'background-color': 'lightblue', 'color': 'black'});",
        "}"),
      pageLength = 10,
      lengthMenu = c(5, 10, 15, 20, 25, 30, 35, 40, 45, 50),
      dom = 'lBftrip',keys = TRUE,
      buttons = c('copy', 'csv', 'excel', 'pdf','print'),
      extend = 'excel',
      filename = 'outlier.xls'
    )) %>% formatStyle(columns = names(data),
                       background = styleEqual(c(0, "Outlier"), c("white", "lightgreen")))
    return(dataset)}else{
      message(paste("You have ",numout," outliers in your dataset"))
      ##Create datatable without Outliers
      dataset <- datatable(original, extensions = c('Buttons'), editable = TRUE,options = list(
        pageLength = 10,
        lengthMenu = c(5, 10, 15, 20, 25, 30, 35, 40, 45, 50),
        dom = 'lBftrip',keys = TRUE,
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        editor = c('create')
      )) %>% formatStyle(columns = names(original),
                         background = styleEqual(c(0, "Outlier"), c("white", "lightgreen")))
      return(dataset)
    }

}
