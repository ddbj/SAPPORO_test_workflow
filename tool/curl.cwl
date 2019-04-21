#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: appropriate/curl:latest

baseCommand: [curl]
arguments:
  - position: 1
    valueFrom: -L
inputs:
  download_url:
    type: string
    inputBinding:
      position: 2
  downloaded_file_name:
    type: string
  stderr_log_file_name:
    type: string

outputs:
  downloaded_file:
    type: stdout
  stderr_log:
    type: stderr
stdout: $(inputs.downloaded_file_name)
stderr: $(inputs.stderr_log_file_name)
