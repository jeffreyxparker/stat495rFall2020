#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

parcel_data <- read_csv("cleaned_parcels.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$diamond_plot <- renderPlot({

        diamonds %>%
            sample_n(input$sample) %>%
            ggplot() +
            geom_point(aes(y = price, x = carat, color = color), alpha = input$alpha) + 
            labs(title = ifelse(input$title_input, "Price of Diamonds by Carat", "")) + 
            xlim(input$xmin, input$xmax) + 
            ylim(input$ymin, input$ymax)

    })
    
    output$parcels <- renderPrint({
        
        summary(parcel_data)
        
    })

})
