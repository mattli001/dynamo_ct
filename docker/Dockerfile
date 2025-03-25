# FROM nvidia/cuda:12.8.1-base-ubuntu24.04
FROM nvidia/cuda:12.5.1-base-ubuntu24.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq python3-dev python3-pip python3-venv libucx0

RUN python3 -m venv /opt/venv

RUN /opt/venv/bin/pip install ai-dynamo[all]==0.1.0

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["dynamo", "run", "out=vllm", "deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B"]