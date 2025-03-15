#!/bin/bash

#SBATCH -n 4
#SBATCH -c 6
#SBATCH --mem=256G
#SBATCH --gres=gpu:l40s:4
#SBATCH --nodes=1
#SBATCH -t 00:10:00
#SBATCH -p gpu-he

PYTHONPATH="/users/jzhan708/scratch/robust_dinov2" python dinov2/run/train/train.py \
    --nodes 1 \
    --config-file dinov2/configs/ssl_200_size112_config.yaml \
    --output-dir output_clean-200_size112 \
    --max_to_keep 45 \
    --save_frequency 5 \
    train.dataset_path=ImageNet:split=TRAIN:root=/users/jzhan708/scratch/robust_dinov2_dataset/mini-imagenet:extra=/users/jzhan708/scratch/robust_dinov2_dataset/mini-imagenet-extra

