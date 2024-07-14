#' @title Returns outlier(s) in a DT table where the users specifies the standard deviation
#'
#' @description
#'  The outlier will highlighted in green and the word 'Outlier' will replace the value in the cell.
#'
#' \if{html}{\figure{routlier.png}{options: width=100\% alt="R logo"}}
#' \if{latex}{\figure{routlier.png}{options: width=0.5in}}
#'
#' @param data filepath to data.
#' @param sd number of standard deviations.
#' @keywords routlierdt
#' @return Returns an outlier dataset from the original dataset in a DT table. The user must specify the standard deviation to determine the outlier.
#' @name routlier_dt_sd
#' @title routlier_dt_sd
#' @import dplyr
#' @import DT
#' @import rhandsontable
#' @usage routlier_dt_sd(data, sd)
#' @examples
#'
#' ## Look at 2 SD outliers
#'   routlier_dt_sd(data = iris,sd = 2)
#'
#' ## Look at 3 SD outliers
#'
#'   routlier_dt_sd(data = iris, sd = 3)
#' @export


routlier_dt_sd <- function(data,sd){

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
  original <- data[,order(names(data))]
  datal<- data[, sapply(data, is.logical)]
  dataf <- data[,sapply(data,is.factor)]
  datac <- data[,sapply(data, is.character)]
  data<- data[, sapply(data, is.numeric)]
  data <- round(data,digits = 2)
  ##Count the number of outliers in the dataset
  numout<- sum(abs(scale(data,center = TRUE,scale = TRUE))>sd )
  if(TRUE%in%abs(scale(data,center = TRUE,scale = TRUE)>sd)){
    for(i in seq_along(data)){
      #if(sum(scale(data[,i])>1)){data[,i][scale(data[,i])>1] <- "Outlier"}
      ##Calculates the abs of the z-score of the dataset using the scale function
      data[[i]][abs(scale(data[[i]],center = TRUE,scale = TRUE))>=sd ] <- "Outlier"

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
