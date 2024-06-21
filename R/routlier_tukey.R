# routlier_tukey
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
#' @title Finds the Outliers in a dataset utilizing the Tukey's Method
#'
#' @description
#' The word 'Outlier' will replace the value that is an outlier in the respective cell.
#'
#' \if{html}{\figure{routlier_tukey_detroit.png}{options: width=60\% alt="R logo"}}
#'
#'
#'
#' @param data filepath to data
#' @param type select type of quatile method to use. Choices from 1 to 7.
#' @param outlier_type select type of outlier selecting either "M" for mild or "E" for extreme.
#' @keywords routlier_tukey
#' @return Return's an outlier dataset from the original dataset in a formattable table. The data returned is currently the numeric data only from the dataset.
#' @name routlier_tukey
#' @title routlier_tukey
#' @usage routlier_tukey(data,type,outlier_type)
#' @import dplyr
#' @import DT
#' @import formattable
#' @importFrom stats quantile
#' @examples
#' ## Load the routlier library
#'    library(routlier)
#'
#' ## Look at outliers utilizng the Tukey method
#'   routlier_tukey(data = detroit,type = 7,outlier_type="M")
#'
#' @export
#'
routlier_tukey <- function(data,type,outlier_type){

  ###Subset all of the data that is numeric
  original <- data[,sapply(data,is.numeric)]
  data <- data[,sapply(data,is.numeric)]

  ###Which 'type' of statistical test to use in the quantile function
  type <- type
  ###Initialize an empty data_list
  data_list <- list()

  for (i in seq_along(data)){
    ###Calculates the upper_quartile range of the data
    upper_quartile<- quantile(data[[i]],probs = 0.75,type = type)

    ###Calculates the lower_quartile range of the data
    lower_quartile <- quantile(data[[i]],probs = 0.25,type = type)

    ###The cut_off or original range of the data
    cut_off <- upper_quartile-lower_quartile
    ###Select whether to look at outliers that are 'Mild' Outliers 1.5*IQR or 'Extreme' Outlier 3*IQR
    if(outlier_type == "M"){
      upper_range <- upper_quartile+(cut_off*1.5)
      lower_range <- lower_quartile-(cut_off*1.5)
    }else if(outlier_type == "E"){
      upper_range <- upper_quartile+(cut_off*3)
      lower_range <- lower_quartile-(cut_off*3)
    }
    ###Print the IQR upper and lower range adn the overall rane of the IQR and show which column it is from
    print(paste0("The IQR for column ",i," is from: ",upper_range," : ",lower_range," and the overall IQR range is: ",upper_range-lower_range))
    ###Replace the data that is above or below the IQR and label it as an "Outlier"
    data[[i]][data[[i]]>=upper_range|data[[i]]<=lower_range] <- -1

    ###Add data to the empty data_list list
    data_list[[i]] <- data[i]

  }

  ###Bind all of the data together
  big_data <- do.call(cbind,data_list)

  ###Sum all of the Outliers present within the data
  total_outliers<- length(which(big_data=='-1'))
  print(paste0("You have a total of ",total_outliers," Outliers in your dataset"))

  ###Format the table and return it using the formattable package

  final_table<- formattable(original, list(area(col = c(1:length(original))) ~ formatter('span', style = original ~ style(color= ifelse(original == big_data,'green','red')))))

  return(final_table)
}


