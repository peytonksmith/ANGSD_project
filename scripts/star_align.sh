#!/bin/bash
#run STAR alignment on all downloaded forward/reverse fastq files, index the files, then run feature counts on all of these files and output to a single .txt file


genome_dir="/athena/angsd/scratch/pes4008/ref_genomes/STAR_gencode_149_GRCm39"

#loop over all sample ID directories in project folder
for sample_dir in */; do
  echo "Processing sample folder: $sample_dir"
  #loop over each SRA folder inside the sample directory
  for sra_dir in "$sample_dir"/*SRR*/; do
    base=$(basename "$sra_dir")
    echo "Aligning sample ID: $base"

    #create paths to forward and reverse paired end files
    fq1="${sra_dir}/${base}_1.fastq.gz"
    fq2="${sra_dir}/${base}_2.fastq.gz"

    #run the STAR alignment
    STAR --runMode alignReads \
         --runThreadN 12 \
         --genomeDir ${genome_dir} \
         --readFilesIn "$fq1" "$fq2" \
         --readFilesCommand zcat \
         --sjdbOverhang 149 \
         --outFileNamePrefix "${sra_dir}/${base}.gencode." \
         --outSAMtype BAM SortedByCoordinate

    bamfile="${sra_dir}/${base}.gencode.Aligned.sortedByCoord.out.bam"

    #index bam output if alignment was succesful
    if [ -f "$bamfile" ]; then
      echo "Indexing BAM file for $base"
      samtools index "$bamfile"
    else
      echo "ERROR: BAM file not found for $base"
    fi
  done
done
