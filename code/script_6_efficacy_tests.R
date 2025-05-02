# load packages -----------------------------------------------------------
library(readxl)

# load data ---------------------------------------------------------------

# Read 'sleep_quality' sheet and set first column as row names
table_sleep_quality <- read_excel("../results/efficacy_tables.xlsx", sheet = "sleep_quality")
table_sleep_quality <- as.data.frame(table_sleep_quality)
rownames(table_sleep_quality) <- table_sleep_quality[[1]]
table_sleep_quality[[1]] <- NULL

# Read 'dose' sheet and set first column as row names
table_dose <- read_excel("../results/efficacy_tables.xlsx", sheet = "dose")
table_dose <- as.data.frame(table_dose)
rownames(table_dose) <- table_dose[[1]]
table_dose[[1]] <- NULL

# Read 'age' sheet and set first column as row names
table_age <- read_excel("../results/efficacy_tables.xlsx", sheet = "age")
table_age <- as.data.frame(table_age)
rownames(table_age) <- table_age[[1]]
table_age[[1]] <- NULL

# Read 'condition' sheet and set first column as row names
table_condition <- read_excel("../results/efficacy_tables.xlsx", sheet = "condition")
table_condition <- as.data.frame(table_condition)
rownames(table_condition) <- table_condition[[1]]
table_condition[[1]] <- NULL

# Sleep quality -----------------------------------------------------------

# Global Fisher’s Exact Test
fisher_res_sleep_quality <- fisher.test(table_sleep_quality)

# Pairwise Fisher’s Exact Tests
fisher_res_sleep_quality_quantity_vs_initiation <- fisher.test(table_sleep_quality[, c("quantity", "initiation")])
fisher_res_sleep_quality_quantity_vs_maintenance <- fisher.test(table_sleep_quality[, c("quantity", "maintenance")])
fisher_res_sleep_quality_initiation_vs_maintenance <- fisher.test(table_sleep_quality[, c("initiation", "maintenance")])

# Dose --------------------------------------------------------------------

# Global Fisher’s Exact Test
fisher_res_dose <- fisher.test(table_dose)

# Pairwise Fisher’s Exact Tests
fisher_res_dose_low_vs_medium <- fisher.test(table_dose[, c("low", "medium")])
fisher_res_dose_low_vs_high <- fisher.test(table_dose[, c("low", "high")])
fisher_res_dose_medium_vs_high <- fisher.test(table_dose[, c("medium", "high")])

# Age ---------------------------------------------------------------------

# Global Fisher’s Exact Test
fisher_res_age <- fisher.test(table_age)

# Pairwise Fisher’s Exact Tests
fisher_res_age_children_vs_adults <- fisher.test(table_age[, c("children", "adults")])
fisher_res_age_children_vs_elderly <- fisher.test(table_age[, c("children", "elderly")])
fisher_res_age_adults_vs_elderly <- fisher.test(table_age[, c("adults", "elderly")])

# Condition ---------------------------------------------------------------

# Global Fisher’s Exact Test
fisher_res_condition <- fisher.test(table_condition)

# Pairwise Fisher’s Exact Tests
fisher_res_condition_neurodev_vs_primary <- fisher.test(table_condition[, c("neurodev", "primary")])
fisher_res_condition_neurodev_vs_dementia <- fisher.test(table_condition[, c("neurodev", "dementia")])
fisher_res_condition_primary_vs_dementia <- fisher.test(table_condition[, c("primary", "dementia")])

# print global test results -----------------------------------------------

# These four results will print to the R console
fisher_res_sleep_quality
fisher_res_dose
fisher_res_age
fisher_res_condition
