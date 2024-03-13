#!/bin/bash
cd ../..
cd HCPT
# custom config
DATA='../DATAALL/DATA'
TRAINER=HCPT
# 从脚本的第一个参数中获取数据集的名称，并将其存储在 DATASET 变量中。
DATASET=$1
# 从脚本的第二个参数中获取种子值，并将其存储在 SEED 变量中。
SEED=$2

CFG=vit_b16_c2_ep5_batch4_2ctx
SHOTS=16

# 构建一个名为 DIR 的变量，用于存储输出目录的路径。
DIR=output/base2new/train_base/${DATASET}/shots_${SHOTS}/${TRAINER}/${CFG}/seed${SEED}
if [ -d "$DIR" ]; then
    echo "Results are available in ${DIR}. Resuming..."
    python train.py \
    --root ${DATA} \
    --seed ${SEED} \
    --trainer ${TRAINER} \
    --dataset-config-file configs/datasets/${DATASET}.yaml \
    --config-file configs/trainers/${TRAINER}/${CFG}.yaml \
    --output-dir ${DIR} \
    DATASET.NUM_SHOTS ${SHOTS} \
    DATASET.SUBSAMPLE_CLASSES base
else
    echo "Run this job and save the output to ${DIR}"
    python train.py \
    --root ${DATA} \
    --seed ${SEED} \
    --trainer ${TRAINER} \
    --dataset-config-file configs/datasets/${DATASET}.yaml \
    --config-file configs/trainers/${TRAINER}/${CFG}.yaml \
    --output-dir ${DIR} \
    DATASET.NUM_SHOTS ${SHOTS} \
    DATASET.SUBSAMPLE_CLASSES base
fi