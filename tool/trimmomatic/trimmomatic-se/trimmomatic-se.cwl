#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/trimmomatic:0.38--1

baseCommand: [java, -jar, /usr/local/share/trimmomatic/trimmomatic.jar, SE]
arguments:
  - position: 3
    valueFrom: $(inputs.fastq.nameroot).trimed.fq
  - position: 4
    valueFrom: ILLUMINACLIP:/usr/local/share/trimmomatic/adapters/TruSeq2-SE.fa:2:40:15
inputs:
  nthreads:
    type: int?
    default: 2
    inputBinding:
      position: 1
      prefix: -threads
  fastq:
    type: File
    inputBinding:
      position: 2
  stdout_log_file_name:
    type: string
  stderr_log_file_name:
    type: string

outputs:
  trimed_fastq:
    type: File
    outputBinding:
      glob: $(inputs.fastq.nameroot).trimed.fq
  stdout_log:
    type: stdout
  stderr_log:
    type: stderr
stdout: $(inputs.stdout_log_file_name)
stderr: $(inputs.stderr_log_file_name)
