# Load necessary libraries
library(tidyverse)
library(ggplot2)

# Load data
data <- readxl::read_excel("Data/BEACHxRAS.xlsx", sheet = "Sheet1") %>% as_tibble()
RAS_data <- data %>% select(RAS, LRBA_MC:WDR81_MC) %>% drop_na()

# Prepare data for PCA
RAS_matrix <- RAS_data %>%
  column_to_rownames("RAS") %>%  # Set "RAS" as rownames for transposition
  t() %>%                        # Transpose the data
  as.matrix()                    # Convert to numeric matrix

# Check for missing values and replace with 0
if (any(is.na(RAS_matrix))) {
  cat("Missing values found. Replacing with 0.\n")
  RAS_matrix[is.na(RAS_matrix)] <- 0
}

# Scale the data (mean = 0, variance = 1)
scaled_matrix <- scale(RAS_matrix)

# Perform PCA
pca_result <- prcomp(scaled_matrix, scale. = TRUE)

# Print PCA summary
cat("PCA Summary:\n")
print(summary(pca_result))

# Create a color palette for BEACH domains
BEACH_domains <- rownames(RAS_matrix)
color_mapping <- setNames(rainbow(length(BEACH_domains)), BEACH_domains)

# Convert PCA results to a data frame
pca_df <- as.data.frame(pca_result$x)
colnames(pca_df) <- paste0("PC", 1:ncol(pca_df))  
pca_df$BEACH <- rownames(pca_result$x)           

# Visualize PCA with a white background
pca_plot <- ggplot(pca_df, aes(x = PC1, y = PC2, label = BEACH, color = BEACH)) +
  geom_point(size = 3) +                              
  geom_text(aes(label = BEACH), vjust = -1, size = 3, show.legend = FALSE) +
  scale_color_manual(values = color_mapping) +
  theme_light() +  # Use a light theme with a white background
  labs(
    title = "PCA Analysis of BEACH Domains",
    x = paste0("Dim1 (", round(100 * summary(pca_result)$importance[2, 1], 1), "%)"),
    y = paste0("Dim2 (", round(100 * summary(pca_result)$importance[2, 2], 1), "%)"),
    color = "BEACH Domains"                           
  ) +
  theme(legend.position = "right") +
  guides(color = guide_legend(override.aes = list(size = 4))) 

# Save PCA plot
ggsave("PCA_BEACH_domains.png", plot = pca_plot, width = 8, height = 6, dpi = 300)

# Display the plot
print(pca_plot)
