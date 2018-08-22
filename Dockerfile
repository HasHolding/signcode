FROM alpine:3.7
LABEL maintainer "Levent SAGIROGLU <LSagiroglu@gmail.com>"
VOLUME /shared

ARG VERSION=1.7.1
WORKDIR /tmp/osslsigncode/
RUN apk add --update curl build-base openssl-dev curl-dev autoconf libgsf-dev \
  && curl -s -L https://downloads.sourceforge.net/project/osslsigncode/osslsigncode/osslsigncode-${VERSION}.tar.gz > osslsigncode-$VERSION.tar.gz \
  && set -x \  
  && tar xzf osslsigncode-$VERSION.tar.gz \
  && cd osslsigncode-$VERSION \
  && ./configure \
  && make \
  && make install \
  && cd .. \
  && rm -rf osslsigncode-$VERSION \
  && apk del curl-dev build-base autoconf libgsf-dev openssl-dev \
  && apk add libgsf openssl \
  && rm -rf /var/cache/apk/* \
  && rm -rf /tmp/*
WORKDIR /shared
ENTRYPOINT ["/usr/local/bin/osslsigncode"]