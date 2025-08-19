ARG IMAGE_PREFIX=""
ARG IMAGE_NAME=sirehna/base-image-debian13-gcc14:2025-08-18
FROM ${IMAGE_PREFIX}${IMAGE_NAME}

ARG PYTHON_MAJOR_VERSION=3
ARG PYTHON_MINOR_VERSION=13
ARG PYTHON_PATCH_VERSION=5
RUN apt-get update -yq || true \
 && apt-get install --yes --no-install-recommends \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    wget \
    libbz2-dev \
 && wget --quiet https://www.python.org/ftp/python/${PYTHON_MAJOR_VERSION}.${PYTHON_MINOR_VERSION}.${PYTHON_PATCH_VERSION}/Python-${PYTHON_MAJOR_VERSION}.${PYTHON_MINOR_VERSION}.${PYTHON_PATCH_VERSION}.tgz -O python.tgz \
 && mkdir -p python_src \
 && tar -xzf python.tgz --strip 1 -C python_src \
 && cd python_src \
 && ./configure --enable-optimizations \
 && make altinstall > /dev/null \
 && cd .. \
 && rm -rf python_src \
 && rm -f python.tgz \
 && python${PYTHON_MAJOR_VERSION}.${PYTHON_MINOR_VERSION} --version \
 && which python${PYTHON_MAJOR_VERSION}.${PYTHON_MINOR_VERSION} \
 && ln -s /usr/local/bin/python${PYTHON_MAJOR_VERSION}.${PYTHON_MINOR_VERSION} /usr/local/bin/python${PYTHON_MAJOR_VERSION} \
 && which python3
RUN python3 -m pip install -U pip \
 && python3 -m pip install \
    wheel \
    pybind11[global]==3.0.0 \
    numpy>=2.0.0 \
    setuptools