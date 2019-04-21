#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/bwa:0.7.4--ha92aebf_0
baseCommand: bwa
arguments:
  - position: 0
    valueFrom: index
  - position: 1
    prefix: -p
    valueFrom: $(inputs.fasta.nameroot)
inputs:
  fasta:
    type: File
    inputBinding:
      position: 2
outputs:
  amb:
    type: File
    outputBinding:
      glob: $(inputs.fasta.nameroot).amb
  ann:
    type: File
    outputBinding:
      glob: $(inputs.fasta.nameroot).ann
  bwt:
    type: File
    outputBinding:
      glob: $(inputs.fasta.nameroot).bwt
  pac:
    type: File
    outputBinding:
      glob: $(inputs.fasta.nameroot).pac
  sa:
    type: File
    outputBinding:
      glob: $(inputs.fasta.nameroot).sa
  stdout: stdout
  stderr: stderr
stdout: bwa-index-stdout.log
stderr: bwa-index-stderr.log
