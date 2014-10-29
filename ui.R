
shinyUI(fluidPage(
  titlePanel("Independent t-test"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("n", label = h5("Sample Size"),
                  min = 3, max = 1000, value = 10),
      h3("Group A"),
      sliderInput("mean1", label = h5("Mean of Population"),
                  min = 0, max = 100, value = 10),
      sliderInput("sd1", label = h5("Standard Deviation of Population"),
                  min = 0, max = 10, value = 1, step=.1),
      h3("Group B"),
      sliderInput("mean2", label = h5("Mean of Population"),
                  min = 0, max = 100, value = 10),
      sliderInput("sd2", label = h5("Standard Deviation of Population"),
                  min = 0, max = 10, value = 1, step=.1)
      ),
    mainPanel(
      tabsetPanel(
        tabPanel("Descriptive Statistics",
                 h4("Group A"),
                 tableOutput("describe1"),
                 h4("Group B"),
                 tableOutput("describe2")),
        tabPanel("Analysis", 
                 h3("Levene's Test"),
                 tableOutput("leveneTest"),
                 h3("t Test"),
                 tableOutput("tTest")), 
        tabPanel("Plots", plotOutput("plot"),
                 plotOutput("plot2"))
      )
    )
  ))
)
