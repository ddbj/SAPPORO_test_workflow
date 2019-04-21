#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/fastqc:0.11.7--pl5.22.0_2

baseCommand: [fastqc]
arguments:
  - position: 1
    prefix: -o
    valueFrom: .
inputs:
  nthreads:
    type: int?
    default: 2
    inputBinding:
      position: 2
      prefix: --threads
  fastq:
    type: File
    inputBinding:
      position: 3
  stdout_log_file_name:
    type: string
  stderr_log_file_name:
    type: string

outputs:
  qc_result:
    type: File
    outputBinding:
      glob: "*_fastqc.html"
  stdout_log:
    type: stdout
  stderr_log:
    type: stderr
stdout: $(inputs.stdout_log_file_name)
stderr: $(inputs.stderr_log_file_name)
