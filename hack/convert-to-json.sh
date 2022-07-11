#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

BASE_DIR="helm/cluster-api/files"

for f in $(find helm/cluster-api/files -type f -name '*.yaml')
do
  yq -I 0 -o json ${f} > ${f/%.yaml/.json}
  rm ${f}
done
