# ui.R

library(shiny)
require(devtools)
data <- read.csv("tgStudy_id1_part1.csv")

times <- aggregate(Time ~ TG + TGtype + InfoType, data, mean)
scores <- aggregate(Answer ~ TG + TGtype + InfoType, data, mean)
scores[,5] <- times[,4]
names(scores) <- c("TG", "TGtype", "InfoType", "Accuracy(%)", "AvgTime(sec)")

shinyUI(
        fluidPage(    
                titlePanel("Tactile Graphic Study"),
                
                sidebarLayout(      
                        
                        sidebarPanel(
                                helpText("Accuracy and completion times for blind participant using 'layered' raised-line drawings and printed 'textured' graphics representing either 2D information or 3D shapes."),
                                hr(),
                                selectInput("y_var", "Y Variable:", 
                                            choices=colnames(scores[,4:5])),
                                selectInput("color_var", "Legend:",
                                            choices=colnames(scores[,2:3]))
                        ),

                        mainPanel(
                                plotOutput("tgPlot"),
                                h3("Documentation"),
                                helpText("The Tactile Graphic Study data include accuracy and completion times for a blind participant performing tasks using the 'layered' raised-line drawing and the standard printed 'textured' graphic."),
                                
                                helpText("Use the first pull down menu to adjust the y variable in the plot in order to view either Accuracy rates or Average completion times for each of the 12 tactile graphics."),
                                
                                helpText("Use the second pull down menu to adjust the legend and compare the data either by Tactile Graphic Type (Textured vs. Layered) or Information Type (graphics representing 2D information vs. graphics representing 3D shapes).")
                        )
                        
                )
        )
)
