#!/bin/bash
# scripts/setup_env.sh

echo "Starting environment setup..."

# 1.FFmpeg 
conda install ffmpeg=7.1.1 -c conda-forge -y
# clone LeRobot
if [ ! -d "lerobot" ]; then
    echo "Cloning LeRobot repository..."
    git clone https://github.com/huggingface/lerobot.git
fi

echo "Installing LeRobot dependencies..."
cd lerobot
pip install -e ".[smolvla]"
cd ..

echo "Environment setup complete!"