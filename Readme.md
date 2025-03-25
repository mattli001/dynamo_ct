# NVIDIA Dynamo with vLLM Docker Environment

This repository contains a Docker environment for running vLLM models using [NVIDIA AI Dynamo](https://github.com/ai-dynamo/dynamo).

## Prerequisites

- Docker installed
- NVIDIA GPU with CUDA support
- NVIDIA Container Toolkit

## Build

Build the Docker image with:

```bash
make build
```

## Usage

### Run Default Model

Use `make run` to start the container with the default model `deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B`:

```bash
make run
```

### Interactive Shell

Access the container's shell for debugging or custom commands:

```bash
make shell
```

## Example

```bash
[10:48:17] ubuntu@ubpc /home/ubuntu/trunk/dynamo_ct [2] 
> make shell 
docker run -it --rm \
        --gpus all \
        --ipc=host \
        -v ./models:/root/.cache \
        dynamo-cuda-12.5.1-ubuntu24.04 /bin/bash
root@739cffe7abeb:/# dynamo run out=vllm deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B
config.json [00:00:00] [██████████████████████████████████████████████████████████████████] 679 B/679 B 3.51 KiB/s (0s)
generation_config.json [00:00:00] [██████████████████████████████████████████████████████████] 181 B/181 B 952 B/s (0s)
model.safetensors [00:05:01] [█████████████████████████████████████████████████████] 3.31 GiB/3.31 GiB 16.15 MiB/s (0s)
tokenizer.json [00:00:00] [█████████████████████████████████████████████████████████] 6.71 MiB/6.71 MiB 7.42 MiB/s (0s)
tokenizer_config.json [00:00:00] [█████████████████████████████████████████████████] 3.00 KiB/3.00 KiB 15.07 KiB/s (0s)INFO 03-25 02:55:02 __init__.py:190] Automatically detected platform cuda.
INFO 03-25 02:55:02 nixl.py:16] NIXL is available
Loading safetensors checkpoint shards:   0% Completed | 0/1 [00:00<?, ?it/s]
Loading safetensors checkpoint shards: 100% Completed | 1/1 [00:00<00:00,  2.62it/s]
Loading safetensors checkpoint shards: 100% Completed | 1/1 [00:00<00:00,  2.62it/s]
Capturing CUDA graph shapes: 100%|██████████| 35/35 [00:06<00:00,  5.00it/s]
2025-03-25T02:55:19.471049Z  INFO dynamo_run::input::text: Ctrl-c to exit
✔ User · Hello, how are you?
Alright, the user greeted me with "Hello, how are you?" It's a friendly and open question.

I should respond in a warm and welcoming manner.

I need to keep it concise and positive.

Maybe something like, "Hello! I'm just a program, so I don't have feelings, but thanks for asking! How can I assist you today?"

That should cover it without being too lengthy.
</think>

Hello! I'm just a program, so I don't have feelings, but thanks for asking! How can I assist you today?
? User ›
```

## Container Details

- Base Image: `nvidia/cuda:12.5.1-base-ubuntu24.04`
- Python Environment: Virtual environment in `/opt/venv`
- Main Package: `ai-dynamo[all]` version `0.1.0`
- Volume Mount: Local `./models` directory mounted to `/root/.cache` in container
- GPU Access: Enabled with `--gpus all`
- IPC Mode: Host IPC namespace (`--ipc=host`)

## vLLM Supported Models

For a complete list of supported models, refer to:
- [List of Multimodal Language Models](https://docs.vllm.ai/en/latest/models/supported_models.html#list-of-multimodal-language-models)
- [List of Text-Only Language Models](https://docs.vllm.ai/en/latest/models/supported_models.html#list-of-text-only-language-models)

## Build History

- 2025-03-25: Initial build of `dynamo-cuda-12.5.1-ubuntu24.04`
  - Downgraded from CUDA 12.8.1 to 12.5.1 due to compatibility issues in my machine
  - Fixed container startup issues related to CUDA version requirements

## Troubleshooting

If you encounter the following error:
```bash
nvidia-container-cli: requirement error: unsatisfied condition: cuda>=12.8
```
This indicates a CUDA version mismatch. Solution:
- Use the current image with CUDA 12.5.1
- Or upgrade your NVIDIA drivers if you need CUDA 12.8+

## Notes

- Models are cached in the `./models` directory
- Container runs with GPU access and host IPC namespace for optimal performance
