#!/bin/bash

# grab the files, and export it so the 'child' sbatch jobs can access it

# Directory where mapped sam file output from WALT is located
SAMDIR=/data/hodges_lab/NPCdiff_ATACme/fastqs/trimmed_reads/temp/mapped_reads
export FILESSAM=($(ls -1 ${SAMDIR}/mappedRead_*.sam))

# Output directory where primary output files of methpipe will go
export PROCESSED_DIR=/data/hodges_lab/NPCdiff_ATACme/fastqs/trimmed_reads/temp/mapped_reads/methprocessed
if test -d ${PROCESSED_DIR}; then  echo "exist"; else mkdir ${PROCESSED_DIR} && echo created; fi

# Output directory for bigwig file signal tracks
export TRACK_DIR=/data/hodges_lab/NPCdiff_ATACme/fastqs/trimmed_reads/mapped_reads/methprocessed/tracks_hg38
if test -d ${TRACK_DIR}; then  echo "exist"; else mkdir ${TRACK_DIR} && echo created; fi

# Directory that contains a fasta file for each chromosome
export CHROM_DIR=/data/hodges_lab/hg38_genome/
# List of chromosome sizes
export SIZES_DIR=/data/hodges_lab/hg38_genome/hg38.chrom.sizes

# get size of array
NUMSAM=${#FILESSAM[@]}
# now subtract 1 as we have to use zero-based indexing (first cell is 0)
ZBNUMSAM=$(($NUMSAM - 1))
for i in `seq 0 $ZBNUMSAM`;
do
echo ${FILESSAM[$i]}
export SAM=${FILESSAM[$i]}

# Run methpipe command via SLURM job scheduler
sbatch methprocess.slrm
done
