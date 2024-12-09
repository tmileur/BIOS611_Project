# Load necessary libraries
library(tidyverse)
library(ggplot2)

# Load data
data <- readxl::read_excel("Data/BEACHxRAS.xlsx", sheet = "Sheet1") %>% as_tibble()

# Create a directory to save the barplots
dir.create("RAS_BEACH_Barplots", showWarnings = FALSE)

# Generate barplots for each RAS Family
RAS_Family <- unique(data$`RAS Family`)
for (family in RAS_Family) {
  family_data <- data %>%
    filter(`RAS Family` == family) %>%
    select(RAS, LRBA_MC:WDR81_MC)
  
  for (column in names(family_data)[-1]) {
    barplot <- ggplot(family_data, aes(x = RAS, y = .data[[column]])) +
      geom_bar(stat = "identity") +
      labs(title = paste("Barplot for", family, "-", column)) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    ggsave(paste0("RAS_BEACH_Barplots/", family, "_", column, "_barplot.png"), barplot)
  }
}
