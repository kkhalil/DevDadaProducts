library(markdown)

shinyUI(navbarPage("Simple Regression Example!",
                   tabPanel("Prediction",
                            sidebarLayout(
                               sidebarPanel(
                                  numericInput('lwidth', 'Regression Line width', 5, min = 1, max = 7, step = 1),
                                  radioButtons("color", "Regression line Color", c("Red" = "red", "Cyan" = "cyan", "Magenta" = "magenta")),
                                  textInput('waiting', 'Enter a waiting value to predict its duration'),
                                  actionButton('predictButton', 'Predict') 
                               ),
                               mainPanel(
                                  h2('Linear Regression Model'),    
                                  plotOutput('lmplot'),
                                  h4('Predicted value is'),
                                  textOutput("predVal"),
                                  textOutput("clickedNb") 
                               )
                            )
                  ),
                  navbarMenu("More",
                             tabPanel("Instructions",
                                      includeMarkdown("instruction.Rmd") 
                             ),
                             tabPanel("About", 
                                      includeMarkdown("about.Rmd") 
                             )
                  )
)
)
