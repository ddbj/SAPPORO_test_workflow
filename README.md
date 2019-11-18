# SAPPORO Test Workflow

Workflows written in common workflow language (CWL) for testing SAPPORO

# Run a workflow

(Plesae see how to install cwltool: https://github.com/common-workflow-language/cwltool)

To run a workflow named `workflow/trimming_and_qc/trimming_and_qc`, type as follows:

```shell
$ cwltool --outdir output ./workflow/trimming_and_qc/trimming_and_qc_no_upload/trimming_and_qc_no_upload.cwl ./test/workflow/job/trimming_and_qc_no_upload.yml
```

# Visualize `trimming_and_qc_no_upload.cwl`

(Visualize at 2019-1-20 using CWL Viewer https://view.commonwl.org)

[![trimming_and_qc_no_upload.cwl](https://github.com/ddbj/SAPPORO_test_workflow/blob/master/fig/graph.png "trimming_and_qc_no_upload.cwl")](https://view.commonwl.org/workflows/github.com/ddbj/SAPPORO_test_workflow/blob/master/workflow/trimming-and-qc/trimming-and-qc-no-upload/trimming-and-qc-no-upload.cwl)
