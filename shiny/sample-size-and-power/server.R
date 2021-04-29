library(shiny)
library(tidyverse)
source("../../R/sample_size.R")
source("../../R/power.R")

shinyServer(function(input, output) {

    output$plt_sample_size <- renderPlot({
        tbl_n <- tibble(
				delta = seq(0, .1, length.out = 100),
				`no dropout or VIF` = map_dbl(
						delta, 
						~sample_size(., 
							prevalence_biomarker = input$prevalence,
							overall_event_rate = input$overall_rate,
							alpha = input$alpha,
							beta = input$beta
						)
					),
				`no dropout` = `no dropout or VIF` / (1 - input$rho^2),
				`dropout and VIF` = `no dropout` * (1 + input$dropout)
			) %>% 
			pivot_longer(
				-delta,
				names_to = "type",
				values_to = "required sample size"
			)
        n_required <- ceiling(sample_size(
			risk_difference = input$risk_difference,
			prevalence_biomarker = input$prevalence,
			overall_event_rate = input$overall_rate,
			alpha = input$alpha,
			beta = input$beta
		) / (1 - input$rho^2) * (1 + input$dropout) )
		tbl_n %>% 
			filter(
				`required sample size` <= 10000
			) %>% 
			ggplot() +
				aes(delta, `required sample size`, color = type) +
				geom_line() +
				geom_vline(xintercept = input$risk_difference) +
				geom_hline(yintercept = n_required) +
				geom_label(
					aes(label = label), color = "black", nudge_x = .001, nudge_y = 100, hjust = 0, vjust = 0,
					data = tibble(
						label = sprintf("n = %i", n_required), 
						delta = input$risk_difference, 
						`required sample size` = n_required
					)
				) +
				scale_y_continuous(limits = c(0, 10000), breaks = seq(0, 10000, by = 1000), expand = c(0, 0)) +
				scale_x_continuous("risk difference AB+ - AB-",limits = c(0, .1), breaks = seq(0, 1, by = .01), expand = c(0, 0)) +
				scale_color_discrete("") +
				labs(title = "Required Sample Size vs. Effect Strength") +
				theme_bw(16) +
				theme(
					legend.position = "top",
					plot.margin = unit(c(1,1,1,1), "lines")
				)

    })
    
    output$plt_power <- renderPlot({
    	
        n_real <- input$n * (1 - input$rho^2) / (1 + input$dropout)
    	
        tbl_power <- tibble(
				delta = seq(0, .1, length.out = 100),
				power = map_dbl(
						delta, 
						~power(., n_real,
							prevalence_biomarker = input$prevalence,
							overall_event_rate = input$overall_rate,
							alpha = input$alpha
						)$power
					)
			)
        power_achieved <- power(input$risk_difference, n_real,
				prevalence_biomarker = input$prevalence,
				overall_event_rate = input$overall_rate,
				alpha = input$alpha
			)$power
		tbl_power %>% 
			ggplot() +
				aes(delta, power) +
				geom_line() +
				geom_vline(xintercept = input$risk_difference) +
				geom_hline(yintercept = power_achieved) +
				geom_label(
					aes(label = label), color = "black", nudge_x = .001, nudge_y = .01, hjust = 0, vjust = 0,
					data = tibble(
						label = sprintf("power = %.2f", power_achieved), 
						delta = input$risk_difference, 
						power = power_achieved
					)
				) +
				scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = .1), expand = c(0, 0)) +
				scale_x_continuous("risk difference AB+ - AB-", limits = c(0, .1), breaks = seq(0, 1, by = .01), expand = c(0, 0)) +
				scale_color_discrete("") +
				labs(title = "Power vs. Effect Strength") +
				theme_bw(16) +
				theme(
					legend.position = "top",
					plot.margin = unit(c(1,1,1,1), "lines")
				)

    })

})
