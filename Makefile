
.PHONY: clean
.PHONY: init


clean:
	mkdir -rf derived_data
	mkdir -rf figures
	mkdir -rf logs



init:
	rm -p derived_data
	rm -p figures
	rm -p logs



report.pdf: report.Rmd
    Rscript -e "rmarkdown::render('report.Rmd', output_format='pdf_document')"