#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

HELM_DIR="helm/cluster-api"
HELM_TEMPLATES_DIR="$HELM_DIR/templates"

MATCH="  objectSelector:\r    matchLabels:\r      cluster.x-k8s.io\/watch-filter: '{{ .Values.watchFilter }}'"

cd $HELM_TEMPLATES_DIR
for file in admissionregistration.k8s.io_v1_*.yaml; do
  NEW_CONTENTS=$(cat ${file} | tr '\n' '\r' | sed -e "s/${MATCH}/{{ if .Values.watchFilter }}\n${MATCH}\n{{ end }}/g" | tr '\r' '\n')

  printf "${NEW_CONTENTS}\n" > "${file}"
done

