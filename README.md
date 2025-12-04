# Stats_507_final Efficient Fine-tuning of Vision-Language-Action Models for Robotic Manipulation

This repository contains the source code and experimental notebooks for the **Stats 507 Final Project**.

We explored efficient fine-tuning strategies for Vision-Language-Action (VLA) models using the **Hugging Face LeRobot** framework. Specifically, we fine-tuned the **SmolVLA** model on the **SO-100 robotic arm** dataset (`lerobot/svla_so100_pickplace`) to perform pick-and-place tasks.

## 🔗 Model Weights

The fine-tuned model weights have been uploaded to Hugging Face:
👉 **[Jill111/my_smolvla_svla_so100_pickplace](https://huggingface.co/Jill111/my_smolvla_svla_so100_pickplace)**

## 📂 Project Structure

The core logic of this project is organized into Jupyter Notebooks located in the `notebooks/` directory:

| Notebook | Description |
| :--- | :--- |
| **`01_inspect_data.ipynb`** | **Data Analysis**: Visualizes the `svla_so100_pickplace` dataset, including action distributions and image samples. |
| **`02_model_debug.ipynb`** | **Debugging**: Validates the SmolVLA model architecture, checking forward and backward propagation steps locally before training. |
| **`03_colab_training-smolvla.ipynb`** | **Training (Main)**: The primary training pipeline designed for **Google Colab**. It handles data loading, model fine-tuning (approx. 1k steps), and saving checkpoints. |
| **`04_evaluation.ipynb`** | **Evaluation**: Loads the fine-tuned model to perform Open-Loop Evaluation, calculating validation loss and visualizing predicted action trajectories vs. ground truth. |

## 🚀 Quick Start

### 1. Installation
To run the analysis or evaluation locally, install the required dependencies:

```bash
pip install -r requirements.txt