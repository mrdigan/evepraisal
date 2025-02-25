FROM golang:1.18-alpine
LABEL maintainer="mrdigan <https://github.com/mrdigan/evepriaisal>"
WORKDIR $GOPATH/src/github.com/mrdigan/evepraisal
RUN apk --update add --no-cache --virtual build-dependencies git gcc musl-dev make bash && \
    git clone https://github.com/mrdigan/evepraisal.git . && \
    export GO111MODULE=on ENV=prod && \
    make setup && \
    make build && \
    make install && \
    mkdir /evepraisal/ && \
    mv $GOPATH/bin/evepraisal /evepraisal/evepraisal && \
    rm -rf $GOPATH && \
    apk del build-dependencies && \
    mkdir /evepraisal/db
WORKDIR /evepraisal/
CMD ["./evepraisal"]
