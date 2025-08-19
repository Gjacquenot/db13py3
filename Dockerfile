ARG IMAGE_PREFIX=""
FROM ${IMAGE_PREFIX}debian:trixie-slim
RUN apt-get update -yq \
 && apt-get install --yes --no-install-recommends \
    make \
    libgfortran5 \
    libquadmath0 \
    python3 \
    python3-pip \
    wait-for-it \
 && python3 --version \
 && python3 -m pip install --break-system-packages \
    grpcio==1.66.1 \
    protobuf==5.28.0 \
    numpy>=2.0.0 \
 && apt-get autoclean \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /tmp/* /var/tmp/* \
 && rm -rf /var/lib/apt/lists
