#!/bin/bash

#SBATCH -n 4
#SBATCH -c 6
#SBATCH --mem=256G
#SBATCH --gres=gpu:l40s:4
#SBATCH --nodes=1
#SBATCH -t 00:10:00
#SBATCH -p gpu-he

corruptions=(
    elastic_transform frost shot_noise speckle_noise
    contrast impulse_noise pixelate snow fog
    gaussian_noise jpeg_compression saturate spatter 
    brightness
)

# for folder in "${corruptions[@]}"; do
for step in 62499

do
    for corruption in "${corruptions[@]}"
    # for corruption in defocus_blur glass_blur motion_blur zoom_blur
      do
        for level in 1 2 3 4 5
	do
	PYTHONPATH="/users/jzhan708/scratch/robust_dinov2" python dinov2/run/eval/linear_fast.py \
            --config-file output_size112-200-resume-0-150-200-0-50-50/config.yaml \
            --pretrained-weights output_size112-200-resume-0-150-200-0-50-50/eval/training_$step/teacher_checkpoint.pth \
            --output-dir output_size112-200-resume-0-150-200-0-50-50/eval/training_$step/corruption/linear_$corruption$level \
            --classifier-fpath output_size112-200-resume-0-150-200-0-50-50/eval/training_$step/linear/model_final.pth \
            --train-dataset ImageNet:split=TRAIN:root=/users/jzhan708/scratch/robust_dinov2_dataset/mini-imagenet:extra=/users/jzhan708/scratch/robust_dinov2_dataset/mini-imagenet-extra \
            --val-dataset ImageNet:split=VAL:root=/users/jzhan708/scratch/robust_dinov2_dataset/imagenet-100-c/$corruption/$level:extra=/users/jzhan708/scratch/robust_dinov2_dataset/imagenet-100-c/extra
        done
      done
done

