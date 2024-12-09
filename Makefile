# Declare phony targets
.PHONY: clean all heatmaps barplots

# Main targets
all: report.html Top_10_RAB_ARF_Proteins.xlsx

# Clean target
clean:
clean:
	rm -rf plots RAS_Family_Heatmaps RAS_BEACH_Barplots *.xlsx *.csv *.png *.html *.pdf

# Generate the HTML report
report.html: report.Rmd PCA_BEACH_domains_fixed.png RAS_Family_Clusters.csv \
	comparison_matrix_summary.csv Top_10_RAB_ARF_Proteins.xlsx
	Rscript -e 'rmarkdown::render("report.Rmd", "html_document")'

# Generate shared interactions and pairwise comparisons
comparison_matrix_summary.csv shared_interactions_comparison.xlsx: \
	Data/BEACHxRAS.xlsx scripts/prepare_shared_interactions.R
	Rscript scripts/prepare_shared_interactions.R

# Generate PCA plots
PCA_BEACH_domains_fixed.png: Data/BEACHxRAS.xlsx scripts/pca_analysis.R
	Rscript scripts/pca_analysis.R

# Generate RAS Family clusters
RAS_Family_Clusters.csv: Data/BEACHxRAS.xlsx scripts/cluster_analysis.R
	Rscript scripts/cluster_analysis.R

# Generate heatmaps for RAS Families
heatmaps: Data/BEACHxRAS.xlsx scripts/heatmap_analysis.R
	Rscript scripts/heatmap_analysis.R

# Generate barplots for BEACH domains
barplots: Data/BEACHxRAS.xlsx scripts/barplot_analysis.R
	Rscript scripts/barplot_analysis.R

# Generate Top 10 RAB and ARF proteins
Top_10_RAB_ARF_Proteins.xlsx: Data/BEACHxRAS.xlsx scripts/top_proteins.R
	Rscript scripts/top_proteins.R

# Create necessary directories
plots RAS_Family_Heatmaps RAS_BEACH_Barplots:
	mkdir -p plots RAS_Family_Heatmaps RAS_BEACH_Barplots