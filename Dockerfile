FROM python:3.8-alpine

MAINTAINER Will Fantom <w.fantom@lancs.ac.uk>

RUN apk add --virtual .build-dependencies \
    gcc \
    git \
    libffi-dev \
    libgcc \
    libxslt-dev \
    libxml2-dev \
    make \
    musl-dev \
    openssl-dev \
    zlib-dev

ENV RYU_BRANCH master
ENV RYU_TAG v4.30
ENV HOME /root
WORKDIR HOME
RUN git clone -b ${RYU_BRANCH} https://github.com/osrg/ryu.git && \
    cd ryu && \
    git checkout tags/${RYU_TAG} && \
    pip install . && \
    pip install -r tools/optional-requires

RUN apk del .build-dependencies

ENTRYPOINT ["/bin/ash"]