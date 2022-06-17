#!/usr/bin/env bash

EVENT_DATA=$1

export HOME="/tmp/ansible_home"
export DEFAULT_LOCAL_TMP="/tmp/ansible"

export OPENBLAS_NUM_THREADS='1'
export NUMEXPR_NUM_THREADS='1'
export MKL_NUM_THREADS='1'

echo "$EVENT_DATA"

export PYTHONPATH=./lib
echo "RUNNING Playbook "
python3 ./lib/bin/ansible-playbook playbook.yaml
echo "Playbook Return Status $?"

exit 0
