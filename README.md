# NatProtocols_ATACme
Scripts for the processing and analysis of ATAC-Me datasets

## Software
```
SAMtools      1.6
trim-galore   0.6.5 
cutadapt      1.18 
fastqc        0.11.9 
WALT          v1.0
deeptools     3.3
pheatmap  1.0.12 (R version 3.6.0)
TCseq     1.8.0 (R version 3.6.0)
tidyverse 1.3.0 (R version 3.6.0)
picard        2.18.27
preseq        2.0.0
```
## Trimming
```
trim.slrm
trimming_loop.sh
```
## Mapping
```
walt_index.slrm
walt.slrm
walt_loop.sh
```
## Methylation Analysis
```
methprocess.slrm
methprocess_loop.sh
```
## Peak Calling
```
genrich.slrm
```
## Further Analyses
### timecourse accessibility analysis
```
TCseq_analysis.Rmd
```
### library complexity
```
complexity.slrm
```
### average methylation of region
```
timepoint_roitmeth.slrm
```
### footprinting
```
footprinting_scripts.txt
```
### heatmap visualization
```
heatmap_matrix_plot.txt
```
