# routlier_mad
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
#' @keywords routlier_mad
#' @return Returns an outlier dataset from the original dataset in a DT table
#' @name routlier_mad
#' @title routlier_mad
#' @import dplyr
#' @import DT
#' @import formattable
#' @usage routlier_mad(data)
#' @examples
#'
#'
#'   routlier_mad(data = iris,MAD = 2)
#'
#' @export

routlier_mad <- function(data,MAD){

  ###Subset all of the data that is numeric
  original <- data[,sapply(data,is.numeric)]
  data <- data[,sapply(data,is.numeric)]

  # ###Which 'type' of statistical test to use in the quantile function
  MAD <- MAD
  ###Initialize an empty data_list
  data_list <- list()

  for (i in seq_along(data)){
    ###Calculates the median from the column of data
    median<- median(data[[i]])
    ###Calculates the MAD or median absolute deviation from the column of data
    mad<- mad(data[[i]])
    ###Select whether to look at outliers that are 'Mild' Outliers MAD +-2 or 'Extreme' MAD +-3
    if(MAD == 2){
      upper_range <- median+mad*2
      lower_range <- median-mad*2
    }else if(MAD == 3){
      upper_range <- median+mad*3
      lower_range <- median-mad*3
    }
    ###Print the IQR upper and lower range adn the overall rane of the IQR and show which column it is from
    print(paste0("The MAD for column ",i," is from: ",upper_range," : ",lower_range," and the overall MAD range is: ",upper_range-lower_range))
    ###Replace the data that is above or below the IQR and label it as an "Outlier"
    if(mad == 0){
      data[[i]][data[[i]]] <- 0
      data_list[[i]] <- data[i]
    }else if(mad == 1){
      data[[i]][data[[i]]] <- 1
      data_list[[i]] <- data[i]
    }else{
    data[[i]][data[[i]]>upper_range|data[[i]]<lower_range] <- -1}

    ###Add data to the empty data_list list
    data_list[[i]] <- data[i]

  }

  ###Bind all of the data together
  big_data <- do.call(cbind,data_list)

  ###Sum all of the Outliers present within the data
  total_outliers<- length(which(big_data=='-1'))
  print(paste0("You have a total of ",total_outliers," Outliers in your dataset"))
  #
  # ###Format the table and return it using the formattable package
  #
  final_table<- formattable(original, list(area(col = c(1:length(original))) ~ formatter('span', style = original ~ style(color= ifelse(original == big_data,'green','red')))))

  return(final_table)
}


routlier_mad(data = mtcars,MAD = 3)



data <- mtcars
for (i in seq_along(data)){
  ###Calculates the upper_quartile range of the data
  # upper_quartile<- quantile(data[[i]],probs = 0.75,type = type)
  median<- median(data[[i]])
  print(paste0("Median: ",median))
  ###Calculates the lower_quartile range of the data
  # lower_quartile <- quantile(data[[i]],probs = 0.25,type = type)
  mad<- mad(data[[i]])
  print(paste0("MAD: ",mad))
}
