#
# This is the server logic of a Shiny web application regarding
# coursera Developing Data Products: Course Project: Shiny Application.
# Database: New York Air Quality Measurements
# Variables: Ozone Solar.R Wind Temp Month Day
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a regression
shinyServer(function(input, output, session) {

        # cleaning from NA values
        airq <- reactive({na.omit(airquality[order(airquality$Month), ])})

        output$regPlot <- renderPlot({

                mydata <- airq()
                mu <- input$mu

                if (input$color) {
                        p <- ggplot(mydata, aes(x=Solar.R, y=Ozone, color=Month)) +
                                geom_point(shape=1) +
                                geom_smooth(method=lm)
                } else {
                        p <- ggplot(mydata, aes(x=Solar.R, y=Ozone)) +
                                geom_point(shape=1) +
                                geom_smooth(method=lm)
                }

                print(p)

                mse <- mean((mydata$Ozone - mu)^2)
                output$text1 <- renderPrint(summary(mydata[,1:4]))
                output$text2 <- renderText(mu)
                output$text3 <- renderText(mse)
        })

})
