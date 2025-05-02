# install.packages("devtools")
# library(devtools)
# devtools::install_github('thdiakon/ccaR')

library(readxl)
library(ccaR)

cm <- read_xlsx(
  "../data/data.xlsx",
  sheet = "citation_matrix")

cca_results_all <- cca_table(cm)

cca_results_overall <- cca(cm)

cca_heatmap(
  cm,
  fontsize=0,
  fontsize_diag=4,
  chroma = "#4b8ac4")
# save pdf as 12x12 inches
