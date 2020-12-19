#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(routlier)
library(formattable)
library(DT)
library(rhandsontable)
library(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("Outlier Detection"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
        fileInput(inputId = "file1",label = "File Upload:",accept = c("xlsx","csv","txt")),
        hr(),
        wellPanel(
          wellPanel(
            helpText("This method utilizes the SD or Z-score method to detect Outliers"),
          sliderInput(inputId = 'sd',label = "Number of Standard Deviations",value = 2,min = 1,max = 3,step = 1,ticks = T)),
          hr(),
          wellPanel(
            helpText("This method utilizes the Tukey method for Outliers"),
          radioButtons(inputId = 'mad',label = "MAD Value: ",choices = c(2,3),selected = 2,inline = T)
        ))


      ),

      # Show a plot of the generated distribution
      mainPanel(
        # DT::DTOutput("table_one")
        formattableOutput("table_one")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  file_one<- eventReactive(input$file1,{
  inFile <- input$file1

  if (is.null(inFile))
    return(NULL)

  read.csv(inFile$datapath)

  })


  output$table_one<- renderFormattable({

    # file_one<- routlier::routlier_simple(data = file_one(),sd = 2)

    # file_one <- routlier::routlier_formattable(data = file_one(),sd = input$sd)

    file_one <- routlier::routlier_mad(data = file_one(),MAD = input$mad)

    formattable(file_one)

  })

}

# Run the application
shinyApp(ui = ui, server = server)

