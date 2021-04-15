# NatProtocols_ATACme
ATAC-Me is a joint profiling method capable of capturing chromatin accessibility and DNA methylation data from a single fragment library in a sequence independent manner. Processing of the resulting data is based on initial steps shared with many next generation sequencing pipelines followed by parallel analyses for accessibility and methylation data. The outline of our pipeline is shown below. 

![Figure4](https://user-images.githubusercontent.com/75271993/114914104-89cf4300-9de7-11eb-9720-a66b158f3861.png)

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
As is the case with other ATAC based methods, we identifying accumulation of reads, and thus accessible regions, using peak calling methods. There are a variety of peak calling softwares available for this type of analysis. The ENCODE project recommends using MACS2 for calling peaks on individual replicates prior to generating a consensus peak list through setting IDR thresholds. An alternative is to use Genrich, as recommended by  Harvard FAS Informatics. Genrich incorporates all replicates initially into its peak calling algorithm. We prefer to use Genrich as it includes an ATAC read shift correction and its handling of biological replicates is more streamlined. However, different methods may be more appropriate depending on your individual study. 
```
genrich.slrm
```
## Further Analyses
A distinct benefit of joint profiling methods such as ATAC-Me is the data results from one fragment library and thus a single cell population. This allows us to relate accessibility and methylation spatially with high confidence. Initially, we evaluate library quality by looking at CpG coverage, peak calls, library complexity, and FRiP scores. Following the individual processing of accessibility and methylation data, we have integrated these date types in a variety of ways.
### library quality
```
complexity.slrm
FRiP_scores.slrm
```
### timecourse accessibility analysis
One avenue of analysis we have persued is evaluating how these epigenetic features change over cell fate changes. In Barnett et al, 2019. ATAC-Me was applied through a THP1 differentiation. If these sorts of analyses are of interest to your group, it may be helpful to identify temporal accessibility behavior. We have applied the R package TCSeq to do this. 
```
TCseq_analysis.Rmd
```
### average methylation of region
Accessibility peaks generate boundaries that can used to delineate regions of interest over which one can quantify methylation levels. The following script takes a bed file, such as a peak file, and calculates the average methylation across that region using a MethPipe command. 
```
timepoint_roimeth.slrm
```
### footprinting
A unique feature of ATAC methods is the ability to predict transcription factor (TF) binding through footprinting. Footprinting relies on the assumption that Tn5 incorporated adaptors into accessible regions. Thus, where TFs are bound, and the underlying sequence is protected, fragments will be depleted relative to their otherrwise accessibly surroundings. The feasibility of TF footprinting is dependent on the sequencing depth and library complexity captured and these features should be assessed prior to footprinting analyses. Generally, with minimal troubleshooting of the ATAC-Me protocol-- and requesting around 75 million reads for human samples-- we have been able to generate the high coverage, high complexity libraries that enable footprinting.
```
footprinting_scripts.txt
```
### heatmap visualization
The following script utilizes deeptools methods of visualization to display heatmaps for accessibility, DNA methylation, and footprinting. All the heatmaps displayed in Figure 5 of the manuscript are generated using this method. 
```
heatmap_matrix_plot.txt
```
