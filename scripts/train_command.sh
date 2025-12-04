#!/bin/bash
# scripts/run_train.sh

# ================= config =================
DATASET_TAG=${DATASET_TAG:-"svla_so100_pickplace"}
POLICY_Repo_ID=${POLICY_Repo_ID:-"Jill111/my_smolvla"}
JOB_NAME=${JOB_NAME:-"my_smolvla_training"}
BATCH_SIZE=${BATCH_SIZE:-8}
STEPS=${STEPS:-200}
NUM_WORKERS=${NUM_WORKERS:-2}

RUN_ID=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="outputs/train/my_smolvla_${DATASET_TAG}/${RUN_ID}"

echo "Starting Training Job: $JOB_NAME"
echo "Run ID: $RUN_ID"
echo "Output Dir: $OUTPUT_DIR"

# ================= login =================
if [ -n "$WANDB_API_KEY" ]; then
    echo "Logging into WandB..."
    wandb login $WANDB_API_KEY
fi

if [ -n "$HF_TOKEN" ]; then
    echo "Logging into Hugging Face..."

    huggingface-cli login --token $HF_TOKEN --add-to-git-credential
    
 
    git config --global credential.helper store
    git config --global user.email "your_email@example.com"
    git config --global user.name "Your Name"
else
    echo "WARNING: HF_TOKEN not set. You might not be able to push to Hub."
fi

# ================= training command =================
echo "Running LeRobot training script..."

python lerobot/src/lerobot/scripts/lerobot_train.py \
  --policy.path=lerobot/smolvla_base \
  --policy.repo_id=${POLICY_Repo_ID}_${DATASET_TAG} \
  --dataset.repo_id=lerobot/${DATASET_TAG} \
  --num_workers=${NUM_WORKERS} \
  --batch_size=${BATCH_SIZE} \
  --steps=${STEPS} \
  --log_freq=10 \
  --output_dir=${OUTPUT_DIR} \
  --job_name=${JOB_NAME} \
  --policy.device=cuda \
  --wandb.enable=true \
  --rename_map='{"observation.images.wrist": "observation.images.camera1", "observation.images.top": "observation.images.camera2"}'

# ================= end =================
echo "Training finished. Model saved to ${OUTPUT_DIR}"


if [ -n "$HF_TOKEN" ]; then
    echo "Uploading checkpoint to Hugging Face Hub..."
    
    huggingface-cli upload ${POLICY_Repo_ID}_${DATASET_TAG} \
        ${OUTPUT_DIR}/checkpoints/last/pretrained_model \
        --commit-message "End of training checkpoint ${RUN_ID}"
fi