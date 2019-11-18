#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
doc: Use fastq file as input and do trimming and quality check. Quality checks are done before trimming and after trimming.
requirements:
  MultipleInputFeatureRequirement: {}
inputs:
  fastq:
    type: File
    label: Fastq file from next generation sequencer
  nthreads:
    type: int?
    default: 2
    label: (optional) Number of cpu cores to be used
  aws_access_key_id:
    type: string
  aws_secret_access_key:
    type: string
  endpoint:
    type: string
    default: s3.amazonaws.com
  s3_bucket:
    type: string
  s3_upload_dir:
    type: string
    default: cwl_upload
steps:
  qc_fastq:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/fastqc/fastqc.cwl
    in:
      nthreads: nthreads
      fastq: fastq
    out:
      - qc_result
      - stdout
      - stderr
  trimming:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/trimmomatic/trimmomatic-se/trimmomatic-se.cwl
    in:
      nthreads: nthreads
      fastq: fastq
    out:
      - trimmed_fastq
      - stdout
      - stderr
  qc_trimmed_fastq:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/fastqc/fastqc.cwl
    in:
      nthreads: nthreads
      fastq: trimming/trimmed_fastq
    out:
      - qc_result
      - stdout
      - stderr
  s3-upload:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/s3-upload/s3-upload.cwl
    in:
      endpoint: endpoint
      s3_bucket: s3_bucket
      s3_upload_dir: s3_upload_dir
      upload_file_list:
        source:
          - qc_fastq/qc_result
          - trimming/trimmed_fastq
          - qc_trimmed_fastq/qc_result
      aws_access_key_id: aws_access_key_id
      aws_secret_access_key: aws_secret_access_key
    out:
      - upload_url
      - stderr
outputs:
  upload_url:
    type: File
    outputSource: s3-upload/upload_url
