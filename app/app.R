library(shiny)
library(tidyverse)
library(shinythemes)



ui = fluidPage(
  theme = shinytheme("slate"),
  titlePanel("Mažmeninė prekyba nespecializuotose
              parduotuvėse, kuriose vyrauja maistas,
              gėrimai ir tabakas"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput("Input",
                     "Select company",
                     choices=NULL)
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)


server = function(input, output, session){
  
  data = read.csv("../data/471100.csv")

    
  colnames(data) = c("Nr.","code", "jarCode",
                     "name", "municipality", "ecoActCode",
                     "ecoActName", "month", "avgWage",
                     "numInsured", "avgWage2", "numInsured2", "tax")
   
  data = data[!is.na(data$avgWage),]
  
  updateSelectizeInput(session, "Input", choices=data$name, server=TRUE)
  
  output$plot = renderPlot(
    data %>%
      filter(name == input$Input) %>%
      ggplot(aes(x = ym(month), y = avgWage)) +
      geom_line(color = "darkorange") +
      theme_classic()
  ) 
  
}

shinyApp(ui, server)
