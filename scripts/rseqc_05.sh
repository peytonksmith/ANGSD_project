#!/bin/bash
#SBATCH --job-name=rseqc
#SBATCH --partition=angsd_class
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=40G
#SBATCH --time=48:00:00
#SBATCH --output=job_output_%j.log
#SBATCH --error=job_error_%j.log

source $(conda info --base)/etc/profile.d/conda.sh

conda activate rseqc

cd /athena/angsd/scratch/pes4008/project

#choose the regular script or parallel here
bash ./scripts/rseqc_parallel.sh
