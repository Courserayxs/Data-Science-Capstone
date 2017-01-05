
library('dplyr')
library('data.table')
library('RSQLite')
library('RWeka')
library('DBI')
library('Cairo')
library('RCurl')
library('shiny')


options(shiny.maxRequestSize=64*1024^2) 



source("./ngramPredictionFunctionSeven.R")




shinyServer(function(input, output, session) {
  
  db <- dbConnect(SQLite(), dbname="sub_train.db")
  
  dbout <- reactive({ngramPredictionFunctionSeven(input$phrase, db)})
  

observe({
    
    input$phrase  # input$text
    
    out <- dbout()
    
  words <- as.data.frame(out)[,1] 
        
  session$sendCustomMessage(type = "myCallbackHandler", words)     

   })
 
  
   
  output$extras <- renderUI({
    
             tags$style(type="text/css",
                   "footer { display: block; }",
                   "@media screen and (min-height: 700px) { footer { position: fixed; bottom: 0; height: auto; left: 0; right: 0; } }"
        )
      })
     
 
  
  
})
