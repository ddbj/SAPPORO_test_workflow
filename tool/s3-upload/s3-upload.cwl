#!/usr/bin/env cwl-runner
cwlVersion: v1.1
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerPull: suecharo/s3-upload
  EnvVarRequirement:
    envDef:
      - envName: AWS_ACCESS_KEY_ID
        envValue: $(inputs.aws_access_key_id)
      - envName: AWS_SECRET_ACCESS_KEY
        envValue: $(inputs.aws_secret_access_key)
  InitialWorkDirRequirement:
    listing: $(inputs.upload_file_list)
  NetworkAccess:
    networkAccess: true
baseCommand: sh
arguments:
  - position: 0
    valueFrom: /workdir/s3-upload.sh
inputs:
  endpoint:
    type: string?
    default: s3.amazonaws.com
    inputBinding:
      position: 1
  s3_bucket:
    type: string
    inputBinding:
      position: 2
  s3_upload_dir:
    type: string?
    default: cwl_upload
    inputBinding:
      position: 3
  upload_file_list:
    type: File[]
  aws_access_key_id:
    type: string
  aws_secret_access_key:
    type: string
outputs:
  upload_url:
    type: File
    outputBinding:
      glob: upload_url.txt
  stdout: stdout
  stderr: stderr
stdout: s3-upload-stdout.log
stderr: s3-upload-stderr.log
