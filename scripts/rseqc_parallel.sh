#!/bin/bash
#script to run RSeQC on all bam files in parallel

n_processes=${SLURM_CPUS_PER_TASK}

annotation="/athena/angsd/scratch/pes4008/ref_genomes/genomes/gencode.vM33.annotation.bed"
out_dir="/athena/angsd/scratch/pes4008/project/QC/rseqc"
mkdir -p "$out_dir"

find . -type f -name "*.Aligned.sortedByCoord.out.bam" \
  | xargs -n1 -P "$n_processes" -I{} bash -lc '
      sample=$(basename {} .gencode.Aligned.sortedByCoord.out.bam)
      echo "Processing: $sample"
      read_distribution.py -i {} -r "'"$annotation"'" > "'"$out_dir"'/${sample}_read_distribution.txt"
      geneBody_coverage.py -r "'"$annotation"'" -i {} -o "'"$out_dir"'/${sample}"
    '
echo "RSeQC complete."