ARG ZEPHYR_SDK_VERSION=0.17.0
ARG ZEPHYR_SDK_INSTALL_DIR=/opt/toolchains/zephyr-sdk-${ZEPHYR_SDK_VERSION}
ARG ZEPHYR_SDK_TOOLCHAINS="-t arm-zephyr-eabi"
ARG BASE_IMAGE="ghcr.io/embeddedcontainers/zephyr:arm-0.17.0SDK"

FROM ${BASE_IMAGE}

ARG ZEPHYR_SDK_INSTALL_DIR
ARG ZEPHYR_SDK_TOOLCHAINS

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8    

RUN \
  apt-get -y update \
  && apt-get -y install --no-install-recommends \
  xz-utils \
  wget \
  openocd \
  && ${ZEPHYR_SDK_INSTALL_DIR}/setup.sh -c ${ZEPHYR_SDK_TOOLCHAINS} \
  && apt-get remove -y --purge \
  wget \
  xz-utils \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && pip3 install pyelftools
