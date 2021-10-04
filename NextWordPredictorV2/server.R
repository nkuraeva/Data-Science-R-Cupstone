
library(shiny)
library(sbo)
#  Loading prepared Coprus Data
x <- readRDS('~/workspace/RStudio/Data-Science-R-Cupstone/Ct.rds')
# Function to perform prediction
p <- sbo_predictor(x)



# Define server logic required to predict next word
shinyServer(function(input, output) {
    
    observeEvent(input$do, {
    
        output$value <- renderText({

            predict(p, input$text)
        
        })
    })

})
