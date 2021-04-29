library(shiny)

shinyUI(fluidPage(

    titlePanel("Sample Size Derivation for Prognostic Biomarker 'AB' of Preterm Delivery (PD)"),

    sidebarLayout(
    	
        sidebarPanel(
        	sliderInput("overall_rate", "Overall PD rate:", min = 0.01, max = 0.30, step = .01, value = .1),
        	sliderInput("prevalence", "AB+ prevalence:", min = 0.01, max = .99, step = .01, value = 1/3),
        	sliderInput("risk_difference", "Risk difference AB+ - AB-:", min = 0.01, max = .15, step = .005, value = .04),
        	sliderInput("rho", "Age/AB+ correlation:", min = 0.00, max = .99, step = .01, value = .1),
        	sliderInput("alpha", "Type-I error rate:", min = 0.01, max = .2, step = .01, value = .05),
        	sliderInput("beta", "Type-II error rate: ", min = 0.01, max = .2, step = .01, value = .1),
        	sliderInput("dropout", "dropout rate", min = 0.00, max = .99, step = .01, value = .07),
            sliderInput("n", "Sample size:", min = 10, max = 10000, step = 50, value = 3000)
        ),

        mainPanel(
            plotOutput("plt_sample_size"),
            plotOutput("plt_power")
        )
    )
))
