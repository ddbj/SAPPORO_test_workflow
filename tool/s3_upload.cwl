#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: suecharo/s3_upload
  EnvVarRequirement:
    envDef:
      - envName: AWS_ACCESS_KEY_ID
        envValue: $(inputs.aws_access_key_id)
      - envName: AWS_SECRET_ACCESS_KEY
        envValue: $(inputs.aws_secret_access_key)
  InitialWorkDirRequirement:
    listing: $(inputs.upload_file_list)
baseCommand: [/bin/sh, /opt/s3_upload.sh]
arguments: [
  {valueFrom: "${return inputs.upload_file_list[0].dirname;}"},
  $(inputs.endpoint),
  $(inputs.s3_bucket),
  $(inputs.s3_upload_dir),
]

inputs:
  aws_access_key_id:
    type: string
  aws_secret_access_key:
    type: string
  upload_file_list:
    type: File[]
  endpoint:
    type: string?
    default: s3.amazonaws.com
  s3_bucket:
    type: string
  s3_upload_dir:
    type: string?
    default: sapporo_upload
  upload_url_file_name:
    type: string?
    default: upload_url.txt
  stderr_log_file_name:
    type: string

outputs:
  upload_url:
    type: stdout
  stderr_log:
    type: stderr
stdout: $(inputs.upload_url_file_name)
stderr: $(inputs.stderr_log_file_name)
