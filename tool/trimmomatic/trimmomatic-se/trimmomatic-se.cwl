#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/trimmomatic:0.38--1
baseCommand: trimmomatic
arguments:
  - position: 0
    valueFrom: SE
  - position: 3
    valueFrom: $(inputs.fastq.nameroot).trimed.fq
  - position: 4
    valueFrom: ILLUMINACLIP:/usr/local/share/trimmomatic/adapters/TruSeq2-SE.fa:2:40:15
  - position: 5
    valueFrom: LEADING:20
  - position: 6
    valueFrom: TRAILING:20
  - position: 7
    valueFrom: SLIDINGWINDOW:4:15
  - position: 8
    valueFrom: MINLEN:36
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
outputs:
  trimed_fastq:
    type: File
    outputBinding:
      glob: $(inputs.fastq.nameroot).trimed.fq
  stdout: stdout
  stderr: stderr
stdout: trimmomatic-se-stdout.log
stderr: trimmomatic-se-stderr.log
