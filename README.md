# BIOS 611 Project: Identifying WDFY4 and BEACH Domain Containing Proteins as Effectors of RAS GTPases
T-cell receptor (TCR) engagement with peptides presented by MHC molecules on antigen-presenting cells (APCs) drives antigen-specific T-cell activation against viral and tumor antigens. Professional APCs rely on endocytic trafficking to sort, process, and present antigens via MHC molecules. The WD repeat- and FYVE domain–containing protein 4 (WDFY4) is essential for MHC-I–mediated cross-presentation of cell- and viral-associated antigens; however, its structure and mechanism remain uncharacterized.

To identify proteins that may interface with WDFY4, I utilized AlphaFold2 Multimer to screen 144 unique proteins against each of WDFY4's six domains. Intriguingly, I identified several hits suggesting that RAS GTPases interact with the BEACH domain of WDFY4. To systematically interrogate these potential interactions, I predicted the structures of each of the nine known BEACH domains in the human proteome and ran an AlphaFold2 Multimer screen against all known RAS GTPases.

The analysis that follows in this report is an attempt to identify which RAS GTPases are most likely to interact with a given BEACH domain. This information will guide which BEACH domains and RAS GTPases I will purify in the lab for empirical investigation. These initial results suggest a relationship between BEACH domains and RABs associated with recycling endosomes, supporting one of my hypotheses: WDFY4 is involved in regulating retrograde trafficking of peptide-loaded MHC-I molecules to the surface of APCs. Furthermore, my data is supported by a recent report identifying an ARF1-dependent mechanism for recruiting Lipopolysaccharide-responsive beige-like anchor (LRBA) to RAB4 endosomes.

BEACH Domains: LRBA, LYST, NBEA, NBEAL1, NBEAL2, NSMAF, WDFY3, WDFY4, WDR81 

# About the Data
The results of the screen are included in /Data/BEACHxRAS.xlsx. These results include the model confidence scores from the AlphaFold2 Multimer screen, wherein computational prediction of protein-protein interfaces was performed for nine human BEACH domains against 147 RAS superfamily GTPases.


## Summary of Data Table
| Label             | Description                                        |
|----------------------|----------------------------------------------------|
| RAS                  | Gene identifier for the RAS superfamily protein |
| Uniprot              | Uniprot accession for the RAS superfamily protein |
| RAS Family           | The subclass in which the RAS protein belongs |
| Function             | The function attributed to the subclass |
| LRBA_MC              | Model confidence scores for the LRBA BEACH domain |
| LYST_MC              | Model confidence scores for the LYST BEACH domain |
| NBEA_MC              | Model confidence scores for the NBEA BEACH domain |
| NBEAL1_MC            | Model confidence scores for the NBEAL1 BEACH domain |
| NBEAL2_MC            | Model confidence scores for the NBEAL2 BEACH domain |
| NSMAF_MC             | Model confidence scores for the NSMAF BEACH domain |
| WDFY3_MC             | Model confidence scores for the WDFY3 BEACH domain |
| WDFY4_MC             | Model confidence scores for the WDFY4 BEACH domain |
| WDR81_MC             | Model confidence scores for the WDR81 BEACH domain |



## Clone the repository
```bash
git clone https://github.com/tmileur/BIOS611_Project.git
```


## Build the docker container
```bash
docker build -t trevormileur/bios611_project .
```

## Run the container
```bash
docker run -d --platform linux/amd64 \
  -p 8787:8787 \
  -v $(pwd)/tmileur:/home/tmileur/Bios611_project \
  trevormileur/bios611_project
```

## Use http://localhost:8787/ to open Rstudio


## Login using the specific credentials
login: tmileur
pass: bios611

## Use the R terminal to change directories
```bash
cd $(pwd)/BIOS611_Project
```

## Run the makefile
```bash
make all
```
