#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

cd "helm/cluster-api/templates"

readonly match="  objectSelector:\r    matchLabels:\r      cluster.x-k8s.io\/watch-filter: '{{ .Values.watchFilter }}'"

for file in admissionregistration.k8s.io_v1_*.yaml; do
  new_content=$(tr '\n' '\r' < "${file}" | sed -e "s/${match}/{{ if .Values.watchFilter }}\n${match}\n{{ end }}/g" | tr '\r' '\n')
  printf "%s\n" "${new_content}" > "${file}"
done

for file in *_ciliumnetworkpolicy_*.yaml; do
    data=$(cat "${file}")
    echo '{{- if .Values.ciliumNetworkPolicy.enabled }}' > "${file}"
    echo "${data}" >> "${file}"
    echo '{{- end }}' >> "${file}"
done
