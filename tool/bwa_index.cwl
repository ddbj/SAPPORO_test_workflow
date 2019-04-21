#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/bwa:0.7.4--ha92aebf_0

baseCommand: [bwa, index]
arguments:
  - position: 1
    prefix: -p
    valueFrom: $(inputs.fasta.nameroot)
inputs:
  fasta:
    type: File
    inputBinding:
      position: 2
  stdout_log_file_name:
    type: string
  stderr_log_file_name:
    type: string

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
  stdout_log:
    type: stdout
  stderr_log:
    type: stderr
stdout: $(inputs.stdout_log_file_name)
stderr: $(inputs.stderr_log_file_name)
