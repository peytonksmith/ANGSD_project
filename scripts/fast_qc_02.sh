#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --partition=angsd_class
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --mem=40G
#SBATCH --time=12:00:00
#SBATCH --output=job_output_%j.log
#SBATCH --error=job_error_%j.log

source $(conda info --base)/etc/profile.d/conda.sh

conda activate angsd

cd /athena/angsd/scratch/pes4008/project

bash ./scripts/fast_qc.sh
