# Load necessary libraries
library(tidyverse)
library(openxlsx)

# Load data
data <- readxl::read_excel("Data/BEACHxRAS.xlsx", sheet = "Sheet1") %>% as_tibble()

# Select relevant columns
BEACH_columns <- c("LRBA_MC", "LYST_MC", "NBEA_MC", "NBEAL1_MC", "NBEAL2_MC", "NSMAF_MC", "WDFY3_MC", "WDFY4_MC", "WDR81_MC")
RAS_data <- data %>% select(RAS, all_of(BEACH_columns)) %>% drop_na()

# Perform pairwise comparisons
comparison_results <- list()
for (group1 in BEACH_columns) {
  for (group2 in BEACH_columns) {
    if (group1 != group2) {
      shared_interactors <- RAS_data %>%
        filter(.data[[group1]] >= 0.75 & .data[[group2]] >= 0.75) %>%
        pull(RAS)
      comparison_results[[paste(group1, "vs", group2, sep = "_")]] <- shared_interactors
    }
  }
}

# Save comparison matrix
comparison_matrix <- expand_grid(Group1 = BEACH_columns, Group2 = BEACH_columns) %>%
  rowwise() %>%
  mutate(
    Shared_Count = if (Group1 != Group2) {
      length(comparison_results[[paste(Group1, "vs", Group2, sep = "_")]])
    } else {
      NA
    }
  ) %>%
  pivot_wider(
    names_from = Group2,
    values_from = Shared_Count,
    values_fill = 0
  )
write.csv(comparison_matrix, "comparison_matrix_summary.csv", row.names = FALSE)

# Save pairwise interactions to Excel
wb <- createWorkbook()
for (comparison in names(comparison_results)) {
  df <- data.frame(`Shared Interactors` = comparison_results[[comparison]])
  addWorksheet(wb, comparison)
  writeData(wb, comparison, df)
}
saveWorkbook(wb, "shared_interactions_comparison.xlsx", overwrite = TRUE)
