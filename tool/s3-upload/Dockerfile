FROM alpine:3.6
RUN apk --update add --no-cache \
    groff \
    less \
    mailcap \
    py-pip \
    python && \
    pip install awscli s3cmd python-magic
USER root
WORKDIR /workdir
COPY s3-upload.sh /workdir/
