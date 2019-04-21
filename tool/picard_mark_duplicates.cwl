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
    MarkDuplicates,
    ASSUME_SORT_ORDER=queryname,
  ]
arguments:
  - position: 2
    valueFrom: O=$(inputs.bam.nameroot).mark.bam
  - position: 3
    valueFrom: M=$(inputs.bam.nameroot).mark.metrix.txt

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
  marked_bam:
    type: File
    outputBinding:
      glob: "*.mark.bam"
  metrix:
    type: File
    outputBinding:
      glob: "*.mark.metrix.txt"
  stdout_log:
    type: stdout
  stderr_log:
    type: stderr
stdout: $(inputs.stdout_log_file_name)
stderr: $(inputs.stderr_log_file_name)
