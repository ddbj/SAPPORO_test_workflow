#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
doc: BWA-mapping-PE is a mapping workflow using BWA for Peared-end reads. It receives two fastq files and one reference genome. Please enter download link of fastq files and reference genome. The reference genome will be indexed by BWA. Trimming, QC and bam sort will do too. QC result and sam / bam file will be output.
requirements:
  MultipleInputFeatureRequirement: {}
inputs:
  fastq_1:
    type: File
    label: Fastq file from next generation sequencer
  fastq_2:
    type: File
    label: Fastq file from next generation sequencer
  fasta:
    type: File
    label: Fasta file
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
  qc_fastq_1:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/fastqc/fastqc.cwl
    in:
      nthreads: nthreads
      fastq: fastq_1
    out:
      - qc_result
      - stdout
      - stderr
  qc_fastq_2:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/fastqc/fastqc.cwl
    in:
      nthreads: nthreads
      fastq: fastq_2
    out:
      - qc_result
      - stdout
      - stderr
  trimming:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/trimmomatic/trimmomatic-pe/trimmomatic-pe.cwl
    in:
      nthreads: nthreads
      fastq_1: fastq_1
      fastq_2: fastq_2
    out:
      - trimmed_fastq1P
      - trimmed_fastq1U
      - trimmed_fastq2P
      - trimmed_fastq2U
      - stdout
      - stderr
  qc_trimmed_fastq_1:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/fastqc/fastqc.cwl
    in:
      nthreads: nthreads
      fastq: trimming/trimmed_fastq1P
    out:
      - qc_result
      - stdout
      - stderr
  qc_trimmed_fastq_2:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/fastqc/fastqc.cwl
    in:
      nthreads: nthreads
      fastq: trimming/trimmed_fastq2P
    out:
      - qc_result
      - stdout
      - stderr
  bwa-index-build:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/bwa/bwa-index/bwa-index.cwl
    in:
      fasta: fasta
    out:
      - amb
      - ann
      - bwt
      - pac
      - sa
      - stdout
      - stderr
  bwa-mapping:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/bwa/bwa-mapping-pe/bwa-mapping-pe.cwl
    in:
      nthreads: nthreads
      fasta: fasta
      amb: bwa-index-build/amb
      ann: bwa-index-build/ann
      bwt: bwa-index-build/bwt
      pac: bwa-index-build/pac
      sa: bwa-index-build/sa
      fastq_1: trimming/trimmed_fastq1P
      fastq_2: trimming/trimmed_fastq2P
    out:
      - sam
      - stderr
  sam2bam:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/samtools/samtools-sam2bam/samtools-sam2bam.cwl
    in:
      sam: bwa-mapping/sam
    out:
      - bam
      - stderr
  mark-duplicates:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/picard/picard-mark-duplicates/picard-mark-duplicates.cwl
    in:
      bam: sam2bam/bam
    out:
      - marked_bam
      - metrix
      - stdout
      - stderr
  sort-bam:
    run: https://raw.githubusercontent.com/ddbj/SAPPORO_test_workflow/master/tool/picard/picard-sort-bam/picard-sort-bam.cwl
    in:
      bam: mark-duplicates/marked_bam
    out:
      - sorted_bam
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
          - qc_fastq_1/qc_result
          - qc_fastq_2/qc_result
          - trimming/trimmed_fastq1P
          - trimming/trimmed_fastq1U
          - trimming/trimmed_fastq2P
          - trimming/trimmed_fastq2U
          - qc_trimmed_fastq_1/qc_result
          - qc_trimmed_fastq_2/qc_result
          - bwa-index-build/amb
          - bwa-index-build/ann
          - bwa-index-build/bwt
          - bwa-index-build/pac
          - bwa-index-build/sa
          - bwa-mapping/sam
          - sam2bam/bam
          - mark-duplicates/marked_bam
          - mark-duplicates/metrix
          - sort-bam/sorted_bam
      aws_access_key_id: aws_access_key_id
      aws_secret_access_key: aws_secret_access_key
    out:
      - upload_url
      - stderr
outputs:
  upload_url:
    type: File
    outputSource: s3-upload/upload_url
