#!/bin/bash

# Parameters
#SBATCH --cpus-per-task=10
#SBATCH --error=/oscar/scratch/jzhan708/robust_dinov2/output_clean-200_size112/%j_0_log.err
#SBATCH --gpus-per-node=1
#SBATCH --job-name=dinov2:train
#SBATCH --mem=0GB
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --open-mode=append
#SBATCH --output=/oscar/scratch/jzhan708/robust_dinov2/output_clean-200_size112/%j_0_log.out
#SBATCH --partition=learnlab
#SBATCH --signal=USR2@120
#SBATCH --time=2800
#SBATCH --wckey=submitit

# command
export SUBMITIT_EXECUTOR=slurm
srun --unbuffered --output /oscar/scratch/jzhan708/robust_dinov2/output_clean-200_size112/%j_%t_log.out --error /oscar/scratch/jzhan708/robust_dinov2/output_clean-200_size112/%j_%t_log.err /usr/bin/python -u -m submitit.core._submit /oscar/scratch/jzhan708/robust_dinov2/output_clean-200_size112
