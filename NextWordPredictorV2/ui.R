
library(shiny)

# Define UI for application that predict next word in a text
shinyUI(fluidPage(
    

    
    # Text Input Field
    textInput("text", label = h2("Next Word Predictor"), value = "Enter your text here"),
    actionButton("do", "Predict next word..."),
    hr(),
    
    
    # Output Field
    fluidRow((verbatimTextOutput("value"))),
    
    tabPanel("Help/Explanation",
        h2("Help"),
        p("Enter a series of words in the search box to predict the next word"),
        p("The sign 'i' in the result line means that you did not enter enough 
          data (did not enter any data at all) for the system to process the request correctly."),
        p("The '<EOS>' sign in the result line means that the line continuation 
          (according to the analyzed data) should be a punctuation mark, not a word."),
        h2("Explanation"),
        p("Using a sample of text from blogs, twitter feeds, 
                  and news, this takes in the next page and predicts the next word.  
                  This sample is taken from SwiftKey.  And since computational power 
                  is limited, only 10% of the sample is used."),
        p("Prediction is done through looking at 5-grams, 
                  using 'back off' algoritm to determine the order.")
    )
))
