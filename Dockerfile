ARG IMAGE_PREFIX=""
FROM ${IMAGE_PREFIX}debian:trixie-slim
RUN apt-get update -yq \
 && apt-get install --yes --no-install-recommends \
    make \
    libgfortran5 \
    libquadmath0 \
    python3 \
    python3-dev \
    python3-pip \
    wait-for-it \
    g++ \
 && python3 --version \
 && python3 -m pip install --break-system-packages \
    grpcio \
    protobuf \
    numpy>=2.0.0 \
 && apt-get purge --auto-remove python3-dev \
 && apt-get purge --auto-remove g++ \
 && apt-get autoclean \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /tmp/* /var/tmp/* \
 && rm -rf /var/lib/apt/lists
