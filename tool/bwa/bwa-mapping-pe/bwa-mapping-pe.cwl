#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/bwa:0.7.15--1
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.fasta)
        entryname: $(inputs.fasta.basename)
      - entry: $(inputs.amb)
        entryname: $(inputs.amb.basename)
      - entry: $(inputs.ann)
        entryname: $(inputs.ann.basename)
      - entry: $(inputs.bwt)
        entryname: $(inputs.bwt.basename)
      - entry: $(inputs.pac)
        entryname: $(inputs.pac.basename)
      - entry: $(inputs.sa)
        entryname: $(inputs.sa.basename)
baseCommand: bwa
arguments:
  - position: 0
    valueFrom: mem
  - position: 1
    valueFrom: -K
  - position: 2
    valueFrom: "100000000"
  - position: 3
    valueFrom: -Y
  - position: 4
    valueFrom: -p
  - position: 6
    valueFrom: $(inputs.fasta.dirname)/$(inputs.fasta.nameroot)
inputs:
  nthreads:
    type: int?
    default: 2
    inputBinding:
      position: 5
      prefix: -t
  fastq_1:
    type: File
    inputBinding:
      position: 7
  fastq_2:
    type: File
    inputBinding:
      position: 8
  fasta:
    type: File
  amb:
    type: File
  ann:
    type: File
  bwt:
    type: File
  pac:
    type: File
  sa:
    type: File
outputs:
  sam:
    type: stdout
  stderr: stderr
stdout: $(inputs.fastq_1.nameroot).sam
stderr: bwa-mapping-pe-stderr.log
