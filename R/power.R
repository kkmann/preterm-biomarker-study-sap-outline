power <- function(
	risk_difference, # biomarker pos - biomarker neg
	n,
	prevalence_biomarker = .33,
	overall_event_rate = .1,
	alpha = 0.05
) {
	P <- overall_event_rate
	B <- prevalence_biomarker
	P2 <- P + (1 - B)*risk_difference
	P1 <- P - B*risk_difference
	pwr::pwr.2p2n.test(h = pwr::ES.h(P2, P1), n1 = n*B, n2 = n*(1 - B))
}