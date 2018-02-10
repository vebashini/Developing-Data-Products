#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

load("./movies.Rdata")

all_genres <- sort(unique(movies$genre))

# Define UI for application that has an input text box where a user may
# choose multiple genres
shinyUI(fluidPage(
            sidebarLayout(

                  # Input(s)
                  sidebarPanel(
                        # Drop down item - Select variable for y-axis
                        selectInput(inputId = "y", 
                                    label = "Y-axis:",
                                    # choices for user
                                    choices = c("imdb_rating", "imdb_num_votes", "critics_score", "audience_score", "runtime"), 
                                    # default selection
                                    selected = "imdb_rating"),
                        
                        # Drop down item - Select variable for x-axis
                        selectInput(inputId = "x", 
                                    label = "X-axis:",
                                    choices = c("imdb_rating", "imdb_num_votes", "critics_score", "audience_score", "runtime"), 
                                    selected = "imdb_num_votes"), 
                        
                        # Select variable for color
                        selectInput(inputId = "z", 
                                    label = "Color by:",
                                    choices = c("title_type", "genre", "mpaa_rating", "critics_rating", "audience_rating"),
                                    selected = "mpaa_rating"),
                        
                        selectInput(inputId = "genre",
                                    label = "Select Genre:",
                                    choices = all_genres,
                                    selected = "Drama",
                                    multiple = T)
                        

                  ),
                  

                  # Output(s)
                  mainPanel(
                        plotOutput(outputId = "scatterplot"),
                        DT::dataTableOutput(outputId = "moviegenres")
                        
                  )
            )
))
