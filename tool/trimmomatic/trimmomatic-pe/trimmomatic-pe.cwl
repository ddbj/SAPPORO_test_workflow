#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/trimmomatic:0.38--1

baseCommand: [java, -jar, /usr/local/share/trimmomatic/trimmomatic.jar, PE]
arguments:
  - position: 4
    valueFrom: $(inputs.fastq1.nameroot).trimed.1P.fastq
  - position: 5
    valueFrom: $(inputs.fastq1.nameroot).trimed.1U.fastq
  - position: 6
    valueFrom: $(inputs.fastq1.nameroot).trimed.2P.fastq
  - position: 7
    valueFrom: $(inputs.fastq1.nameroot).trimed.2U.fastq
  - position: 8
    valueFrom: ILLUMINACLIP:/usr/local/share/trimmomatic/adapters/TruSeq2-PE.fa:2:40:15
inputs:
  nthreads:
    type: int?
    default: 2
    inputBinding:
      position: 1
      prefix: -threads
  fastq1:
    type: File
    inputBinding:
      position: 2
  fastq2:
    type: File
    inputBinding:
      position: 3
  stdout_log_file_name:
    type: string
  stderr_log_file_name:
    type: string

outputs:
  trimed_fastq1P:
    type: File
    outputBinding:
      glob: $(inputs.fastq1.nameroot).trimed.1P.fastq
  trimed_fastq1U:
    type: File
    outputBinding:
      glob: $(inputs.fastq1.nameroot).trimed.1U.fastq
  trimed_fastq2P:
    type: File
    outputBinding:
      glob: $(inputs.fastq1.nameroot).trimed.2P.fastq
  trimed_fastq2U:
    type: File
    outputBinding:
      glob: $(inputs.fastq1.nameroot).trimed.2U.fastq
  stdout_log:
    type: stdout
  stderr_log:
    type: stderr
stdout: $(inputs.stdout_log_file_name)
stderr: $(inputs.stderr_log_file_name)
