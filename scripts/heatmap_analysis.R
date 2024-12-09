# Load necessary libraries
library(tidyverse)
library(pheatmap)

# Load data
data <- readxl::read_excel("Data/BEACHxRAS.xlsx", sheet = "Sheet1") %>% as_tibble()
RAS_Family <- unique(data$`RAS Family`)

# Get unique RAS Family members
ras_families <- unique(data$`RAS Family`)

# Create a directory to save the heatmaps
dir.create("RAS_Family_Heatmaps", showWarnings = FALSE)

# Create heatmaps for each RAS Family
for (family in RAS_Family) {
  family_data <- data %>%
    filter(`RAS Family` == family) %>%
    select(RAS, LRBA_MC:WDR81_MC) %>%
    drop_na()
  
  heatmap_matrix <- as.matrix(family_data[,-1])
  rownames(heatmap_matrix) <- family_data$RAS
  
  # Save heatmap
  png(paste0("RAS_Family_Heatmaps/", family, "_heatmap.png"), width = 2000, height = 1800, res = 300)
  pheatmap(heatmap_matrix, cluster_rows = TRUE, cluster_cols = TRUE)
  dev.off()
}

# RAB-specific heatmap
# Subset data for the RAB family
rab_data <- data %>%
  filter(`RAS Family` == "RAB") %>%
  as.data.frame()

# Use the "RAS" column as rownames for labeling
rownames(rab_data) <- rab_data$RAS

# Select only numeric columns for the heatmap matrix
rab_matrix <- as.matrix(rab_data %>% select(where(is.numeric)))

# Standardize the data
scaled_rab_matrix <- scale(rab_matrix)

# Generate the heatmap with increased height and adjusted font size
png("RAS_Family_Heatmaps/RAB_heatmap.png", width = 2000, height = 3000, res = 300)
pheatmap(
  mat = scaled_rab_matrix,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  color = colorRampPalette(c("blue", "white", "red"))(100),
  main = "Heatmap for RAS Family: RAB",
  fontsize_row = 8,  
  fontsize_col = 10,  
  angle_col = 45      
)
dev.off()  # Close the PNG device