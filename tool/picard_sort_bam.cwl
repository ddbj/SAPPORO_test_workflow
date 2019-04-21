#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/picard:2.18.20--0

baseCommand:
  [
    java,
    -jar,
    /usr/local/share/picard-2.18.20-0/picard.jar,
    SortSam,
    SORT_ORDER=coordinate,
  ]
arguments:
  - position: 2
    valueFrom: O=$(inputs.bam.nameroot).sort.bam

inputs:
  bam:
    type: File
    inputBinding:
      position: 1
      prefix: I=
      separate: False
  stdout_log_file_name:
    type: string
  stderr_log_file_name:
    type: string

outputs:
  sorted_bam:
    type: File
    outputBinding:
      glob: "*.sort.bam"
  stdout_log:
    type: stdout
  stderr_log:
    type: stderr
stdout: $(inputs.stdout_log_file_name)
stderr: $(inputs.stderr_log_file_name)
