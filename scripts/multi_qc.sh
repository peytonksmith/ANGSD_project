#!/bin/bash
#script to run MultiQC across all prior QC outputs and STAR logs

qc_dir="/athena/angsd/scratch/pes4008/project/QC"
project_dir="/athena/angsd/scratch/pes4008/project"
outdir="${qc_dir}/multiqc_report"
mkdir -p "${outdir}"

echo "Running MultiQC..."
multiqc "${qc_dir}" "${project_dir}" -o "${outdir}"

echo "MultiQC report saved to: ${outdir}/multiqc_report.html"
