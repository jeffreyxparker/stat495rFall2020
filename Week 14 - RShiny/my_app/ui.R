#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Week 14 - Example Shiny App"),
    hr(),
    h3("This dashboard can be used to view the relationship between diamond size and price.", align = "center", style = "color:red"),
    br(),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("sample",
                        "Number of diamonds:",
                        min = 1000,
                        max = 54000,
                        value = 5000,
                        step = 1000),
            sliderInput("alpha",
                        "Transparency of the points:",
                        min = 0,
                        max = 1,
                        value = 0.3),
            checkboxInput("title_input",
                          "Include a title?"),
            numericInput("xmin",
                         "X Min",
                         value = 0),
            numericInput("xmax",
                         "X Max",
                         value = 3.5),
            numericInput("ymin",
                         "Y Min",
                         value = 0),
            numericInput("ymax",
                         "Y Max",
                         value = 20000)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("diamond_plot"),
            img(src = "romulan-chart.jpg"),
            textOutput("parcels")
        )
    )
))
