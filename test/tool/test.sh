#!/bin/sh
set -eux

if [ $# -ne 1 ]; then
  echo "Usage: bash test.sh tool_name"
  exit 1
fi

tool_name=$1
test_dir=$(cd $(dirname $0) && pwd)
root_dir=$(cd ${test_dir}/../.. && pwd)
tool_dir=$(find ${root_dir}/tool -type d | grep ${tool_name})

echo "*** TEST START: ${tool_name} ***"
echo "...checking tool dir"
# tool dir が存在するか
if [ ! -d ${tool_dir} ]; then
  echo "[ERROR] ${tool_dir} does not exist."
  exit 1
else
  echo "[PASS] tool dir exists."
fi

cwl_file=${tool_dir}/${tool_name}.cwl

echo "...checking cwl file"
# cwl file が存在するか
if [ ! -f ${cwl_file} ]; then
  echo "[ERROR] ${cwl_file} does not exist."
  exit 1
else
  echo "[PASS] cwlfile exists."
fi

echo "...validating by cwltool"
# cwltool の validation
cwltool --validate ${cwl_file}
if [ $? -ne 0 ]; then
  echo "[ERROR] cwltool validation is failed."
  exit 1
else
  echo "[PASS] cwltool validation is passed."
fi

# template を作成しておく
cwl_template_file=${tool_dir}/${tool_name}.yml
cwltool --make-template ${cwl_file} > ${cwl_template_file}

# Dockerfile が存在する場合、build を行っておく
dockerfile=${tool_dir}/Dockerfile
if [ -f ${dockerfile} ]; then
  echo "...doing docker build"
  build_file=${tool_dir}/build.sh
  bash ${build_file}
  if [ $? -ne 0 ]; then
    echo "[ERROR] Docker build is failed."
    exit 1
  else
    echo "[PASS] Docker build is passed."
  fi
fi

# test_job を使って、実際に実行する
echo "...doing test job"
test_job_file=${test_dir}/test_job/${tool_name}.yml
if [ ! -f ${test_job_file} ]; then
  echo "[ERROR] ${test_job_file} does not exist."
  exit 1
else
  echo "test job file exists."
fi
cwltool --outdir ${test_dir}/tmp ${cwl_file} ${test_job_file}
if [ $? -ne 0 ]; then
  echo "[ERROR] test job is failed."
  exit 1
else
  echo "[PASS] test job is passed."
fi
rm -rf ${test_dir}/tmp

echo "*** ALL TEST IS PASSED ***"
