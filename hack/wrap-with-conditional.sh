#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

cd "helm/cluster-api/templates"

for file in admissionregistration.k8s.io_v1_*.yaml; do
    match="  objectSelector:\r    matchLabels:\r      cluster.x-k8s.io\/watch-filter: '{{ .Values.watchFilter }}'"
    new_content=$(tr '\n' '\r' < "${file}" | sed -e "s/${match}/{{ if .Values.watchFilter }}\n${match}\n{{ end }}/g" | tr '\r' '\n')
    printf "%s\n" "${new_content}" > "${file}"
done
