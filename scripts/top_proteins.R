# Load necessary libraries
library(tidyverse)
library(openxlsx)

# Load data
data <- readxl::read_excel("Data/BEACHxRAS.xlsx", sheet = "Sheet1") %>% as_tibble()

# Identify top RAB and ARF proteins
top_rab <- data %>%
  filter(`RAS Family` == "RAB") %>%
  arrange(desc(rowMeans(select(., LRBA_MC:WDR81_MC), na.rm = TRUE))) %>%
  slice(1:10)

top_arf <- data %>%
  filter(`RAS Family` == "ARF") %>%
  arrange(desc(rowMeans(select(., LRBA_MC:WDR81_MC), na.rm = TRUE))) %>%
  slice(1:10)

# Save to Excel
wb <- createWorkbook()
addWorksheet(wb, "Top_10_RAB")
writeData(wb, "Top_10_RAB", top_rab)
addWorksheet(wb, "Top_10_ARF")
writeData(wb, "Top_10_ARF", top_arf)
saveWorkbook(wb, "Top_10_RAB_ARF_Proteins.xlsx", overwrite = TRUE)
