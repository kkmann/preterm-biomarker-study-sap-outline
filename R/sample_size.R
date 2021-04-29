sample_size <- function(
	risk_difference, # biomarker pos - biomarker neg
	prevalence_biomarker = .33,
	overall_event_rate = .1,
	alpha = 0.05,
	beta = 0.1
) {
	P <- overall_event_rate
	B <- prevalence_biomarker
	P2 <- P + (1 - B)*risk_difference
	P1 <- P - B*risk_difference
	n <- (
		qnorm(1 - alpha/2)*sqrt(P*(1 - P)/B) + 
		qnorm(1 - beta)*sqrt(P1*(1 - P1) + P2*(1 - P2)*(1 - B)/B)
	)^2 / (
		(P1 - P2)^2*(1 - B)
	)
	return(n)
}

# test pwr::pwr.2p2n.test(h = pwr::ES.h(.075, .125), n1 = 600, n2 = 1200)
