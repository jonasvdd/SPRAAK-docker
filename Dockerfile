FROM debian:stretch-slim

ARG VERSION="v1.2.395" 
ARG DEST_DIR=SPRaak/${VERSION}
SHELL ["/bin/bash", "-c"]

# workdir must contain the tarball with SPRaak Software
WORKDIR .
COPY . $DEST_DIR

RUN set -x \
    && apt-get update\
    && apt-get install --no-install-recommends --no-install-suggests -y gawk python llvm clang scons doxygen graphviz texlive zlib1g-dev libedit-dev nano \ 
    && cd $DEST_DIR \
    && tar -xvf SPRAAK_${VERSION}.tgz \ 
    && scons ARCH=native COMPILER=clang install 2>&1 | tee install.log \
    && python scripts/spr_version.py ${VERSION} >> /etc/profile \
    && source /etc/profile


### Installation commands
##  1. Build image from this dockerFile
# docker image build -t $USER/spraak .

##  2. Create a container from that image and mount the volume with the to be converted data
#  docker run -ti -v "$PWD/os_volume_path":/container_path $USER/spraak bash

## 3. Execute this to be able to execute the SPRaak commands
# source /etc/profile
