library(shiny)
library(psych)
library(sm)
library(effsize)
library(car)
library(reshape)
library(ggplot2)

shinyServer(function(input, output) {
  values <- reactiveValues()
  observe({
    values$A <- rnorm(input$n, mean = input$mean1, sd = input$sd1)
    values$B <- rnorm(input$n, mean = input$mean2, sd = input$sd2)
    values$dat <- data.frame(values$A,values$B)
    values$dat.long <-melt(values$dat)
    values$levT <- leveneTest(values$dat.long$value, values$dat.long$variable)
  })
  output$describe1 <- renderTable({
    describe(values$A)
  })
  output$describe2 <- renderTable({
    describe(values$B)
  })
  output$leveneTest <- renderTable({
    values$levT
  })
  output$tTest <- renderTable({
    if (values$levT[[3]] > .05) { 
      t <- t.test(values$A, values$B, var.equal = TRUE)
      d <- cohen.d(values$A, values$B)
    }
    else{
      t <- t.test(values$A, values$B)
      d <- cohen.d(values$A, values$B, pooled=F)
    }
    data.frame(t=t[[1]], df=t[[2]], p=t[[3]], d=d[[3]])
  })
  output$plot <- renderPlot({
    ggplot(values$dat.long, aes(x=value, fill=variable)) + 
      geom_density(alpha=.5)
  })
  output$plot2 <- renderPlot({
    dat.summary <- summarySE(values$dat.long, measurevar="value", groupvars="variable")
    ggplot(dat.summary, aes(x=variable, y=value, fill = variable)) + 
      geom_bar(stat="identity") +
      geom_errorbar(aes(ymin=value-se, ymax=value+se),
                    width=.2)
    
  })
})
