#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")
library("formattable")

df1 <- data.frame(A = 1:5, B = 6:10, C = 11:15)
df2 <- data.frame(A = c(1:3,7,5), B = c(11, 7:10), C = 16:20)

ui <- fluidPage(
  div(h3("Table Formatting"), align = "center"),
  div(formattableOutput("table1"),align = "center"),
  div(formattableOutput("table2"), align = "center")
)

server <- function(input, output) {


    output$table2 <- renderFormattable({
    formattable(df2, list(area(col = c(1:length(df2))) ~ formatter('span', style = x ~ style(color= ifelse(x == df1,'blue', ifelse(!x == df1, 'pink', NA))))))


  })

  output$table1 <- renderFormattable({formattable(df1)})
}


# Run the application
shinyApp(ui = ui, server = server)


