# the code paced here will be executed only one time at the beginning
library(shiny)
library(caret);
data(faithful); 
set.seed(333)
inTrain <<- createDataPartition(y=faithful$waiting, p=0.75, list=FALSE)
trainFaith <<- faithful[inTrain,]; 
testFaith <- faithful[-inTrain,]
# we use the variable n to control the update of prediction process
# n and input$predictButton both start at the value 0
# then we save curent value of input$predictButton into n and if there are any update of the input values
# we do not predict a new value until the user click on the predict button
n <<- 0
lm1 <<- lm(eruptions ~ waiting, data=trainFaith)

# implement the server
shinyServer(
   function(input, output) {
      # create the a plot output wich contain a simple plot of the data and the calculated regression line
      output$lmplot <- renderPlot({
         plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue", xlab="Waiting", ylab="Duration")
         lines(trainFaith$waiting, lm1$fitted, col = input$color, lwd = as.numeric(input$lwidth))          
      })
     # create output item to save the predicted value
      output$predVal <- renderText({
         if (input$predictButton > n) { # here the button predictButton was clicked, so predict a new duration value
            
            # save the number of time the button clicked for controling the prediction process
            n <<- input$predictButton
            
            # calculate the predicted value corresponding to the waiting value entred in input$waiting
            pv <- predict(lm1,data.frame(waiting=as.numeric(input$waiting)))
            
            # test if the predicted value is realistic and generate the prediction result
            if (pv < 0) 
               paste("The predicted duration of ", input$waiting, " is ", pv, 
                             ". Sorry an unrealistic negative value was predicted")
            else 
               paste("The predicted duration of ", input$waiting, " is ", pv)
         }
         else
            "Enter a waiting value then click the Predict button"
      })

     # create an output to indicate the number of predicted values or the number of times predictButton was clicked
      output$clickedNb <- renderText({paste("Number of values predicted is: ", input$predictButton)})
   })
