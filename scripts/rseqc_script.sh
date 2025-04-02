#!/bin/bash
#script to run RSeQC on all bam files

annotation="/athena/angsd/scratch/pes4008/ref_genomes/genomes/gencode.vM33.annotation.bed"

out_dir="./rseqc_output"
mkdir -p "$out_dir"

#find all bam files in project directory
bam_files=$(find . -type f -name "*.Aligned.sortedByCoord.out.bam")

#loop over each bam file and run rseqc
for bam in $bam_files; do
  sample=$(basename "$bam" .gencode.Aligned.sortedByCoord.out.bam)
  echo "Processing: $sample"

  read_distribution.py -i "$bam" -r "$annotation" > "$out_dir/${sample}_read_distribution.txt"

  geneBody_coverage.py -r "$annotation" -i "$bam" -o "$out_dir/${sample}"

done

echo "RSeQC complete"
