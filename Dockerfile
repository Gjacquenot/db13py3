ARG IMAGE_PREFIX=""
FROM ${IMAGE_PREFIX}debian:trixie-slim
RUN apt-get update -yq \
 && apt-get install --yes --no-install-recommends \
    python3 \
    python3-pip
RUN python3 -m pip install -U pip \
    && python3 -m pip install --break-system-packages \
       numpy>=2.0.0