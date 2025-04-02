#!/bin/bash
#script to download sra files
csv_file="./csv/sra_names.csv"

#loop through each row in the CSV file
while IFS=',' read -r sample_name sra1 sra2 sra3 sra4 sra5; do
  echo "Processing sample: $sample_name"

  #create sample directory
  sample_dir="${PWD}/${sample_name}"
  mkdir -p "$sample_dir"

  #loop through the all SRA's for each row
  for sra in "$sra1" "$sra2" "$sra3" "$sra4" "$sra5"; do

    #create individual folder for each SRA
    folder_name="${sample_name}_${sra}"
    target_dir="${sample_dir}/${folder_name}"
    echo "Creating folder: ${target_dir}"
    mkdir -p "$target_dir"

    (
      cd "$target_dir"

      #download the SRA file with prefetch
      echo "Prefetching SRA file for $sra..."
      prefetch "$sra"
      
      #download the split paired-end data
      echo "Dumping fastq files for $sra..."
      fastq-dump --split-files --gzip --skip-technical --clip "$sra"

      #rename the files
      if [ -f "${sra}.fastq.gz" ]; then
        mv "${sra}.fastq.gz" "${folder_name}.fastq.gz"
      fi

      #rename the paired-end files
      if [ -f "${sra}_1.fastq.gz" ]; then
        mv "${sra}_1.fastq.gz" "${folder_name}_1.fastq.gz"
      fi
      if [ -f "${sra}_2.fastq.gz" ]; then
        mv "${sra}_2.fastq.gz" "${folder_name}_2.fastq.gz"
      fi
    )
  done

done < "$csv_file"
