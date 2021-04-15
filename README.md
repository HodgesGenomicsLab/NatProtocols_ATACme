# NatProtocols_ATACme
ATAC-Me is a joint profiling method capable of capturing chromatin accessibility and DNA methylation data from a single fragment library in a sequence independent manner. Processing of the resulting data is based on initial steps shared with many next generation sequencing pipelines followed by parallel analyses for accessibility and methylation data. The outline of our pipeline is shown below. 

## Software
Analyses of ATAC-Me is designed to take advantage of publicly available softwares, listed here: 
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
As is the case with other sequencing methods, adaptor sequences need to be trimmed from output reads. The ATAC-Me protocol relies on a Nextera based adaptor system. In our pipeline we utilize trim-galore, a wrapper for cutadapt and fastqc, which searches for known adaptor sequences, including Nextera, and removes them from reads. 
```
trim.slrm
trimming_loop.sh
```
## Mapping
Aligning reads to a reference genome is the subsequent step in sequencing analyses. As fragments generated in ATAC-Me undergo bisulfite conversion, we use the MethPipe alignment tool WALT. 
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
