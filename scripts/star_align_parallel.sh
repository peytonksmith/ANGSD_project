#!/bin/bash
genome_dir="/athena/angsd/scratch/pes4008/ref_genomes/STAR_gencode_149_GRCm39"

#find every SRR directory
find . -maxdepth 2 -type d -name "*SRR*" > sra_dirs.txt

#align all in parallel
cat sra_dirs.txt | xargs -n1 -P5 -I{} bash -lc '
  sra_dir="{}"
  base=$(basename "$sra_dir")
  echo "Aligning $base"

  STAR --runMode alignReads \
       --runThreadN 4 \
       --genomeDir "'"$genome_dir"'" \
       --readFilesIn "$sra_dir"/"$base"_1.fastq.gz "$sra_dir"/"$base"_2.fastq.gz \
       --readFilesCommand zcat \
       --sjdbOverhang 149 \
       --outFileNamePrefix "$sra_dir"/"$base".gencode. \
       --outSAMtype BAM SortedByCoordinate

  bam="$sra_dir/$base.gencode.Aligned.sortedByCoord.out.bam"
  if [[ -f "$bam" ]]; then
    echo "Indexing $bam"
    samtools index "$bam"
  else
    echo "ERROR: $bam not found!" >&2
    exit 1
  fi
'

echo "STAR alignments finished."
