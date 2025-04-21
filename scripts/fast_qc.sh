#!/bin/bash
#script to run FastQC on all FASTQ files in the project folder

outdir="/athena/angsd/scratch/pes4008/project/QC/fastqc"
mkdir -p "$outdir"

#find all fastq files in the current directory
fastq_list=$(find . -type f -name "*.fastq.gz")

#run FastQC on all the fastq files, outputting to specified output directory (QC/)
echo "Running FastQC..."
fastqc -t 18 -o ${outdir} ${fastq_list}
echo "FastQC complete. Outputs are in: ${outdir}"
