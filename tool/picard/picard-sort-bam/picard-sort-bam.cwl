#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/picard:2.18.20--0
baseCommand: picard
arguments:
  - position: 0
    valueFrom: SortSam
  - position: 1
    valueFrom: SORT_ORDER=coordinate
  - position: 3
    valueFrom: O=$(inputs.bam.nameroot).sort.bam
inputs:
  bam:
    type: File
    inputBinding:
      position: 2
      prefix: I=
      separate: False
outputs:
  sorted_bam:
    type: File
    outputBinding:
      glob: "*.sort.bam"
  stdout: stdout
  stderr: stderr
stdout: picard-sort-bam-stdout.log
stderr: picard-sort-bam-stderr.log
