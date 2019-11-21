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
  # div(formattableOutput("table1"),align = "center"),
  div(formattableOutput("table2"), align = "center")
)

server <- function(input, output) {
  # output$table2 <- renderFormattable({formattable(df2, list(A = formatter("span", style = x ~ style(color= ifelse(x == df1$A,"green", ifelse(!x == df1$A, "red", NA))))))})

  output$table2 <- renderFormattable({
    # the following string argument can be created by a for-loop
    eval(parse(text = "formattable(df2, list(A = formatter('span', style = x ~ style(color= ifelse(x == df1$A,'green', ifelse(!x == df1$A, 'red', NA)))),
                                                 B = formatter('span', style = x ~ style(color= ifelse(x == df1$B,'green', ifelse(!x == df1$B, 'red', NA)))),
                                                 C = formatter('span', style = x ~ style(color= ifelse(x == df1$C,'green', ifelse(!x == df1$C, 'red', NA))))))"))

  })

  output$table1 <- renderFormattable({formattable(df1)})
}


# Run the application
shinyApp(ui = ui, server = server)

