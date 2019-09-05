#!/bin/sh
set -eux
endpoint=$1
s3_bucket=$2
s3_upload_dir=$3
mkdir -p s3-upload-tmp
for file in $(find . -type f); do
  if [ $file = "./upload_url.txt" ]; then
    continue
  fi
  if [ $file = "./s3-upload-stdout.log" ]; then
    continue
  fi
  if [ $file = "./s3-upload-stderr.log" ]; then
    continue
  fi
  cp $file ./s3-upload-tmp/
done

aws --endpoint="http://${endpoint}" s3 cp --recursive s3-upload-tmp "s3://${s3_bucket}/${s3_upload_dir}/"
printf "http://${endpoint}/${s3_bucket}/${s3_upload_dir}" >upload_url.txt
