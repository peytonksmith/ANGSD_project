#!/bin/bash
#script to run feature counts on aligned BAM files 

annotation="/athena/angsd/scratch/pes4008/ref_genomes/genomes/gencode.vM33.annotation.gtf"

#find all sorted BAM files from STAR alignments for read counts
bam_list=$(find . -type f -name "*.Aligned.sortedByCoord.out.bam")

#run featureCounts on all the BAM files, outputting to Project directory 
echo "Generating read count table with featureCounts..."
featureCounts -T 12 -p -a ${annotation} -o /athena/angsd/scratch/pes4008/project/heart_rna_read_counts.txt ${bam_list}
echo "Read count table generated: heart_rna_read_counts.txt"
