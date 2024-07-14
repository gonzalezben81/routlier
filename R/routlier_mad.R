#' @title Returns an outlier data frame in a DT table utilizing the mean absolute deviation (MAD) method
#'
#' @description
#' The Outlier(s) wil be highlighted red in the table and the other values will be highlighted greeen.
#'
#' \if{html}{\figure{routlier_mad.png}{options: width=100\% alt="R logo"}}
#' \if{latex}{\figure{routlier_mad.png}{options: width=0.5in}}
#'
#' There is also a printout of the data and the columns giving the upper and lower MAD and the overall range of the MAD.
#'
#'
#' \if{html}{\figure{routlier_mad_two.png}{options: width=100\% alt="R logo"}}
#' \if{latex}{\figure{routlier_mad_two.png}{options: width=0.5in}}
#'
#' @param data filepath to data.
#' @param MAD number of MAD standard deviations.
#' @keywords routlier_mad
#' @return Returns a numeric dataset from the original dataset and the outliers are highlighted in red.The outlier table and the
#' number of outliers are returned as a list object.
#' @name routlier_mad
#' @title routlier_mad
#' @import dplyr
#' @import DT
#' @import formattable
#' @usage routlier_mad(data,MAD)
#' @examples
#'
#'
#'   data<- routlier_mad(data = mtcars,MAD = 2)
#'
#'   print(data$outliers)
#'
#'
#' @export

routlier_mad <- function(data,MAD){

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

  final_outliers <- list("outliers"=total_outliers,"outlier_table"=final_table)

  return(final_outliers)
}





