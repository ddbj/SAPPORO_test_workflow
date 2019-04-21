#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/picard:2.18.20--0
baseCommand: picard
arguments:
  - position: 0
    valueFrom: MarkDuplicates
  - position: 1
    valueFrom: ASSUME_SORT_ORDER=queryname
  - position: 3
    valueFrom: O=$(inputs.bam.nameroot).mark.bam
  - position: 4
    valueFrom: M=$(inputs.bam.nameroot).mark.metrix.txt
inputs:
  bam:
    type: File
    inputBinding:
      position: 2
      prefix: I=
      separate: False
outputs:
  marked_bam:
    type: File
    outputBinding:
      glob: "*.mark.bam"
  metrix:
    type: File
    outputBinding:
      glob: "*.mark.metrix.txt"
  stdout: stdout
  stderr: stderr
stdout: picard-mark-duplicates-stdout.log
stderr: picard-mark-duplicates-stderr.log
