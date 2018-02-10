#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to output a data table for user selected genres
shinyServer(function(input, output) {
   
            # Create data table
            output$moviegenres <- DT::renderDataTable({
                  req(input$genre)
                  selected_genres <- movies %>%
                        filter(genre %in% input$genre) %>%
                        select(title:mpaa_rating)
                  DT::datatable(data = selected_genres,
                                options = list(pageLength = 10),
                                rownames = FALSE)
            })
            
            # Create scatterplot object the plotOutput function is expecting
            output$scatterplot <- renderPlot({
                  ggplot(data = movies, aes_string(x = input$x, y = input$y, color = input$z)) +
                        geom_point()
            })
})
