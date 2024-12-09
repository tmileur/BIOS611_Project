# Load necessary libraries
library(tidyverse)
library(pheatmap)

# Load data
data <- readxl::read_excel("Data/BEACHxRAS.xlsx", sheet = "Sheet1") %>% as_tibble()

# Group by RAS Family and calculate means
grouped_data <- data %>%
  group_by(`RAS Family`) %>%
  summarise(across(where(is.numeric), ~mean(.x, na.rm = TRUE)))

# Prepare matrix for clustering
heatmap_matrix <- as.matrix(grouped_data[,-1])
rownames(heatmap_matrix) <- grouped_data$`RAS Family`

# Perform hierarchical clustering
heatmap_result <- pheatmap(
  mat = heatmap_matrix,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  color = colorRampPalette(c("blue", "white", "red"))(100)
)

# Extract row clusters
row_clusters <- cutree(heatmap_result$tree_row, k = 5)

# Save clusters
cluster_assignments <- data.frame(
  RAS_Family = rownames(heatmap_matrix),
  Cluster = row_clusters
)
write.csv(cluster_assignments, "RAS_Family_Clusters.csv", row.names = FALSE)
