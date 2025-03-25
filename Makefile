build:
	cd docker && docker build -t dynamo-cuda-12.5.1-ubuntu24.04 -f Dockerfile .

run:
	docker run -it --rm \
		--gpus all \
		--ipc=host \
		-v ./models:/root/.cache \
		dynamo-cuda-12.5.1-ubuntu24.04 dynamo run out=vllm deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B

shell:
	docker run -it --rm\
		--gpus all \
		--ipc=host \
		-v ./models:/root/.cache \
		dynamo-cuda-12.5.1-ubuntu24.04 /bin/bash
