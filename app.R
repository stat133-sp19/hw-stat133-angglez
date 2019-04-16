#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(reshape2)

ui <- fluidPage(

    titlePanel("Investment Options"),

    fluidRow(
        column(4, 
            sliderInput("initial", "Initial Amount",min = 0,max = 100000,value = 1000,step = 500, pre='$'),
            sliderInput("contrib","Annual Contribution",min = 0,max = 50000,value = 2000,step = 500, pre='$')
            ),
        column(4, 
            sliderInput("return","Return Rate (in %)",min = 0,max = 20,value = 5,step = 0.1),
            sliderInput("growth","Growth Rate (in %)",min = 0,max = 20,value = 2,step = 0.1)
            ),
        column(4,
            sliderInput("years","Years",min = 0,max = 50,value = 20,step = 1),
            selectInput("facet","Facet?", c("No","Yes"))
            )
        ),
    
    fluidRow(
        plotOutput("timeline")
    ),
    
    fluidRow(
        verbatimTextOutput("balance"))
        
    )
    



server <- function(input, output) {
    mydata <- reactive({
        
        y <- input$years
        a <- input$initial
        c <- input$contrib
        r <- input$return / 100
        g <- input$growth / 100
        
        fv <- function(x) a*(1+r)^x
        ann <- function(x) c*((1+r)^x-1)/r
        grow <- function(x) c*((1+r)^x-(1+g)^x)/(r-g)
        
        grow_c <- fix_c <- no_c <- rep(0, 11)
        
        for (y in 0:10) {
            no_c[y+1] <- fv(y)
            fix_c[y+1] <- no_c[y+1] + ann(y)
            grow_c[y+1] <- no_c[y+1] + grow(y)
        }
        
        aa <- data.frame(
            "year" = 0:10,
            "no_contrib" = no_c,
            "fixed_contrib" = fix_c,
            "growing_contrib" = grow_c
        )
        aa
        
    })

    output$balance <- 
        renderPrint({
            mydata()
    })

    output$timeline <- 
        renderPlot({
            modes <- melt(mydata(), id.vars='year', variable.name='mode')
            if (input$facet == "No") {
                ggplot(data=modes, aes(x=year, y=value)) + geom_line(aes(color=mode)) + ggtitle('Three Modes of Investing') + labs(x="Time (years)", y="Balance (dollars)", color="Investment Mode") + theme_minimal()
            } 
            else {
                ggplot(data=modes, aes(x=year, y=value)) + geom_line(aes(color=mode)) + geom_area(aes(fill=mode, alpha=0.5), show.legend=FALSE) + ggtitle('Three Modes of Investing') + labs(x="Time (years)", y="Balance (dollars)", color="Investment Mode") + theme_minimal() + facet_wrap(~mode)
            }
            
    })
}
            

# Run the application 
shinyApp(ui = ui, server = server)
