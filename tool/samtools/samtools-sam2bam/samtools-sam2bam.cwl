#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/samtools:1.9--h8ee4bcc_1
baseCommand: samtools
arguments:
  - position: 0
    valueFrom: view
  - position: 1
    valueFrom: -bS
inputs:
  nthreads:
    type: int?
    default: 2
    inputBinding:
      position: 1
      prefix: -@
  sam:
    type: File
    inputBinding:
      position: 3
outputs:
  bam:
    type: stdout
  stderr: stderr
stdout: $(inputs.sam.nameroot).bam
stderr: samtools-sam2bam-stderr.log
