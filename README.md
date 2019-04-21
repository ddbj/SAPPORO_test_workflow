# SAPPORO Test Workflow

Workflows written in common workflow language (CWL) for testing SAPPORO

# Run a workflow

(Plesae see how to install cwltool: https://github.com/common-workflow-language/cwltool)

To run a workflow named trimming_and_qc_no_upload.cwl, type as follows:

```shell
$ cp ./test/workflow/test_job/trimming_and_qc_no_upload.yml ./
$ vim trimming_and_qc_no_upload.yml
$ cwltool --outdir output ./workflow/trimming_and_qc/trimming_and_qc_no_upload/trimming_and_qc_no_upload.cwl ./trimming_and_qc_no_upload.yml
```

# Visualize `trimming_and_qc_no_upload.cwl`

(Visualize at 2019-1-20 using CWL Viewer https://view.commonwl.org)

[![trimming_and_qc.cwl](https://github.com/suecharo/test-workflow/raw/master/image/graph.png "trimming_and_qc.cwl")](https://view.commonwl.org/workflows/github.com/suecharo/test-workflow/blob/master/workflow/trimming_and_qc.cwl)
