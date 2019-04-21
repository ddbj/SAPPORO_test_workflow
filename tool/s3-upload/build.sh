#!/bin/sh
set -eux
cd $(dirname $0)
docker build -t suecharo/s3-upload .
