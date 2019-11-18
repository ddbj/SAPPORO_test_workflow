#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
doc: Use fastq file as input and do trimming and quality check. Quality checks are done before trimming and after trimming.
inputs:
  fastq:
    type: File
    label: Fastq file from next generation sequencer
  nthreads:
    type: int?
    default: 2
    label: (optional) Number of cpu cores to be used
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
outputs:
  qc_fastq_result:
    type: File
    outputSource: qc_fastq/qc_result
  trimming_trimmed_fastq:
    type: File
    outputSource: trimming/trimmed_fastq
  qc_trimmed_fastq_result:
    type: File
    outputSource: qc_trimmed_fastq/qc_result
