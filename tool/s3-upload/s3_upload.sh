#!/bin/sh
set -eux
upload_dir=$1
endpoint=$2
s3_bucket=$3
s3_upload_dir=$4

aws --endpoint="http://${endpoint}" s3 cp --recursive "${upload_dir}" "s3://${s3_bucket}/${s3_upload_dir}/" 1>&2
echo "http://${endpoint}/${s3_bucket}/${s3_upload_dir}"
