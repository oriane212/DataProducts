# server.R

library(shiny)
library(ggplot2)
data <- read.csv("tgStudy_id1_part1.csv")

times <- aggregate(Time ~ TG + TGtype + InfoType, data, mean)
scores <- aggregate(Answer ~ TG + TGtype + InfoType, data, mean)
scores[,5] <- times[,4]
names(scores) <- c("TG", "TGtype", "InfoType", "Accuracy(%)", "AvgTime(sec)")

shinyServer(function(input, output) {
        
        output$tgPlot <- renderPlot({
                
                qplot(TG, scores[,input$y_var], data=scores, fill=scores[,input$color_var], geom="bar", width=.5, stat="identity", ylab=input$y_var, xlab="Tactile Graphic", main="Participant 1") + geom_bar() + labs(fill = "Legend") +
                        theme(text = element_text(size=15),
                              axis.text.x = element_text(angle=90, vjust=.5))
        })
})

