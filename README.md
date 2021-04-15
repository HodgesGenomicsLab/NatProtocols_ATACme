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
Aligning reads to a reference genome is the subsequent step in sequencing analyses. As fragments generated in ATAC-Me undergo bisulfite conversion, we use the MethPipe alignment tool WALT. Alignment tools for converted libraries need to be able to account for discrepancies resulting from cytosine deamination.
```
walt_index.slrm
walt.slrm
walt_loop.sh
```
## Methylation Analysis
At this step, we separate our analyses for accessibility and DNA methylation. Methylation analysis is continued using the MethPipe package. The output of these steps is a .meth file which contains data for each CpG captured by the library and its methylation level. 
```
methprocess.slrm
methprocess_loop.sh
```
## Peak Calling
As is the case with other ATAC based methods, we identifying accumulation of reads, and thus accessible regions, using peak calling methods. There are a variety of peak calling softwares available for this type of analysis. The ENCODE project recommends using MACS2 for calling peaks on individual replicates prior to generating a consensus peak list through setting IDR thresholds. An alternative is to use Genrich, as recommended by  Harvard FAS Informatics. Genrich incorporated all replicates initially into its peak calling algorithm. We have typically prefer to use Genrich as it included an ATAC correction and its handling of biological replicates is more streamlined. However, different methods may be more appropriate depending on your individual study. 
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
