#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Wraps object selectors in conditions.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"

# Define object selector.
selector="  objectSelector:\r    matchLabels:\r      cluster.x-k8s.io\/watch-filter: '{{ .Values.watchFilter }}'"

# Iterate webhooks.
for file in "${repository}/helm/cluster-api/templates/admissionregistration.k8s.io_v1_"*".yaml"
do
    # Wrap object selector in condition.
    cat "${file}" | tr "\n" "\r" | sed "s/${selector}/{{ if .Values.watchFilter }}\n${selector}\n{{ end }}/g" | tr "\r" "\n" > "${file}.new"

    # Replace file with new content.
    mv "${file}.new" "${file}"
done
