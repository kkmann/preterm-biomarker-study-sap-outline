# Analysis Plan: A Prognostic Biomarker Study

This repository contains code to reproduce all computations for the outline of an
analysis plan for a hypothetical submission study with the aim of demonstrating 
that a biomarker "AB" is indeed prognostic of preterm deliveries in pregnant women.

This analysis plan is by no means complete and merely serves the purpose of 
highlighting key issues to consider and potential approaches.

The repository supports the [The Reproducible Execution Environment Specification](https://repo2docker.readthedocs.io/en/latest/specification.html) 
and can be explored interactively in the web browser without having to install or download any software.
This feature is powered by the free service [mybinder.org](https://mybinder.org/). 
Simply follow [this link]([https://mybinder.org/v2/gh/kkmann/preterm-biomarker-study-sap-outline/main?urlpath=rstudio) to open the repository in Rstudio in your browser.

The markdown sources of the presentation slides are in `/presentation-slides`.
If you want to rebuild the presentation slides, open `/presentation-slides/slides.Rmd` in Rstudio and click the "Knit" button.

A shiny app to interactively conduct the sample size calculation is available in
`/shiny` and can be accesses [here](https://mybinder.org/v2/gh/kkmann/preterm-biomarker-study-sap-outline/main?urlpath=shiny%2Fshiny%2Fsample-size-and-power%2F).

Please note that mybinder.org is a free service and startup times might take few seconds.