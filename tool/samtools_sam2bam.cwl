#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/samtools:1.9--h8ee4bcc_1

baseCommand: [samtools, view, -bS]
inputs:
  sam:
    type: File
    inputBinding:
      position: 1
  stderr_log_file_name:
    type: string

outputs:
  bam:
    type: stdout
  stderr_log:
    type: stderr
stdout: $(inputs.sam.nameroot).bam
stderr: $(inputs.stderr_log_file_name)
