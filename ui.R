#
# This is the server logic of a Shiny web application regarding
# coursera Developing Data Products: Course Project: Shiny Application.
# Database: New York Air Quality Measurements
# Variables: Ozone Solar.R Wind Temp Month Day
#

library(shiny)

airq <- na.omit(airquality)

# Define UI for application
shinyUI(fluidPage(

  # Application title
  titlePanel("New York Air Quality Measurements using 'airquality' from 'datasets' R package"),

  p("This is the tool to help analyze correlation between Ozone and Solar.R.
        You can choose to show the coloured data by Month with a click on respective checkbox.
        The Regression Line will show the 95% confidence interval.
        Also you can choose differect value of the mean which will trigger
        to auto-calcuate the corresponding Mean Squared Error by playing around the scroll bar of
        Ozone at the mean."),

    # Sidebar with a slider input
  sidebarLayout(

    sidebarPanel(

            checkboxInput(inputId = 'color',
                          label = 'Color by Month'),

            sliderInput('mu', 'Scroll Ozone at the mean',
                        value = mean(airq$Ozone),
                        min = summary(airq$Ozone)[1],
                        max = summary(airq$Ozone)[6],
                        step = 1),

            h5("The source code (ui.R and server.R) is available here: ", a("GitHub", href="http://github.com/alexcipro/Developing-Data-Products")),
            h5("The documentation is available here: ", a("Rpubs", href="http://rpubs.com/")),
            p("Author: alexcipro")
    ),

    # Show the data
    mainPanel(
        h4("Summary of Airquality"),
        verbatimTextOutput("text1"),
        plotOutput("regPlot"),
        h4("Mean of Ozone"),
        verbatimTextOutput("text2"),
        h4("Mean Squared Error Calculated"),
        verbatimTextOutput("text3")
    )
  )
))
